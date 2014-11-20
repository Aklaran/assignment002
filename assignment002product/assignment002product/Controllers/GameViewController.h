//
//  GameViewController.h
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/14/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FannyMcFattersonViewController.h"

@interface GameViewController : UIViewController
{
    CGPoint _initialPoint;
    CGPoint _ballDirection;
    CADisplayLink* _mainDisplayLink;
    
    CGRect _player1;
    
    NSInteger _frameCounter;
    
    CGRect _player1InitialFrame;
    CGRect _player2InitialFrame;
    CGRect _ballInitialFrame;
    
    
    BOOL _started;
}

@property (weak, nonatomic) FannyMcFattersonViewController *scoreVC;
@property (weak, nonatomic) IBOutlet UIImageView *paddle1;
@property (weak, nonatomic) IBOutlet UIImageView *paddle2;
@property (weak, nonatomic) IBOutlet UIImageView *ball;

-(void)ballReset;

@end
