//
//  eggsViewController.m
//  eggs
//
//  Created by Sri on 4/15/14.
//  Copyright (c) 2014 Sri. All rights reserved.
//

#import "eggsViewController.h"
#import "eggsMyScene.h"

@implementation eggsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [eggsMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    for (UIView *subview in [self.view subviews]) {
        if (subview.tag == 7) {
            [subview setHidden:NO];
        } else {
            [subview setHidden:YES];
        }
    }
    
    // Present the scene.
    [skView presentScene:scene];
    
    self.navigationController.navigationBarHidden = YES;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

//this is when the pause button is pressed
//we'll pause the pokeballs on the screen + pikachu won't be able to jump

- (IBAction)buttonPressed:(UIButton *)sender {
    
    
    SKView *skView = (SKView *)self.view;
    //if the scene is playing, pause it
    if (skView.scene.paused == NO) {
        skView.scene.paused = YES;
        [self.pauseButton setImage:[UIImage imageNamed:@"paused.png"] forState:UIControlStateNormal|UIControlStateHighlighted];
    }
    else { //resume
        skView.scene.paused = NO;
        [self.pauseButton setImage:[UIImage imageNamed:@"unpaused.png"] forState:UIControlStateNormal];
    }
}


//when the restart button is pressed, we'll bring up the game scene again
//(we hide the restart and menu buttons and enable the pause button)

- (IBAction)restartPressed:(UIButton *)sender {
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [eggsMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.navigationController setNavigationBarHidden:YES];
    
    // Present the scene.
    [skView presentScene:scene];
    
    //hiding and revealing buttons based on what scene it is
    for (UIView *subview in [self.view subviews]) {
        if (subview.tag == 7) {
            [subview setHidden:NO];
        } else {
            [subview setHidden:YES];
        }
    }
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
