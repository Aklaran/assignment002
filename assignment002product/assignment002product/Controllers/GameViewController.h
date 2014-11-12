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
    UIImageView *_ballView;
    CADisplayLink* _ballDisplayLink;
    
    CGRect _player1;
    
    UIImageView *_player2View;
    CADisplayLink *_player2DisplayLink;
    
    NSInteger _frameCounter;
}

@property (weak, nonatomic) FannyMcFattersonViewController *scoreVC;



//-(void)dragPaddle:(UIPanGestureRecognizer *)sender;
@end
