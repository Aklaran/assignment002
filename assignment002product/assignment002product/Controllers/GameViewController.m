//
//  GameViewController.m
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/14/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import "GameViewController.h"
#import "FannyMcFattersonViewController.h"
#import "RootContainer.h"

@interface GameViewController ()

-(void)didPan:( UIPanGestureRecognizer* )panGesture;
-(void)didPossiblePan:( UIPanGestureRecognizer* )panGesture;
-(void)didBeginPan:( UIPanGestureRecognizer* )panGesture;
-(void)didChangePan:( UIPanGestureRecognizer* )panGesture;
-(void)didEndPan:( UIPanGestureRecognizer* )panGesture;
-(void)didCancelPan:( UIPanGestureRecognizer* )panGesture;
-(void)didFailPan:( UIPanGestureRecognizer* )panGesture;

-(void)update;
-(void)bounce;
-(void)player2Move;
-(CGPoint)initialBallDirection;
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
    _player2View = [[UIImageView alloc] initWithFrame:paddle2Frame];
    _player2View.image = paddle2;
    [self.view addSubview:_player2View];
//    _player2DisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(player2Move)];
//    [_player2DisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _frameCounter = 0;
    }

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _scoreVC = (FannyMcFattersonViewController *)((RootContainer *)self.parentViewController).ScoreVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ballReset {
    UIImage *ball1 = [UIImage imageNamed:@"ball1.png"];
    CGRect ballFrame = CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2, 44, 44);
    _ballView = [[UIImageView alloc] initWithFrame:ballFrame];
    _ballView.image = ball1;
    _ballDirection = [self initialBallDirection]; //makes the ball have an initial direction - set in below helper method
    
    [self.view addSubview:_ballView];
    
    
    //setup for the ballDisplayLink, the "timer" that will be updating the ball's movement.
    _mainDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [_mainDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

// Helper method to randomly set the ballDirection
-(CGPoint)initialBallDirection {
    CGPoint returnPoint = CGPointZero;
    NSInteger rand4 = arc4random_uniform(4);
    switch (rand4) {
        case 0:
            returnPoint.x = 1.f;
            returnPoint.y = 1.f;
            break;
        case 1:
            returnPoint.x = -1.f;
            returnPoint.y = 1.f;
            break;
        case 2:
            returnPoint.x = 1.f;
            returnPoint.y = -1.f;
            break;
        case 3:
            returnPoint.x = -1.f;
            returnPoint.y = -1.f;
            break;
        default:
            NSLog(@"initialBallDirection error");
            break;
    }
    return returnPoint;
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
    _player1 = panGesture.view.frame;
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

-(void)update {
    [self bounce];
    [self player2Move];
    
    NSLog(@"%@", _ballView.image);
}

-(void)bounce { // method that will be called constantly, checking for the ball needing to bounce.
    CGRect ball = _ballView.frame; //first, making a variable for the frame of the ball!
    ball = CGRectMake(ball.origin.x + _ballDirection.x, ball.origin.y + _ballDirection.y, ball.size.width, ball.size.height); //second, making the ball's frame move in _ballDirection, declared in the header file
    
    // bouncy code
    if (ball.origin.x + ball.size.width > self.view.bounds.size.width) {
        _ballDirection.x = -_ballDirection.x-1;
        NSLog(@"Player 1 Scores");
        _scoreVC.scorer = 0;
        [_scoreVC updateScore];
    }
    if (ball.origin.x < 0) {
        _ballDirection.x = -_ballDirection.x+1;
        NSLog(@"Player 2 Scores");
        _scoreVC.scorer = 1;
        [_scoreVC updateScore];
    }
    if(CGRectIntersectsRect(ball, _player1)) {
        _ballDirection.x = -_ballDirection.x+1;
    }
    if(CGRectIntersectsRect(ball, _player2View.frame)) {
        _ballDirection.x = -_ballDirection.x-1;
    }
    if (ball.origin.y + ball.size.height > self.view.bounds.size.height) {
        _ballDirection.y = -_ballDirection.y-.5;
    }
    if (ball.origin.y < 0) {
        _ballDirection.y = -_ballDirection.y+.5;
    }
    _ballView.frame = ball;
    // For correct intersection: Search CGRectIntersection
}

#pragma mark - Player 2

-(void)player2Move {
    CGRect player2 = _player2View.frame;
//    player2 = CGRectMake(player2.origin.x, _ballView.frame.origin.y, player2.size.width, player2.size.height);
//    _player2View.frame = player2;
//    _frameCounter++;
//    if (!(_frameCounter%2)) {
        if (_ballView.frame.origin.y > player2.origin.y) {
            player2 = CGRectMake(player2.origin.x, player2.origin.y + 3, player2.size.width, player2.size.height);
        }
        if (_ballView.frame.origin.y < player2.origin.y) {
            player2 = CGRectMake(player2.origin.x, player2.origin.y - 3, player2.size.width, player2.size.height);
        }
//  }
    _player2View.frame = player2;
}
@end
