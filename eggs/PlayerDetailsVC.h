//
//  PlayerDetailsVC.h
//  eggs
//
//  Created by Sri on 5/11/14.
//  Copyright (c) 2014 Sri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerDetailsVC;
@class Player;

@protocol PlayerDetailsVCDelegate <NSObject>

- (void)playerDetailsVCDidCancel:(PlayerDetailsVC *)controller;

- (void)playerDetailsVC:(PlayerDetailsVC *)controller didAddPlayer:(Player *)player;

@end

@interface PlayerDetailsVC : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic, weak) id <PlayerDetailsVCDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
