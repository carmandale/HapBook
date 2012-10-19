//
//  TheBook.m
//  EbookTemplate
//
//  Created by Justin's Clone on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TheBook.h"
#import "SimpleAudioEngine.h"

@implementation TheBook


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TheBook *layer = [TheBook node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        CCLOG(@"initializing TheBook layer");
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite* theBackground = [CCSprite spriteWithFile:@"page0_with_options.png"];
        theBackground.position = ccp (screenSize.width / 2 , screenSize.height / 2);
        [self addChild:theBackground z:-1];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"whistle.wav" loop:NO];
        
        self.isTouchEnabled = YES;
        
	}
	return self;
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize]; 
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if ( location.x < (screenSize.width / 4) && location.y > (screenSize.height * .75) ) {
        
        CCLOG(@"touching upper left");
        
        //[[CCDirector sharedDirector] pushScene:[TheMenu scene]];
        
    } else if ( location.x > (screenSize.width * .75) && location.y < (screenSize.height * .3) ) {
        
        CCLOG(@"touching bottom right to turn the page forward");
        [[BookData sharedData] turnPage];
        CCTransitionPageTurn* transition = [CCTransitionPageTurn transitionWithDuration:2 scene:[ThePage scene] backwards:NO];
        [[CCDirector sharedDirector] replaceScene:transition];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ding.wav"];
        CCLOG(@"I think I played the ding sound");

        
    } else if ( location.x < (screenSize.width * .25) && location.y < (screenSize.height * .3) ) {
        
        CCLOG(@"touching bottom left to turn the page backward");
        [[BookData sharedData] turnBackPage];
        CCTransitionPageTurn* transition = [CCTransitionPageTurn transitionWithDuration:2 scene:[ThePage scene] backwards:YES];
        [[CCDirector sharedDirector] replaceScene:transition];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ding.wav"];
        
    } else {
        
        CCLOG(@"touch detected but doing nothing");
    }
    
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end


