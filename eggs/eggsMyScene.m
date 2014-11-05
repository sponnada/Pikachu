//
//  eggsMyScene.m
//  eggs
//
//  Created by Sri on 4/15/14.
//  Copyright (c) 2014 Sri. All rights reserved.
//

#import "eggsMyScene.h"
#import "gameOverScene.h"
#import "PlayersVC.h"

@interface eggsMyScene () {
    SKSpriteNode* _egg;
    SKTexture* _nestTexture1;
    SKTexture* _nestTexture2;
    SKSpriteNode* _platform;
    SKSpriteNode* _topnest;
    SKSpriteNode* _topnest1;
    SKSpriteNode* _bottomnest;
    SKSpriteNode* _pill;
}

@property (strong, nonatomic) SKAction* move;
@property (strong, nonatomic) SKAction* moveBack;
@property (strong, nonatomic) SKAction* makeNest;

@end

//these are all used to keep track of contact with different objects on screen
static const uint32_t eggCategory = 0x1 <<0; //(1)
static const uint32_t nestCategory = 0x1 << 1;  //(2)
static const uint32_t edgeCategory = 0x1 << 2;  //(4)
static const uint32_t bottomEdgeCategory = 0x1 << 3;  //(8)
static const uint32_t topEdgeCategory = 0x1 << 4; //16
static const uint32_t platformCategory = 0x1 << 5; //32

int score = 0;
int RandomX;
int RandomY;
@implementation eggsMyScene


- (void)addEgg {
    //create pikachu
    SKTexture* eggTexture1 = [SKTexture textureWithImageNamed:@"pikasad"];
    eggTexture1.filteringMode = SKTextureFilteringNearest;
    
    
    //making a node for pikachu
    _egg = [SKSpriteNode spriteNodeWithTexture:eggTexture1];
    [_egg setScale:2.0];
    _egg.position = CGPointMake(164.0f, 64.0f);
    
    //adding physics body properties to pikachu
    _egg.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_egg.size.height / 2];
    _egg.physicsBody.dynamic = YES;
    _egg.physicsBody.allowsRotation = NO;
    _egg.physicsBody.affectedByGravity = YES;
    
    //make sure the view isn't paused
    self.view.paused = NO;
    
    //Notify me when pikachu touches a pokeball, the medicine, or falls off screen
    _egg.physicsBody.categoryBitMask = eggCategory;
    _egg.physicsBody.contactTestBitMask = nestCategory | bottomEdgeCategory | topEdgeCategory |platformCategory | edgeCategory;
    
    [self addChild:_egg];
     NSLog(@"pikachu added");
}

//this method adds the bottom edge of the scene (used to detect contact during game play)
-(void) addBottomEdge:(CGSize)size  {
  
    SKNode *bottomEdge = [SKNode node];
    bottomEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 1) toPoint:CGPointMake(size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    
    [self addChild:bottomEdge];
    
}

//this method adds the top edge of the scene
-(void) addTopEdge:(CGSize) size{
    
    SKNode *topEdge = [SKNode node];
    topEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, size.height-5) toPoint:CGPointMake(size.width, size.height-5)];
    topEdge.physicsBody.categoryBitMask = topEdgeCategory;
    [self addChild:topEdge];
}



