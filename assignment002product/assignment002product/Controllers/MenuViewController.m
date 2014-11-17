//
//  MenuViewController.m
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/14/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import "MenuViewController.h"
#import "RootContainer.h"
#import "GameViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Setting playButton up to be a button, giving it the TapGestureRecognizer playButtonTap
    _playButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *playButtonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playButtonPress:)];
    [_playButton addGestureRecognizer:playButtonTap];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playButtonPress:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        //CASTING _rootContainer as self.parentViewController. Somehow this gives it all the permissions it needs to access all of its properties & methods.
        _rootContainer = (RootContainer *)self.parentViewController;
        //call out the method (transition) within RootContainer that should take place when the playButton is pressed. Passing in the storyboard file for "GameViewController" as NextVC in the menuTransition method.
        [_rootContainer menuTransition:[self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"]];
        
    }
}

@end
