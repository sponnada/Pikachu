//
//  gameOverScene.m
//  eggs
//
//  Created by Anu on 4/23/14.
//  Copyright (c) 2014 Sri. All rights reserved.
//

#import "gameOverScene.h"
#import "eggsMyScene.h"

@implementation gameOverScene

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        //set up the screen's background
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"gameover.png"];
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
        
        [self addChild:bgImage];
        
        //reset the score
        score = 0;
    }
    return self;
    
}

@end
