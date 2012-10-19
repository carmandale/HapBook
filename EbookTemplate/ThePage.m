//
//  ThePage.m
//  EbookTemplate
//
//  Created by Justin's Clone on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThePage.h"
#import "SimpleAudioEngine.h"

@implementation ThePage

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ThePage *layer = [ThePage node];
	
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
		
        self.isTouchEnabled = YES;

        //[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
        // TO USE THIS LINE BELOW, INCLUDE FILES FOR EVERY PAGE named in order, audioTrack1.mp3, audioTrack2.mp3, and so on
        
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[BookData sharedData] returnTheCurrentAudioFile] loop:NO];
        
        //delay the start of the audio
        //[ self performSelector:@selector(playPageAudio) withObject:nil afterDelay: 1.0 ];
        
        [self playPageAudioDelay];
		
        CCLOG(@"initializing ThePage layer");

        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        
        // we don't want to hard code in the value of the page number we are showing...
        
        CCSprite* theBackground = [CCSprite spriteWithFile: [[BookData sharedData] returnTheCurrentPageString] ];
        theBackground.position = ccp (screenSize.width / 2 , screenSize.height / 2);
        [self addChild:theBackground z:-1];
        
        if ([[BookData sharedData] returnCurrentPageSpecialProperty] == nothingSpecialToReturn) {
            
            CCLOG(@"This page has no special properties to display or setup");
            
        } else if ([[BookData sharedData] returnCurrentPageSpecialProperty] == somethingSpecial) {
            
            CCLOG(@"This page DOES have something special to add on");
            
        } else if ([[BookData sharedData] returnCurrentPageSpecialProperty] == showThePurchaseButton) {
            
            CCLOG(@"We need to show the purchase button here");
            [self setUpPurchaseLink];
            
        } else if ([[BookData sharedData] returnCurrentPageSpecialProperty] == hearts) {
            
            [self setUpHearts];
            
        } else if ([[BookData sharedData] returnCurrentPageSpecialProperty] == page1) {
            
            [self setUpPage1];
            
        } else if ([[BookData sharedData] returnCurrentPageSpecialProperty] == page2) {
            
            [self setUpPage2];
            
        } else if ([[BookData sharedData] returnCurrentPageSpecialProperty] == page3) {
            
            [self setUpPage3];
            
        }
        
        
        
        
	}
	return self;
}

-(void) setUpPage1 {
    
    CCLOG(@"**SPECIAL** This is page 1 Setup");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite* alClosed = [CCSprite spriteWithFile:@"page1_al_closed.png"];
    [self addChild:alClosed];
    alClosed.position = ccp(screenSize.width / 2, screenSize.height / 2);

    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"page1_grrr.png" selectedImage:@"page1_grrr_over.png" target:self selector:@selector(playGrrr)];
    CCMenu *Menu = [CCMenu menuWithItems:button1,  nil];
    Menu.position= ccp(624  , 566 );
    //[Menu alignItemsVerticallyWithPadding:0];
    [self addChild:Menu z:10];

    
}

-(void) setUpPage2 {
    
    CCLOG(@"**SPECIAL** This is page 2 Setup");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite* palClosed = [CCSprite spriteWithFile:@"page2-pal-closed.png"];
    [self addChild:palClosed z:5];
    palClosed.position = ccp(screenSize.width / 2, screenSize.height / 2);
    
    //CCSprite* bg = [CCSprite spriteWithFile:@"page2-bg.png"]; //show the clean bg
    CCSprite* bg = [CCSprite spriteWithFile:@"page2.png"]; //show the reference bg for positioning bg

    [self addChild:bg];
    bg.position = ccp(screenSize.width / 2, screenSize.height / 2);
    
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"page2-grr.png" selectedImage:@"page2-grr-over.png" target:self selector:@selector(page2grr)];
    [button1 setTag:1];
    
    CCMenu *menu = [CCMenu menuWithItems:button1, nil];
    menu.position = ccp(730 , 565);
    [self addChild:menu z:10 tag:kMenuTag];
    
    
    
}

