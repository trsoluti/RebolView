//
//  rebollibTests.m
//  rebollibTests
//
//  Created by TR Solutions on 29/9/13.
//  Copyright (c) 2013 TR Solutions. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RBVStdio.h"
#define HAS_BOOL
#import "reb-c.h"
#import "reb-device.h"
extern DEVICE_CMD Write_IO(REBREQ *req);

@interface rbvStdioTests : XCTestCase

@end

@implementation rbvStdioTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMainStdio
{
    RBVStdio * mainStdio = [RBVStdio mainStdio];
    RBVStdio * secondaryStdio = [RBVStdio mainStdio];
  if (mainStdio != secondaryStdio) {
    XCTFail(@"mainStdio not always returning same object");
  }
}

- (void)testWriteToString
{
  RBVStdio * mainStdio = [RBVStdio mainStdio];
  [mainStdio startRedirectToString];
  // write request is packed differently,
  // so we have to fake the whole thing
  unsigned char writeRequest[100]; // in RBVStdio.m, REBREQ is 100 bytes
  u32    *  pModes  = (u32 *)(writeRequest+40);
  REBYTE ** pData   = (REBYTE **)(writeRequest+52);
  u32    *  pLength = (u32 *)(writeRequest+60);

  *pModes  = 0;
  *pData   = (REBYTE *)"hello";
  *pLength = strlen((const char *)*pData);
  
  i32 returnCode = Write_IO((REBREQ *)&writeRequest);
  if (returnCode != DR_DONE) {
    XCTFail(@"Write_IO failed with code (%ld)", returnCode);
  }
  NSString *writtenString = [mainStdio stopRedirectToString];
  XCTAssert([writtenString isEqualToString:@"hello"], @"Written string does not match.");
}

@end
