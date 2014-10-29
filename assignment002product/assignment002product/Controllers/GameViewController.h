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
}
@property (weak, nonatomic) IBOutlet UILabel *player1Score;
@property (weak, nonatomic) IBOutlet UILabel *player2Score;
@property (assign, nonatomic) CGFloat firstY;

//-(void)dragPaddle:(UIPanGestureRecognizer *)sender;
@end
