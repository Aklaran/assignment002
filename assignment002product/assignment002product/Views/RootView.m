//
//  RootView.m
//  assignment002product
//
//  Created by Siri Tembunkiart on 11/13/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import "RootView.h"

@implementation RootView

// 123 == menu view controller
//456 == game
//789 == scores
//605 == pauseButton
// a hittest determines if you are hitting something that is NOT the view designated (but resides within the vew designated. So like a subview. returns the view that is being tapped.

// Whatever is returned in this method

- ( UIView* )hitTest:( CGPoint )point withEvent:( UIEvent* )event {
    
    __weak UIView *hitTestView = [self viewWithTag:123];
    //If you click on menuviewcontroller and the object WITHIN the menuviewcontroller that you tapped is NOT EQUAL TO the menuviewcontroller's view (so it is an object within it), this executes.
    if (hitTestView && hitTestView != [hitTestView hitTest:point withEvent:event]) {
        return [hitTestView hitTest:point withEvent:event];
    }
    
    hitTestView = [self viewWithTag:789];
    // If you click on the FannyView and not on the pause button -- WORKS FOR PADDLE
    if (hitTestView && hitTestView != [hitTestView hitTest:point withEvent:event]) {
        return [hitTestView hitTest:point withEvent:event];

    }
    if (hitTestView == [hitTestView hitTest:point withEvent:event]) {
        NSLog(@"%@", [hitTestView hitTest:point withEvent:event]);
        return [[self viewWithTag:456] hitTest:point withEvent:event];
        
    }

    

   
    return [self viewWithTag:456];
}



@end
