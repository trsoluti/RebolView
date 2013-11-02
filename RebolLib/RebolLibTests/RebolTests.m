//
//  RebolTests.m
//  rebollib
//
//  Created by TR Solutions on 17/10/13.
//  Copyright (c) 2013 TR Solutions. All rights reserved.
//

#import <XCTest/XCTest.h>
#include "RBVStdio.h"
#define HAS_BOOL  // yes, I already have a bool, no need to use Rebol's
#import "reb-host.h"
#define OS_LIB_TABLE // include the host-lib dispatch table
#import "host-lib.h"

@interface RebolTests : XCTestCase {
  REBARGS _mainArgs; // as a structure so we don't have to calloc/free
}
@property (readonly) RBVStdio *stdio;
@property (readonly) REBARGS *mainArgs;
// these two are filled in by doString
@property RXIARG result;
@property REBYTE resultType;
@end

@implementation RebolTests

- (REBARGS *)mainArgs { return &self->_mainArgs; }

- (void)setUp
{
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
  REBYTE vers[8];
  
  Host_Lib = &Host_Lib_Init;
  
  CLEARS([self mainArgs]);
  NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
  [self mainArgs]->exe_path = (REBCHR *)[bundlePath cStringUsingEncoding:NSUTF8StringEncoding];
  OS_Get_Current_Dir(&[self mainArgs]->home_dir);
  
  vers[0] = 5; // len
  RL_Version(&vers[0]);
  
  
  // Initialize the REBOL library (reb-lib):
  RL_Init([self mainArgs], Host_Lib);
  
  RL_Start(0, 0, 0);
  
  // for now, everyone shares the same stdio
  self->_stdio = [RBVStdio mainStdio];
}
  
- (void)doString:(NSString *)string
{
  RXIARG result;
  [self setResultType:RL_Do_String((REBYTE *)[string cStringUsingEncoding:NSUTF8StringEncoding], 0, &result)];
  [self setResult:result];
}


- (void)tearDown
{
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testEvaluatingBlocks
{
  NSArray * examples = @[
    @{@"name": @"Evaluation, not execution, example 1", @"in": @"print 1 + 2",                   @"out": @"3\n"},
    @{@"name": @"Evaluation, not execution, example 2", @"in": @"print length? \"example\"",     @"out": @"7\n"},
    @{@"name": @"Evaluation, not execution, example 3", @"in": @"print 1 + length? \"example\"", @"out": @"8\n"},
    @{@"name": @"Code is held in blocks, example 1",    @"in": @"if 10 > 4 [print 1 + 2]",       @"out": @"3\n"},
    @{@"name": @"Code is held in blocks, example 2",    @"in": @"loop 3 [print 1 + 2]",          @"out": @"3\n3\n3\n"},
    @{@"name": @"Blocks return results, example 2",     @"in": @"1 + 2",                         @"out": @""}, // note: not a console here, so won't display block result. See block return below.
    @{@"name": @"Blocks aren't always evaluated, example 1", @"in": @"if 4 > 10 [print 1 + 2]",  @"out": @""},
    @{@"name": @"Blocks aren't always evaluated, example 2", @"in": @"loop 0 [print 1 + 2]",     @"out": @""},
    @{@"name": @"Code is data and data can be code, example 1", @"in":@"blk: [print 1 + 2]\n if 10 > 4 blk", @"out": @"3\n"},
    @{@"name": @"Code is data and data can be code, example 2", @"in":@"loop 3 blk",             @"out": @"3\n3\n3\n"},
    @{@"name": @"Code is data and data can be code, example 3", @"in":@"print length? blk",      @"out": @"4\n"},
    @{@"name": @"Code is data and data can be code, example 4", @"in":@"print first blk",        @"out": @"print\n"},
    @{@"name": @"Code is data and data can be code, example 5", @"in":@"print last blk",         @"out": @"2\n"},
  ];
  
  [examples enumerateObjectsUsingBlock:^(NSDictionary * example, NSUInteger idx, BOOL *stop) {
    [[self stdio] startRedirectToString];
    [self doString:example[@"in"]];
    NSString * result = [[self stdio] stopRedirectToString];
    *stop = ![result isEqualToString:example[@"out"]];
    XCTAssert(!*stop, @"%@: expected '%@', got '%@'", example[@"name"], example[@"out"], result);
  }];
}

- (void)testBlocksReturnResults
{
  [[self stdio] startRedirectToString];
  [self doString:@"1 + 2"]; // Blocks return results, example 2
  XCTAssert([self resultType] == RXT_INTEGER, @"Expected Integer (%d) result type, got %d", RXT_INTEGER, [self resultType]);
  XCTAssert([self result].int64 == 3, @"Expected result value 3, got %lld", [self result].int64);

  [[self stdio] startRedirectToString];
  [self doString:@"do [1 + 2]"]; // Blocks return results, example 3
  XCTAssert([self resultType] == RXT_INTEGER, @"Expected Integer (%d) result type, got %d", RXT_INTEGER, [self resultType]);
  XCTAssert([self result].int64 == 3, @"Expected result value 3, got %lld", [self result].int64);
}

- (void)testBlocksArentAlwaysEvaluated
{
  [[self stdio] startRedirectToString];
  [self doString:@"if 4 > 10 [print 1 + 2]"]; // Blocks aren't always evaluated, example 3
  XCTAssert([self resultType] == RXT_NONE, @"Expected None (%d) result type, got %d", RXT_NONE, [self resultType]);
}

@end
