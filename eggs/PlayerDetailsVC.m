//
//  PlayerDetailsVC.m
//  eggs
//
//  Created by Sri on 5/11/14.
//  Copyright (c) 2014 Sri. All rights reserved.
//

#import "PlayerDetailsVC.h"
#import "Player.h"

@interface PlayerDetailsVC ()

@end

@implementation PlayerDetailsVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.nameTextField becomeFirstResponder];
    }
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gamescreen1.png"]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)cancel:(id)sender
{
    [self.delegate playerDetailsVCDidCancel:self];
}

- (IBAction)done:(id)sender
{
    Player *player = [[Player alloc] init];
    player.name = self.nameTextField.text;
    player.highscore = @"0";
    [self.delegate playerDetailsVC:self didAddPlayer:player];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        NSLog(@"init PlayerDetailsVC");
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"dealloc PlayerDetailsVC");
}


@end