-(void) setUpPage3 {
    
    CCLOG(@"**SPECIAL** This is page 3 setup");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite* bg = [CCSprite spriteWithFile:@"page3-bg.png"];
    bg.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:bg];
    CCSprite* pal = [CCSprite spriteWithFile:@"page3Pal.png"];
    pal.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:pal z:10];
    CCScaleBy* scale = [CCScaleBy actionWithDuration:12 scale:.4];
    CCEaseExponentialOut* ease = [CCEaseExponentialOut actionWithAction:scale];
    CCMoveBy* move = [CCMoveBy actionWithDuration:12 position:ccp(10,10)];
    CCEaseExponentialOut* easeMove = [CCEaseExponentialOut actionWithAction:move];
    //CCMotionStreak* streak = [CCMotionStreak ]
    [pal runAction:ease];
    [pal runAction:easeMove];
    
    CCSprite* cloud = [CCSprite spriteWithFile:@"page3-cloud.png"];
    cloud.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:cloud];
    CCShaky3D* shaky = [CCShaky3D actionWithRange:10 shakeZ:NO grid:ccg(20,20) duration:5];
    CCRepeatForever* repeat = [CCRepeatForever actionWithAction:shaky];
    [cloud runAction:repeat];
    
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"page3-cloud.png" selectedImage:NULL target:self selector:@selector(playThunder)];
    [button1 setTag:1];
    
    CCMenu *menu = [CCMenu menuWithItems:button1, nil];
    menu.position = ccp(730 , 565);
    [self addChild:menu z:-10 tag:kMenuTag];

    
    
    

}

-(void) playThunder {
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"growl1.wav" pitch:1 pan:1 gain:.5      ];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite* grr = [CCSprite spriteWithFile:@"page3-grr.png"];
    grr.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:grr];
    CCFadeIn* fade = [CCFadeIn actionWithDuration:1];
    [grr runAction:fade];


    
}

-(void) page2grr {
    
    CCLOG(@"**SPECIAL** This is page 2 Grrr setup");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [[SimpleAudioEngine sharedEngine] playEffect:@"growl1.wav"];
    CCSprite* palClosed = [CCSprite spriteWithFile:@"page2-pal-closed.png"];
    [self addChild:palClosed z:6];
    palClosed.position = ccp(screenSize.width / 2, screenSize.height / 2);
    CCSprite* palRight = [CCSprite spriteWithFile:@"page2-pal-open.png"];
    [self addChild:palRight z:6];
    palRight.position = ccp(screenSize.width / 2, screenSize.height / 2);
    CCBlink* blink = [CCBlink actionWithDuration:1 blinks:3];
    [palRight runAction:blink];
        //palRight.visible = 0;
        //CCSprite* shake = [[self getChildByTag:kMenuTag] getChildByTag:1];
        //shake.position = ccp(screenSize.width / 2, screenSize.height / 2);
    //[palRight runAction:[CCShaky3D actionWithRange:10 shakeZ:NO grid:ccg(20,20) duration:1]];
        //[palRight setGrid:nil];
    id shake = [CCShaky3D actionWithRange:10 shakeZ:NO grid:ccg(20,20) duration:1];
    id fade = [CCFadeOut actionWithDuration:.5];
    id sequence = [CCSequence actions:shake, fade, nil];
    
    [palRight runAction:sequence];
        //[palRight setGrid:nil];
    

    //[self setUpPage1];
    
}

-(void) playGrrr {
    
    CCLOG(@"**SPECIAL** This is page 1 Grrr setup");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [[SimpleAudioEngine sharedEngine] playEffect:@"growl1.wav"];
    CCSprite* alClosed = [CCSprite spriteWithFile:@"page1_al_closed.png"];
    [self addChild:alClosed];
    alClosed.position = ccp(screenSize.width / 2, screenSize.height / 2);
    CCSprite* alRight = [CCSprite spriteWithFile:@"page1_al_right.png"];
    [self addChild:alRight];
    alRight.position = ccp(screenSize.width / 2, screenSize.height / 2);
    CCBlink* blink = [CCBlink actionWithDuration:1 blinks:3];
    [alRight runAction:blink];
    alRight.visible = 0;
    //[self setUpPage1];
    
}

