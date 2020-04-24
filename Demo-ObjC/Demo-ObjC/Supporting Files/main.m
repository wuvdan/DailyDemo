//
//  main.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/23.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#if debug
#import <FBAllocationTracker/FBAllocationTrackerManager.h>
#endif

int main(int argc, char * argv[]) {
    
#if debug
    [[FBAllocationTrackerManager sharedManager] startTrackingAllocations];
    [[FBAllocationTrackerManager sharedManager] enableGenerations];
#endif
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