-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //adding a background image to the game scene
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"gamescreen1.png"];
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);

        [self addChild:bgImage];
         NSLog(@"background added");
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        
        //making gravity slower
        self.physicsWorld.gravity = CGVectorMake( 0.0, -5.0 );
        self.physicsWorld.contactDelegate = self;
        
        [self addEgg];
        
        //add the platform that pikachu stands on
        SKTexture* platformTexture = [SKTexture textureWithImageNamed:@"platform"];
        platformTexture.filteringMode = SKTextureFilteringNearest;
        _platform = [SKSpriteNode spriteNodeWithTexture:platformTexture];
        _platform.position = CGPointMake(size.width/2, 60);
        [self addChild:_platform];
         NSLog(@"platform added");
        
        _platform.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_platform.frame.size];
        _platform.physicsBody.dynamic = NO;
        _platform.physicsBody.categoryBitMask = platformCategory;
        
        //add the medicine to the top of the screen
        SKTexture* pillTexture = [SKTexture textureWithImageNamed:@"rx.png"];
        pillTexture.filteringMode = SKTextureFilteringNearest;
        _pill = [SKSpriteNode spriteNodeWithTexture:pillTexture];
        _pill.position = CGPointMake(size.width/2, 460);
        [self addChild:_pill];
        
        _pill.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_pill.size.height];
        _pill.physicsBody.dynamic = NO;
      //  _pill.physicsBody.categoryBitMask = topEdgeCategory;
        
        
        //make nodes and physics bodies for all the pokeballs
        
        //bottom projectile is being added at a random position each time
        SKTexture *bottomnestTexture = [SKTexture textureWithImageNamed:@"Pokeball.png"];
        bottomnestTexture.filteringMode = SKTextureFilteringNearest;
        _bottomnest = [SKSpriteNode spriteNodeWithTexture:bottomnestTexture];
       
        RandomX = arc4random()%248;
        RandomX = RandomX+36;
        
        RandomY = arc4random() % (280-200);
        RandomY = RandomY + 200;
        
         _bottomnest.position = CGPointMake(RandomX, RandomY);
        
        _bottomnest.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_bottomnest.frame.size];
        _bottomnest.physicsBody.dynamic = NO;
        _bottomnest.physicsBody.allowsRotation = YES;

        _bottomnest.physicsBody.categoryBitMask = nestCategory;
        
        [self addChild:_bottomnest];
         NSLog(@"pokeball added");
        
        //middle projectile is being added at a random position each time
        SKTexture* topnestTexture = [SKTexture textureWithImageNamed:@"Pokeball1.png"];
        topnestTexture.filteringMode = SKTextureFilteringNearest;
        _topnest = [SKSpriteNode spriteNodeWithTexture:topnestTexture];
       
        RandomX = arc4random()%248;
        RandomX = RandomX+36;
        
        RandomY = arc4random() % (410-280);
        RandomY = RandomY + 280;
        _topnest.position = CGPointMake(RandomX, RandomY);
        
        _topnest.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_topnest.frame.size];
        _topnest.physicsBody.dynamic = NO;
        _topnest.physicsBody.allowsRotation = YES;
        _topnest.physicsBody.categoryBitMask = nestCategory;
        
        [self addChild:_topnest];
        NSLog(@"pokeball added");
        
        
        //top projectile is being added at a random position each time
        SKTexture* topnest1Texture = [SKTexture textureWithImageNamed:@"Pokeball.png"];
        topnest1Texture.filteringMode = SKTextureFilteringNearest;
        _topnest1 = [SKSpriteNode spriteNodeWithTexture:topnest1Texture];

        RandomX = arc4random()%248;
        RandomX = RandomX+36;
        
        RandomY = arc4random() % (500-410);
        RandomY = RandomY + 410;
        _topnest1.position = CGPointMake(RandomX, RandomY);
        
        _topnest1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_topnest1.frame.size];
        _topnest1.physicsBody.dynamic = NO;
        _topnest1.physicsBody.allowsRotation = YES;
        _topnest1.physicsBody.categoryBitMask = nestCategory;
        
        [self addChild:_topnest1];
        NSLog(@"pokeball added");

        //[self addNest:size];
        [self addBottomEdge:size];
        [self addTopEdge:size];

      //move the pokeballs based on time
        SKAction *move = [SKAction moveToX:320 - _bottomnest.size.width/2.0 duration:1.2];
        SKAction *moveBack = [SKAction moveToX:(0) duration:1.2];
        
        self.move = [SKAction moveToX:320 - _bottomnest.size.width/2.0 duration:1.2];
        self.moveBack = [SKAction moveToX:(0) duration:1.2];
        
        [NSTimer scheduledTimerWithTimeInterval:2.4 target:self selector:@selector(animNests) userInfo:nil  repeats:YES];
       
        SKAction *backAndForth = [SKAction sequence:@[move,moveBack]];
        SKAction *forthAndBack = [SKAction sequence:@[moveBack, move]];
        [_bottomnest runAction:backAndForth];
        [_topnest runAction:forthAndBack];
        [_topnest1 runAction:backAndForth];
        
        //Add score label to the bottom left of the screen
        SKLabelNode *label1 = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label1.text = [NSString stringWithFormat:@"SCORE = %d", score];
        label1.fontColor = [SKColor whiteColor];
        label1.fontSize = 20;
        label1.position = CGPointMake(60, 16);
        [self addChild:label1];
        
    }
    
    return self;
}

