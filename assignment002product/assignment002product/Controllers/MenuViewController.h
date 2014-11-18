//
//  MenuViewController.h
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/14/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"
//Declaring the existence of a RootContainer class w/o referencing it (avoiding recursive error)
@class RootContainer;

@interface MenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *playButton;
@property (weak, nonatomic) RootContainer *rootContainer;
@property (weak, nonatomic) GameViewController *GameVC;

-(void)playButtonPress:(UITapGestureRecognizer *)sender;

@end

