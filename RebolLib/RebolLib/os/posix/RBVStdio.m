/***********************************************************************
 **
 **  REBOL [R3] Language Interpreter and Run-time Environment
 **
 **  Copyright 2012 REBOL Technologies
 **  REBOL is a trademark of REBOL Technologies
 **
 **  Licensed under the Apache License, Version 2.0 (the "License");
 **  you may not use this file except in compliance with the License.
 **  You may obtain a copy of the License at
 **
 **  http://www.apache.org/licenses/LICENSE-2.0
 **
 **  Unless required by applicable law or agreed to in writing, software
 **  distributed under the License is distributed on an "AS IS" BASIS,
 **  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 **  See the License for the specific language governing permissions and
 **  limitations under the License.
 **
 ************************************************************************
 **
 **  Title: Device: Standard I/O for Webkit environment
 **  Author: Carl Sassenrath
 **  Purpose:
 **      Provides basic I/O streams support for redirection and
 **      opening a console window if necessary.
 **
 ************************************************************************
 **
 **  NOTE to PROGRAMMERS:
 **
 **    1. Keep code clear and simple.
 **    2. Document unusual code, reasoning, or gotchas.
 **    3. Use same style for code, vars, indent(4), comments, etc.
 **    4. Keep in mind Linux, OS X, BSD, big/little endian CPUs.
 **    5. Test everything, then test it again.
 **
 ***********************************************************************/


#import "RBVStdio.h"
#define HAS_BOOL  // TOD 2013-05-30: we have a bool already, don't need rebol's.
#import "reb-c.h"
#import "reb-device.h"

@interface RBVStdio ()
@property NSMutableString *redirectedOutput;
- (NSUInteger)writeToString:(REBYTE *)theData ofLength:(u32)theLength;
- (BOOL)isRedirectedOutput;
@end

static RBVStdio *_mainStdio;

@implementation RBVStdio
+ (RBVStdio *)mainStdio
{
  if (_mainStdio == nil) {
    _mainStdio = [[RBVStdio alloc] init];
  }
  return _mainStdio;
}
- (id) init
{
  self = [super init];
  if (self) {
    [self setRedirectedOutput:nil]; // nil means no redirection in progress
  }
  return  self;
}
- (void)startRedirectToString
{
  [self setRedirectedOutput:[NSMutableString stringWithCapacity:0]];
}
- (NSUInteger)writeToString:(REBYTE *)theData ofLength:(u32)theLength
{
  if (![self isRedirectedOutput]) {
    return 0; // or should it return length and then this can act as null device?
  }
  NSString *dataInStringFormat = [[NSString alloc] initWithBytes:theData length:theLength encoding:NSUTF8StringEncoding];
  [[self redirectedOutput] appendString:dataInStringFormat];
  return theLength;
}
- (NSString *)stopRedirectToString
{
  NSString *returnString = [self redirectedOutput];
  [self setRedirectedOutput:nil];
  return returnString;
}

- (BOOL)isRedirectedOutput
{
  return [self redirectedOutput] != nil;
}
@end

#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

#include "reb-host.h"
#include "host-lib.h"

#define BUF_SIZE (16*1024)

#define SF_DEV_NULL 31		// local flag to mark NULL device

// Temporary globals: (either move or remove?!)
static int Std_Inp = 0;
static int Std_Out = 1;
static FILE *Std_Echo = 0;

//static REBOOL Redir_Out = 0; // redirection flags TOD 2013-05-30 Removed, never used in code
//static REBOOL Redir_Inp = 0; // TOD 2013-05-30 Removed, never used in code

#define PUTE(s)		if (Std_Echo) fputs(s, Std_Echo)

extern REBDEV *Devices[];

#ifndef HAS_SMART_CONSOLE	// console line-editing and recall needed
void *Init_Terminal();
void Quit_Terminal(void*);
int  Read_Line(void*, char*, int);
#endif

void Put_Str(char *buf);

void *Term_IO;

/*
 #define	PUTS(s)		fputs(s, stdout)
 #define GETS(s,len)	fgets(s, len, stdin);
 #define FLUSH()		fflush(stdout)
 */

static void Handle_Signal(int sig)
{
	char *buf = strdup("[escape]");
	Put_Str(buf);
	free(buf);
	RL_Escape(0);
}

static void Init_Signals(void)
{
	signal(SIGINT, Handle_Signal);
	signal(SIGHUP, Handle_Signal);
	signal(SIGTERM, Handle_Signal);
}

static void close_stdio(void)
{
#ifndef HAS_SMART_CONSOLE
	if (Term_IO) {
		Quit_Terminal(Term_IO);
		Term_IO = 0;
	}
#endif
	if (Std_Echo) {
		fclose(Std_Echo);
		Std_Echo = 0;
	}
}

/***********************************************************************
 **
 */	DEVICE_CMD Quit_IO(REBREQ *dr)
/*
 ***********************************************************************/
{
	REBDEV *dev = (REBDEV*)dr; // just to keep compiler happy above
  
	close_stdio();
  
	CLR_FLAG(dev->flags, RDF_OPEN);
	return DR_DONE;
}


/***********************************************************************
 **
 */	DEVICE_CMD Open_IO(REBREQ *req)
