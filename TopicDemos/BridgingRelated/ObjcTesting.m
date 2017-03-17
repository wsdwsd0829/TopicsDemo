//
//  ObjcTesting.m
//  TopicDemos
//
//  Created by Max Wang on 3/15/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "ObjcTesting.h"
#import "TopicDemos-Swift.h"
@implementation ObjcTesting

+(void)useSwift {
    PMTesting* testing = [[PMTesting alloc] init];
    NSLog(@"%@", testing.title);
    NSLog(@"%ld", MyDirectionWest); //have to write global swift func to print
    NSLog(@"%@", [MyDirectionBridge nameWithDirection:MyDirectionWest]);
}

@end
