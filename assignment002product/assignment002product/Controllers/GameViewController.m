//
//  GameViewController.m
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/14/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

-(void)didPan:( UIPanGestureRecognizer* )panGesture;
-(void)didPossiblePan:( UIPanGestureRecognizer* )panGesture;
-(void)didBeginPan:( UIPanGestureRecognizer* )panGesture;
-(void)didChangePan:( UIPanGestureRecognizer* )panGesture;
-(void)didEndPan:( UIPanGestureRecognizer* )panGesture;
-(void)didCancelPan:( UIPanGestureRecognizer* )panGesture;
-(void)didFailPan:( UIPanGestureRecognizer* )panGesture;

-(void)bounce;

@end

@implementation GameViewController

#pragma mark - Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Creating images for the two paddles + the ball, also adding the pan gesture
    UIImage *paddle1 = [UIImage imageNamed:@"paddle1.png"];
    CGRect paddle1Frame = CGRectMake(0, self.view.bounds.size.height /2 -44, 44, 100);
    NSLog(@"paddle1Frame == %@", NSStringFromCGRect(paddle1Frame));
    UIImageView *paddle1View = [[UIImageView alloc] initWithFrame:paddle1Frame];
    paddle1View.image = paddle1;
    paddle1View.userInteractionEnabled = YES;
    UIPanGestureRecognizer *dragPaddle = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [paddle1View addGestureRecognizer:dragPaddle];
    [self.view addSubview:paddle1View];
    
    UIImage *paddle2 = [UIImage imageNamed:@"paddle1.png"];
    CGRect paddle2Frame = CGRectMake(self.view.bounds.size.width -44, self.view.bounds.size.height /2 -44, 44, 100);
    UIImageView *paddle2View = [[UIImageView alloc] initWithFrame:paddle2Frame];
    paddle2View.image = paddle2;
    [self.view addSubview:paddle2View];
    
    UIImage *ball1 = [UIImage imageNamed:@"ball1.png"];
    CGRect ballFrame = CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2, 44, 44);
    _ballView = [[UIImageView alloc] initWithFrame:ballFrame];
    _ballView.image = ball1;
    [self.view addSubview:_ballView];
    ballDirection = CGPointMake(1.f, 1.f); //makes the ball have an initial direction
    
    //setup for the ballDisplayLink, the "timer" that will be updating the ball's movement.
    _ballDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(bounce)];
    [_ballDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  - UIPanGestureRecognizer Methods
// This method encompasses all the didPan possible actions. When one of them happens, it will "switch" to the correct method.
- ( void )didPan:( UIPanGestureRecognizer* )panGesture
{
    switch ( panGesture.state )
    {
        default:
            [self didPossiblePan:panGesture];
            break;
        case UIGestureRecognizerStateBegan:
            [self didBeginPan:panGesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self didChangePan:panGesture];
            break;
        case UIGestureRecognizerStateEnded:
            [self didEndPan:panGesture];
            break;
        case UIGestureRecognizerStateCancelled:
            [self didCancelPan:panGesture];
            break;
        case UIGestureRecognizerStateFailed:
            [self didFailPan:panGesture];
            break;
    }
}

/* First try at UIPanGestureRecognizer code
 -(void)dragPaddle:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.firstY = sender.view.center.y;
        NSLog(@"%f",self.firstY);
    }
    [sender setMinimumNumberOfTouches:1];
    [self.view bringSubviewToFront:sender.view];
    CGPoint translation = [sender translationInView:self.view];
    [sender setTranslation:CGPointMake(0, self.firstY + [sender translationInView:self.view].y) inView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(translation));
}
 */


-(void)didPossiblePan:( UIPanGestureRecognizer* )panGesture {
    NSLog(@"Hey look it happened, didPossiblePan!");
}

// What happens when you start to drag
-(void)didBeginPan:( UIPanGestureRecognizer* )panGesture {
    _initialPoint = [panGesture locationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(_initialPoint));
}

// What happens when you drag an amount.  Goal is: Paddle moves with your finger.
-(void)didChangePan:( UIPanGestureRecognizer* )panGesture {
    // http://blog.shoguniphicus.com/2011/06/uigesturerecognizers.html
    CGPoint translation = [panGesture translationInView:self.view];
    [panGesture.view setCenter:CGPointMake(panGesture.view.center.x, panGesture.view.center.y + translation.y)]; // this line actually moves the paddle
    [panGesture setTranslation:CGPointZero
                        inView:self.view];// this line resets the velocity back to (0,0) so the paddle doesn't fly off the screen
    
    // This variable is created for use in the below "if" statements
    CGFloat currentY = panGesture.view.center.y;
    
    // These "if" statements stop the paddle from moving when it hits the top or bottom of the frame.
    if (currentY < 50) {
        NSLog(@"paddle hit the top");
        [panGesture.view setCenter:CGPointMake(panGesture.view.center.x, 50)];
        [panGesture setTranslation:CGPointZero
                            inView:self.view];
    }
    if (currentY > (self.view.bounds.size.height - 50)) {
        NSLog(@"paddle hit the bottom");
        [panGesture.view setCenter:CGPointMake(panGesture.view.center.x, (self.view.bounds.size.height - 50))];
        [panGesture setTranslation:CGPointZero
                            inView:self.view];
    }
  
  /* Second try at UIPanGestureRecognizer code
   
    Changed from self.view to panGesture.view, moves correctly. Go Figure!
    CGPoint currentPoint = [panGesture locationInView:panGesture.view];
    CGPoint deltaPoint = CGPointMake(currentPoint.x - _initialPoint.x, currentPoint.y - _initialPoint.y);
    UIImageView *paddle = (UIImageView *)panGesture.view;
    CGRect paddleFrame = paddle.frame;
    NSLog (@"paddleFrame.origin.y == %f" , paddleFrame.origin.y);
    NSLog(@"current point == %@" , NSStringFromCGPoint(currentPoint));
    NSLog(@"delta point == %@" , NSStringFromCGPoint(deltaPoint));
    paddleFrame = CGRectMake(paddleFrame.origin.x, paddleFrame.origin.y + deltaPoint.y, paddleFrame.size.width, paddleFrame.size.height);
    paddle.Frame = paddleFrame;
   */

}

// What happens when you pick your finger up
-(void)didEndPan:( UIPanGestureRecognizer* )panGesture {
    
}

-(void)didCancelPan:( UIPanGestureRecognizer* )panGesture {
    NSLog(@"UIGestureRecognizerStateCancelled");
}

-(void)didFailPan:( UIPanGestureRecognizer* )panGesture {
    NSLog(@"UIGestureRecognizerStateFailed");
}

#pragma mark - Ball!

-(void)bounce{ // method that will be called constantly, checking for the ball needing to bounce.
    CGRect ball = _ballView.frame; //first, making a variable for the frame of the ball!
    ball = CGRectMake(ball.origin.x + ballDirection.x, ball.origin.y + ballDirection.y, ball.size.width, ball.size.height); //second, making the ball's frame move in ballDirection, declared in the header file
    
    // bouncy code
    if (ball.origin.x + ball.size.width > self.view.bounds.size.width || ball.origin.x < 0) {
        ballDirection.x = -ballDirection.x;
    }
    if (ball.origin.y + ball.size.height > self.view.bounds.size.height || ball.origin.y < 0) {
        ballDirection.y = -ballDirection.y;
    }
    NSLog(@"BOuncey Time");
    _ballView.frame = ball;
}
 




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