/*
 ***********************************************************************/
{
	REBDEV *dev;
  
	dev = Devices[req->device];
  
	// Avoid opening the console twice (compare dev and req flags):
	if (GET_FLAG(dev->flags, RDF_OPEN)) {
		// Device was opened earlier as null, so req must have that flag:
		if (GET_FLAG(dev->flags, SF_DEV_NULL))
			SET_FLAG(req->modes, RDM_NULL);
		SET_FLAG(req->flags, RRF_OPEN);
		return DR_DONE; // Do not do it again
	}
  
	Init_Signals();
  
	if (!GET_FLAG(req->modes, RDM_NULL)) {
    
#ifndef HAS_SMART_CONSOLE
		if (isatty(Std_Inp))
			Term_IO = Init_Terminal();
		else
#endif
			Term_IO = 0;
		//printf("%x\r\n", req->handle);
	}
	else
		SET_FLAG(dev->flags, SF_DEV_NULL);
  
	SET_FLAG(req->flags, RRF_OPEN);
	SET_FLAG(dev->flags, RDF_OPEN);
  
	return DR_DONE;
}


/***********************************************************************
 **
 */	DEVICE_CMD Close_IO(REBREQ *req)
/*
 ***********************************************************************/
{
	//REBDEV *dev = Devices[req->device]; // TOD 2013-05-30 Removed, variable never used.
  
	close_stdio();
  
	CLR_FLAG(req->flags, RRF_OPEN);
  
	return DR_DONE;
}


/***********************************************************************
 **
 */	DEVICE_CMD Write_IO(REBREQ *req)
/*
 **		Low level "raw" standard output function.
 **
 **		Allowed to restrict the write to a max OS buffer size.
 **
 **		Returns the number of chars written.
 **
 ***********************************************************************/
{
  // TODO: determine from the string class if we need to write to the buffer string instead
	long total;
  
	if (GET_FLAG(req->modes, RDM_NULL)) {
		req->actual = req->length;
		return DR_DONE;
	}
  
	if (Std_Out >= 0) {
  
    // TOD 2013-05-30: check if redirected output. If so, send the output to the RBVStudio main instance
    if ([[RBVStdio mainStdio] isRedirectedOutput]) {
      total = [[RBVStdio mainStdio] writeToString:req->data ofLength:req->length];
    }
    // TOD 2013-05-30: for now, continue with the regular output, so we can verify our string
		total = write(Std_Out, req->data, req->length);
    
		if (total < 0) {
			req->error = errno;
			return DR_ERROR;
		}
    
		//if (GET_FLAG(req->flags, RRF_FLUSH)) {
    //FLUSH();
		//}
    
		req->actual = total;
	}
  
	if (Std_Echo) {
		fwrite(req->data, req->length, 1, Std_Echo);
		//fflush(Std_Echo); //slow!
	}
  
	return DR_DONE;
}


/***********************************************************************
 **
 */	DEVICE_CMD Read_IO(REBREQ *req)
/*
 **		Low level "raw" standard input function.
 **
 **		The request buffer must be long enough to hold result.
 **
 **		Result is NOT terminated (the actual field has length.)
 **
 ***********************************************************************/
{
	long total = 0;
	int len = (int)req->length; // TOD 2013-05-30 added cast to int to remove warning message
  
	if (GET_FLAG(req->modes, RDM_NULL)) {
		req->data[0] = 0;
		return DR_DONE;
	}
  
	req->actual = 0;
  
	if (Std_Inp >= 0) {
    
		// Perform a processed read or a raw read?
#ifndef HAS_SMART_CONSOLE
		if (Term_IO)
			total = Read_Line(Term_IO, (char *)req->data, len); // TOD 2013-05-30 added cast to char to remove warning message
		else
#endif
			total = read(Std_Inp, req->data, len);
    
		if (total < 0) {
			req->error = errno;
			return DR_ERROR;
		}
    
		req->actual = total;
	}
  
	return DR_DONE;
}


/***********************************************************************
 **
 */	DEVICE_CMD Open_Echo(REBREQ *req)
/*
 **		Open a file for low-level console echo (output).
 **
 ***********************************************************************/
{
	if (Std_Echo) {
		fclose(Std_Echo);
		Std_Echo = 0;
	}
  
	if (req->file.path) {
		Std_Echo = fopen((const char *)req->file.path, "w");  // null on error TOD 2013-05-30 added cast to const char * to remove warning message
		if (!Std_Echo) {
			req->error = errno;
			return DR_ERROR;
		}
	}
  
	return DR_DONE;
}


/***********************************************************************
 **
 **	Command Dispatch Table (RDC_ enum order)
 **
 ***********************************************************************/

static DEVICE_CMD_FUNC Dev_Cmds[RDC_MAX] =
{
	0,	// init
	Quit_IO,
	Open_IO,
	Close_IO,
	Read_IO,
	Write_IO,
	0,	// poll
	0,	// connect
	0,	// query
	0,	// modify
	Open_Echo,	// CREATE used for opening echo file
};

DEFINE_DEV(Dev_StdIO, "Standard IO", 1, Dev_Cmds, RDC_MAX, 0);