//this method moves the pokeballs back and forth
-(void) animNests {
    SKAction *backAndForth = [SKAction sequence:@[self.move,self.moveBack]];
    SKAction *forthAndBack = [SKAction sequence:@[self.moveBack, self.move]];
    [_bottomnest runAction:backAndForth];
    [_topnest runAction:forthAndBack];
    [_topnest1 runAction:backAndForth];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    //play a sneezing sound when pikachu jumps
    [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO]];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //make pikachu jump either left or right based on where the use taps
    
    //go left
    if (point.x < 160) {
        _egg.physicsBody.velocity = CGVectorMake(0, 0);
        [_egg.physicsBody applyImpulse:CGVectorMake(-20, 40)];

    }else{ //go right
    
    _egg.physicsBody.velocity = CGVectorMake(0, 0);
    [_egg.physicsBody applyImpulse:CGVectorMake(20, 40)];
    }

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


//this  method checks to see if any of the physics bodies came into contact
//and then performs actions as necessary

-(void)didBeginContact:(SKPhysicsContact *)contact{        
    if ( contact.bodyA.categoryBitMask == edgeCategory | contact.bodyB.categoryBitMask == edgeCategory |contact.bodyA.categoryBitMask == nestCategory | contact.bodyB.categoryBitMask == nestCategory) {
        
        [self removeActionForKey:@"flash"];
        [self runAction:[SKAction sequence:@[[SKAction repeatAction:[SKAction sequence:@[[SKAction runBlock:^{
            self.backgroundColor = [SKColor redColor];
        }], [SKAction waitForDuration:0.05], [SKAction runBlock:^{
            self.backgroundColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
        }], [SKAction waitForDuration:0.05]]] count:4]]] withKey:@"flash"];
    }
    
    //check to see if pikachu has hit the pokeballs or the bottom of the screen
    if (contact.bodyA.categoryBitMask == bottomEdgeCategory | contact.bodyB.categoryBitMask == bottomEdgeCategory |contact.bodyA.categoryBitMask == nestCategory | contact.bodyB.categoryBitMask == nestCategory) {
        
        [self removeActionForKey:@"flash"];
        [self runAction:[SKAction sequence:@[[SKAction repeatAction:[SKAction sequence:@[[SKAction runBlock:^{
            self.backgroundColor = [SKColor redColor];
        }], [SKAction waitForDuration:0.05], [SKAction runBlock:^{
            self.backgroundColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
        }], [SKAction waitForDuration:0.05]]] count:4]]] withKey:@"flash"];
        
        gameOverScene *gameOver = [gameOverScene sceneWithSize:self.size];
        
        //hiding and revealing buttons
        for (UIView *subview in [self.view subviews]) {
             if (subview.tag == 7) {
                 [subview setHidden:YES];
             } else {
                 [subview setHidden:NO];
             }
        }
        //bring up the game over scene
        [self.view presentScene:gameOver transition:[SKTransition crossFadeWithDuration:0.4]];
    }
    
    //if pikachu has made it to the medicine on top of the screen, get to the next level
    //increase the score
    else if (contact.bodyA.categoryBitMask == topEdgeCategory | contact.bodyB.categoryBitMask == topEdgeCategory) {
        score = score + 100;
        eggsMyScene *firstScene = [eggsMyScene sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition crossFadeWithDuration:1]];
        
    
    }
}

@end
