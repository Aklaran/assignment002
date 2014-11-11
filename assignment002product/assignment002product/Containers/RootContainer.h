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
@property (nonatomic) UIStoryboard *menuStoryboard;

-(void)menuTransition:(UIViewController *)nextVC;
//-(void)createGameVC:(UIViewController *)GameVC;

@end
