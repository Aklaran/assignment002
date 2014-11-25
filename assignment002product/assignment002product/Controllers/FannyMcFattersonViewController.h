//
//  FannyMcFattersonViewController.h
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/27/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootContainer;

@interface FannyMcFattersonViewController : UIViewController

@property (assign, nonatomic) NSInteger player1Score;
@property (assign, nonatomic) NSInteger player2Score;

@property (weak, nonatomic) IBOutlet UILabel *player1Display;
@property (weak, nonatomic) IBOutlet UILabel *player2Display;

@property (assign, nonatomic) BOOL scorer;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (weak, nonatomic) RootContainer *rootContainer;


-(void)updateScore;

@end
