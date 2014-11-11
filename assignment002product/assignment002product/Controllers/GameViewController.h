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
    CGPoint ballDirection;
    UIImageView *_ballView;
    CADisplayLink* _ballDisplayLink;
    
    CGRect _player1;
    
    UIImageView *_player2View;
    CADisplayLink *_player2DisplayLink;
}



//-(void)dragPaddle:(UIPanGestureRecognizer *)sender;
@end
