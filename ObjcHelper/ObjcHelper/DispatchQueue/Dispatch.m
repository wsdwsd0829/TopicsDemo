//
//  Dispatch.m
//  ObjcHelper
//
//  Created by Sida Wang on 6/27/17.
//  Copyright © 2017 Max Wang. All rights reserved.
//

#import "Dispatch.h"

@interface Dispatch()
@property (nonatomic, copy) NSMutableString* str;
@property (nonatomic) NSInteger integer;
@end

@implementation Dispatch

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.str = [NSMutableString stringWithString:@"hello"];
        self.integer = 1;
    }
    return self;
}

-(void)dispatchCapture {
    __block int a = 1; //must __block for closure to change
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.str = [NSMutableString stringWithString:@"hello2"];
        self.integer = 3;
        a = 4;
        NSLog(@"%@, %ld, %ld", self.str, (long)self.integer, (long)a);
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"%@, %ld, %ld", self.str, (long)self.integer, (long)a);
    });
}

@end
