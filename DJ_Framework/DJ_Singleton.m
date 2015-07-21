//
//  DJ_Singleton.m
//  DJ_Framework
//
//  Created by okwei on 15/7/21.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_Singleton.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

#undef	__PRELOAD_SINGLETON__
#define __PRELOAD_SINGLETON__	(__OFF__)

#pragma mark -


@implementation DJ_Singleton

+ (BOOL)autoLoad
{
#if defined(__PRELOAD_SINGLETON__) && __PRELOAD_SINGLETON__
    
    INFO( @"Loading singletons ..." );
    
    [[BeeLogger sharedInstance] indent];
    //	[[BeeLogger sharedInstance] disable];
    
    NSMutableArray * availableClasses = [NSMutableArray arrayWithArray:[BeeRuntime allSubClassesOf:[NSObject class]]];
    [availableClasses sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 description] compare:[obj2 description]];
    }];
    
    for ( Class classType in availableClasses )
    {
        if ( [classType instancesRespondToSelector:@selector(sharedInstance)] )
        {
            [classType sharedInstance];
            
            //			[[BeeLogger sharedInstance] enable];
            INFO( @"%@ loaded", [classType description] );
            //			[[BeeLogger sharedInstance] disable];
        }
    }
    
    [[BeeLogger sharedInstance] unindent];
    //	[[BeeLogger sharedInstance] enable];
    
#endif	// #if defined(__PRELOAD_SINGLETON__) && __PRELOAD_SINGLETON__
    
    return YES;
}


@end
