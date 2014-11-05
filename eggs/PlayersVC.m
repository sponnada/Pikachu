//
//  PlayersVC.m
//  eggs
//
//  Created by Sri on 5/10/14.
//  Copyright (c) 2014 Sri. All rights reserved.
//

#import "PlayersVC.h"
#import "Player.h"
#import "PlayerDetailsVC.h"


@interface PlayersVC ()

@end

@implementation PlayersVC {

    NSMutableArray *_players;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear: (BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewDidDisappear:animated];
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gamescreen1.png"]];

    _players = [NSMutableArray arrayWithCapacity:20];
    
    Player *player = [[Player alloc] init];
    player.name = @"Anu";
    player.highscore = @"1400";
    [_players addObject:player];
    NSLog(@"Player added");
    
    player = [[Player alloc] init];
    player.name = @"Sri";
    player.highscore = @"2200";
    [_players addObject:player];
    
    player = [[Player alloc] init];
    player.name = @"Jenny";
    player.highscore = @"300";
    [_players addObject:player];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *playerName = [defaults objectForKey:@"player"];
    NSString *highScore = [defaults objectForKey:@"highscore"];
  
    player = [[Player alloc]init];
    player.name = playerName;
    player.highscore = highScore;
    
    [_players addObject:player];
    
    self.players = _players;
    NSLog(@"players added");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - PlayerDetailsVCDelegate

- (void)playerDetailsVCDidCancel:(PlayerDetailsVC *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playerDetailsVCDidSave:(PlayerDetailsVC *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.players count];
}


//add cells to the table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    
    Player *player = (self.players)[indexPath.row];
    cell.textLabel.text = player.name;
    cell.detailTextLabel.text = player.highscore;
    
    NSUserDefaults *tableCells = [NSUserDefaults standardUserDefaults];
    
    [tableCells setObject:cell.textLabel.text forKey:@"player"];
    [tableCells setObject:cell.detailTextLabel.text forKey:@"highscore"];
    [tableCells synchronize];
    NSLog(@"Data Saved");
    
    cell.imageView.image = [UIImage imageNamed:@"Pokeball.png"];
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}

//if we click the add button, we'll go to the add player view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        PlayerDetailsVC *playerDetailsVC = [navigationController viewControllers][0];
        playerDetailsVC.delegate = self;
    }
}

//add the player to the table view
- (void)playerDetailsVC:(PlayerDetailsVC *)controller didAddPlayer:(Player *)player
{
    [self.players addObject:player];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.players count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//this keeps track of the kind of editing we want to do to
//objects in the table view
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [self.players count];
    
    if (row < count) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

//use this method to delete players from the table view
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [self.players count];
    
    if (row < count) {
        [self.players removeObjectAtIndex:row];
        [tableView reloadData];
    }

}

- (void)tableView:(UITableView *)tableView
didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
