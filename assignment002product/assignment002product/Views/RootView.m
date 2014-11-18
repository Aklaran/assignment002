//
//  RootView.m
//  assignment002product
//
//  Created by Siri Tembunkiart on 11/13/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import "RootView.h"

@implementation RootView

// 123 == play button
//456 == game
//789 == scores
// a hittest determines if you are hitting something that is NOT the view designated (but resides within the vew designated. So like a subview. returns the view that is being tapped.

// Whatever is returned in this method

- ( UIView* )hitTest:( CGPoint )point withEvent:( UIEvent* )event {
    
    __weak UIView *hitTestView = [self viewWithTag:123];
    //If you click the play button...
    if (hitTestView && hitTestView != [hitTestView hitTest:point withEvent:event]) {
        NSLog(@"%ld", (long)[hitTestView hitTest:point withEvent:event].tag);
        return [hitTestView hitTest:point withEvent:event];
    }
    
    hitTestView = [self viewWithTag:789];
    // If you click on the FannyView and not on the pause button
    if (hitTestView) {
        NSLog(@"Tryna play the game");
        return [[self viewWithTag:456] hitTest:point withEvent:event];
    }

    return [self viewWithTag:456];
}



@end
