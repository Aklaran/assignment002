//
//  FannyMcFattersonViewController.m
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/27/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import "FannyMcFattersonViewController.h"
#import "RootContainer.h"
#import "GameViewController.h"

@interface FannyMcFattersonViewController ()

@end

@implementation FannyMcFattersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _player1Score = 0;
    _player2Score = 0;
    
    _scorer = nil;
    
    _player1Display.text = [NSString stringWithFormat: @"%ld", (long)_player1Score];
    _player2Display.text = [NSString stringWithFormat: @"%ld", (long)_player2Score];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didPressPause:(id)sender {
    _rootContainer = ( RootContainer* )self.parentViewController;
    [( GameViewController*)self.rootContainer.GameVC pauseGame];
//    [_pauseButton setImage:[UIImage imageNamed:@"unpause.png"] forState:UIControlStateNormal];
}

-(void)updateScore {
    NSLog(@"updateScore called with scorer == %d" , _scorer);
    if (_scorer == 0) {
        _player1Score++;
        NSLog(@"player1Score == %ld" , (long)_player1Score);
        _player1Display.text = [NSString stringWithFormat: @"%ld", (long)_player1Score];
        _scorer = nil;
    }
    if (_scorer == 1) {
        _player2Score++;
        NSLog(@"player2Score == %ld" , (long)_player2Score);
        _player2Display.text = [NSString stringWithFormat: @"%ld", (long)_player2Score];
        _scorer = nil;
    }
    
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
