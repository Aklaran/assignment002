//
//  RootContainer.h
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/14/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootContainer : UIViewController

@property (weak, nonatomic) UIViewController *MenuVC;
@property (weak, nonatomic) UIViewController *GameVC;
@property (weak, nonatomic) UIViewController *ScoreVC;
@property (nonatomic) UIStoryboard *mainStoryboard;



-(void)menuTransition:(UIViewController *)nextVC;
//-(void)createGameVC:(UIViewController *)GameVC;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   UIViewController+RootContainer Category Interface

@interface UIViewController ( RootContainer )

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   Category Methods

- ( RootContainer* )rootContainer;

@end