-(void) shakeFoliageLeft {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite* foliageLeft = [CCSprite spriteWithFile:@"page1_foliageLeft.png"];
    [self addChild:foliageLeft];
    foliageLeft.position = ccp(screenSize.width / 2, screenSize.height / 2);
    CCShaky3D* shaky = [CCShaky3D actionWithRange:10 shakeZ:NO grid:ccg(20,20) duration:1];
    CCRepeat* repeat = [CCRepeat actionWithAction:shaky times:2];
    [foliageLeft runAction:repeat];
    [[SimpleAudioEngine sharedEngine] playEffect:@"giggle.wav"];

    
}

-(void) shakeFoliageRight {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite* foliageRight = [CCSprite spriteWithFile:@"page1_foliageRight.png"];
    [self addChild:foliageRight];
    foliageRight.position = ccp(screenSize.width / 2, screenSize.height / 2);
    CCShaky3D* shaky = [CCShaky3D actionWithRange:10 shakeZ:NO grid:ccg(20,20) duration:1];
    CCRepeat* repeat = [CCRepeat actionWithAction:shaky times:2];
    [foliageRight runAction:repeat];
    [[SimpleAudioEngine sharedEngine] playEffect:@"giggle.wav"];
    
    
}


-(void) setUpHearts {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"heart.png" selectedImage:@"heart.png" target:self selector:@selector(scaleTheHeart)];
    
    CCMenu *Menu = [CCMenu menuWithItems:button1,  nil];
    Menu.position= CGPointMake(screenSize.width / 2  , 800 );
    CCMoveBy* dropHeart = [CCMoveBy actionWithDuration:10.0 position:ccp(0,-1000)];
    //CCRotateBy* rotateHeart = [CCRotateBy actionWithDuration:10 angle:1720];
    //id sequence = [CCSequence actions:dropHeart, rotateHeart, nil];
    //[Menu runAction:rotateHeart];
    [Menu runAction:dropHeart];
    [self addChild:Menu z:10];

    
}

-(void) scaleTheHeart {
    
    //id grow = [CCScaleTo actionWithDuration:.125 scale:3.0];
    //id shrink = [CCScaleTo actionWithDuration:.125 scale:1.0];
    //id sequence = [CCSequence actions:grow,shrink, nil];
    //[self runAction:sequence];
    [[SimpleAudioEngine sharedEngine] playEffect:@"iLoveYou.wav"];
    
}

-(void) playPageAudioDelay {
    
    //[ self performSelector:@selector(playPageAudio) withObject:nil afterDelay: 1.0 ];
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    [sae playBackgroundMusic:[[BookData sharedData] returnTheCurrentAudioFile] loop:NO];
    [sae pauseBackgroundMusic];
    id a1 = [CCDelayTime actionWithDuration:1.5f]; // delay for 1.5 seconds
    id a2 = [CCCallFunc actionWithTarget:sae selector:@selector(resumeBackgroundMusic)];
    [self runAction:[CCSequence actions:a1, a2, nil]];
    
    
}

-(void) playPageAudio {
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[BookData sharedData] returnTheCurrentAudioFile] loop:NO];
    
    CCLOG(@"playing %@" , [[BookData sharedData]returnTheCurrentAudioFile]);
    
    
}


-(void) setUpPurchaseLink {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"purchase2.png" selectedImage:@"purchase2_over.png" target:self selector:@selector(buyTheBook)];
    
    CCMenu *Menu = [CCMenu menuWithItems:button1,  nil];
    Menu.position= CGPointMake(screenSize.width / 2  , 150 );
    [self addChild:Menu z:10];
}


-(void) buyTheBook {
    
    CCLOG(@"buying the book");
    [[MKStoreManager sharedManager] buyFeatureA];
    
}


