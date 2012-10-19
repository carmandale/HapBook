//
//  IntroLayer.m
//  EbookTemplate
//
//  Created by Justin Dike on 7/19/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "TheBook.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(void) onEnter
{
	[super onEnter];

	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];

    //right now IntroLayer.png is the same image (not file though ) as the startup image, but you can include any graphic you want...

	CCSprite *background = [CCSprite spriteWithFile:@"IntroLayer.png"]; 
	
	background.position = ccp(size.width/2, size.height/2);

	// add the label as a child to this Layer
	[self addChild: background];
	
	// In one second transition to the new scene
	[self scheduleOnce:@selector(makeTransition:) delay:0];
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TheBook scene] ]];
    //CCWaves3D* waves = [CCWaves3D actionWithWaves:5 amplitude:25 grid:ccg(20, 20) duration:2.0];
    //CCRepeatForever* repeat = [CCRepeatForever actionWithAction:waves];
    //[self runAction:repeat];
    
}
@end
