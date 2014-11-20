//
//  RootContainer.m
//  assignment002product
//
//  Created by Siri Tembunkiart on 10/14/14.
//  Copyright (c) 2014 Dig-It Games. All rights reserved.
//

#import "RootContainer.h"
#import "MenuViewController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// All the stuff the Category Methods basically just makes it so we have to do less casting, and we can move stuff around easier.  A sure-fire way to get to RootContainer from anywhere!
#pragma mark    -   UIViewController+RootContainer Category Implementation

@implementation UIViewController ( RootContainer )

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   Category Methods

- ( RootContainer* )rootContainer
{
    UIViewController* viewController = self.parentViewController;
    
    while ( !( viewController == nil || [viewController isKindOfClass:[RootContainer class]] ) )
    {
        viewController = viewController.parentViewController;
    }
    
    return ( RootContainer* )viewController;
}

@end

#pragma mark - RootContainer Implementation

@implementation RootContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // Adding gameVC as a child so I have a variable to use in other classes to reference GameVC.
    UIViewController *gameVC = [_mainStoryboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    [self addChildViewController:gameVC];
    [gameVC didMoveToParentViewController:self];
    [self.view addSubview:gameVC.view];
    self.GameVC = gameVC;
    
    //Creating UIViewController variable "currentVC" of MenuViewController's spot in the main storyboard
    
    UIViewController *scoreVC = [_mainStoryboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
    
    [self addChildViewController:scoreVC];
    [scoreVC didMoveToParentViewController:self];
    [self.view addSubview:scoreVC.view];
    self.ScoreVC = scoreVC;
    
    UIViewController *currentVC = [_mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    // Adding currentVC to the RootContainer
    [self addChildViewController:currentVC];
    [currentVC didMoveToParentViewController:self];
    [self.view addSubview:currentVC.view];
    
    // Setting the class (weak) variable equal to its local variable
    self.MenuVC = currentVC;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)menuTransition:(UIViewController *)nextVC {
//    // Calling the below method to add GameViewController as a child of the RootContainer, correctly set its frame etc.
//    [self createGameVC:_GameVC];

    // Animation block for the transition from MenuVC to GameVC
    [UIView animateWithDuration:1
                          delay:0
                        options:0
                     animations:^{
                         CGRect currentFrame = _MenuVC.view.frame;
                         currentFrame.origin.y = currentFrame.size.height;
                         _MenuVC.view.frame = currentFrame;
                         
                     }
                     completion:^(BOOL finished){
    
        
                     }];
    
}

// -(void)createGameVC:(UIViewController *)GameVC; {
//    //Creating "nextVC" of GameViewController's spot in the main storyboard
//    UIViewController *nextVC = [_mainStoryboard instantiateViewControllerWithIdentifier:@"GameViewController"];
//
//    // Setting GameVC's frame off to the right of the screen.
//    CGRect gameFrame = self.view.bounds;
//    gameFrame.origin.x = self.view.bounds.size.width;
//    _GameVC.view.frame = gameFrame;
//    
//    // Adding nextVC to the RootContainer
//    [self addChildViewController:nextVC];
//    [nextVC didMoveToParentViewController:self];
//    [self.view addSubview:nextVC.view];
//    
//    // Setting the class (weak) variable equal to its local variable.
//    self.GameVC = nextVC;
//    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
