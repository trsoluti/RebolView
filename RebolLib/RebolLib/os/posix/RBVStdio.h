//
//  RBVStdio.h
//  rebollib
//
//  Created by TR Solutions on 29/5/13.
//  Copyright (c) 2013 TR Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBVStdio : NSObject
+ (RBVStdio *)mainStdio; // used by UI to manipulate stdio behind the scenes
- (void)startRedirectToString;
- (NSString *)stopRedirectToString;
@end