-(void) setUpIndexLinks {
    
    CCLOG(@"Setting up the index");
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];  // director is a singleton that stores global config settings and manages the cocos2d scenes
    
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink1)];
    CCMenuItem *button2 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink2)];
    CCMenuItem *button3 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink3)];
    CCMenuItem *button4 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink4)];
    CCMenuItem *button5 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink5)];
    CCMenuItem *button6 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink6)];
    CCMenuItem *button7 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink7)];
    CCMenuItem *button8 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink8)];
    CCMenuItem *button9 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink9)];
    CCMenuItem *button10 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink10)];
    CCMenuItem *button11 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink11)];
    CCMenuItem *button12 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink12)];
    CCMenuItem *button13 = [CCMenuItemImage itemWithNormalImage:@"index_dummy.png" selectedImage:@"index_over.png" target:self selector:@selector(indexLink13)];
    
    CCMenu *Menu = [CCMenu menuWithItems:button1, button2, button3,button4, button5, button6, button7,button8,button9,button10,button11,button12,button13, nil];
    Menu.position= CGPointMake(screenSize.width / 2  , 316 );
    [Menu alignItemsVerticallyWithPadding:0];
    [self addChild:Menu z:10];
    
    
}
-(void)indexLink1 {
    
    [[BookData sharedData] gotoSpecificPage:4];
    [self doAfterChangingPages];
}
-(void)indexLink2 {
    
    [[BookData sharedData] gotoSpecificPage:5];
    [self doAfterChangingPages];
}
-(void)indexLink3 {
    
    [[BookData sharedData] gotoSpecificPage:6];
    [self doAfterChangingPages];
}
-(void)indexLink4 {
    
    [[BookData sharedData] gotoSpecificPage:7];
    [self doAfterChangingPages];
}
-(void)indexLink5 {
    
    [[BookData sharedData] gotoSpecificPage:8]; 
    [self doAfterChangingPages];
}
-(void)indexLink6 {
    
    [[BookData sharedData] gotoSpecificPage:9]; 
    [self doAfterChangingPages];
}
-(void)indexLink7 {
    
    [[BookData sharedData] gotoSpecificPage:10]; 
    [self doAfterChangingPages];
}
-(void)indexLink8 {
    
    [[BookData sharedData] gotoSpecificPage:11];
    [self doAfterChangingPages];
}
-(void)indexLink9 {
    
    [[BookData sharedData] gotoSpecificPage:12]; 
    [self doAfterChangingPages];
}
-(void)indexLink10 {
    
    [[BookData sharedData] gotoSpecificPage:13]; 
    [self doAfterChangingPages];
}
-(void)indexLink11 {
    
    [[BookData sharedData] gotoSpecificPage:14]; 
    [self doAfterChangingPages];
}
-(void)indexLink12 {
    
    [[BookData sharedData] gotoSpecificPage:15]; 
    [self doAfterChangingPages];
}
-(void)indexLink13 {
    
    [[BookData sharedData] gotoSpecificPage:16];
    [self doAfterChangingPages];
}

-(void) doAfterChangingPages {
    
    [[BookData sharedData] turnPage];
    CCTransitionPageTurn* transition = [CCTransitionPageTurn transitionWithDuration:2 scene:[ThePage scene] backwards:NO];
    //CCEaseInOut* easeInOut = [CCEaseInOut actionWithAction:transition rate:10];
    [[CCDirector sharedDirector] replaceScene:transition];
    [[SimpleAudioEngine sharedEngine] playEffect:@"ding.wav"];
    CCLOG(@"I think I played the ding sound in ThePage.m doAfterChangingPages");
    
    
    
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
        
        //increment upward our page number in the BookData class
        
        [[BookData sharedData] turnPage];
        
                
        CCTransitionPageTurn* transition = [CCTransitionPageTurn transitionWithDuration:2 scene:[ThePage scene] backwards:NO];
        [[CCDirector sharedDirector] replaceScene:transition];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ding.wav"];
        CCLOG(@"I think I played the ding sound in ThePage.m ccTouchesBegan");
        
        
    } else if ( location.x < (screenSize.width * .25) && location.y < (screenSize.height * .3) ) {
        
        // decrease our page number in the BookData class
        
        [[BookData sharedData] turnBackPage];
        
        CCLOG(@"touching bottom left to turn the page backward");
        CCTransitionPageTurn* transition = [CCTransitionPageTurn transitionWithDuration:2 scene:[ThePage scene] backwards:YES];
        [[CCDirector sharedDirector] replaceScene:transition];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ding.wav"];
        CCLOG(@"I think I played the ding sound in ThePage.m ccTouchesBegan");

        
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
