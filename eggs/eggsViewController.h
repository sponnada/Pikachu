//
//  eggsViewController.h
//  eggs
//

//  Copyright (c) 2014 Sri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface eggsViewController : UIViewController
{
    SKView * gameView;
}

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end


