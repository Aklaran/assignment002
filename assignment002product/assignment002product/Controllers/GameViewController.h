//
//  GameViewController.h
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/14/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
{
    CGPoint _initialPoint;
    CGPoint ballPosition;
    IBOutlet UIImageView *ball;
    CADisplayLink _ballDisplayLink;
}
@property (weak, nonatomic) IBOutlet UILabel *player1Score;
@property (weak, nonatomic) IBOutlet UILabel *player2Score;

@property (retain, nonatomic) UIImageView *ball;


//-(void)dragPaddle:(UIPanGestureRecognizer *)sender;
@end
