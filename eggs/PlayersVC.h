//
//  PlayersVC.h
//  eggs
//
//  Created by Sri on 5/10/14.
//  Copyright (c) 2014 Sri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerDetailsVC.h"

@interface PlayersVC : UITableViewController <PlayerDetailsVCDelegate>

@property (nonatomic, strong) NSMutableArray *players;

@end
