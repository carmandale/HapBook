//
//  TheMenu.m
//  EbookTemplate
//
//  Created by Justin's Clone on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TheMenu.h"


@implementation TheMenu

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TheMenu *layer = [TheMenu node];
	
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
		
        CCLOG(@"initializing TheMenu layer");
                
	}
	return self;
}

-(void) restorePurchases{
    
    if ( [[BookData sharedData] checkForPurchaseA] == YES ) {
        
        [self removeChild:purchaseNotFound cleanup:NO];
        [self removeChild:indexAndPurchaseMenu cleanup:NO];
        [self buildMenuWithIndexOnly];
        
        CCLOG(@"purchase restored");
        
    } else {
        
        CCLOG(@"purchase NOT restored");
        [self removeChild:purchaseNotFound cleanup:NO]; //remove in case it's already there
        purchaseNotFound = [CCSprite spriteWithFile:@"purchase_not_found.png"];
        purchaseNotFound.position = ccp(845, 75);
        [self addChild:purchaseNotFound z:20];
    }

}

-(void) buildMenuWithIndexOnly {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItem *button3 = [CCMenuItemImage itemWithNormalImage:@"index_button.png" selectedImage:@"index_button.png" target:self selector:@selector(gotoIndex)];
    
    indexAndPurchaseMenu = [CCMenu menuWithItems:button3,  nil];
    indexAndPurchaseMenu.position = ccp(screenSize.width / 2 , 160);
    [self addChild:indexAndPurchaseMenu z:2];

    
    
}
-(void) buildMenuWithIndexPurchaseAndRestoreButton {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItem *button3 = [CCMenuItemImage itemWithNormalImage:@"index_button.png" selectedImage:@"index_button.png" target:self selector:@selector(gotoIndex)];
    CCMenuItem *button4 = [CCMenuItemImage itemWithNormalImage:@"purchase.png" selectedImage:@"purchase_over.png" target:self selector:@selector(buyTheBook)];
    CCMenuItem *button5 = [CCMenuItemImage itemWithNormalImage:@"restore.png" selectedImage:@"restore_over.png" target:self selector:@selector(restorePurchases)];
    
    indexAndPurchaseMenu = [CCMenu menuWithItems:button3, button4,button5, nil];
    indexAndPurchaseMenu.position = ccp(screenSize.width / 2 , 160);
    [indexAndPurchaseMenu alignItemsHorizontallyWithPadding:0];
    [self addChild:indexAndPurchaseMenu z:2];
    
}



-(void) gotoSeenCreative {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.seencreative.co.uk"]];
    
}
-(void) gotoCartoonSmart {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.cartoonsmart.com"]];
    
}

-(void) gotoIndex {
    
    
}

-(void) buyTheBook {
    
    CCLOG(@"buying the book");
    [[MKStoreManager sharedManager] buyFeatureA];
    
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[CCDirector sharedDirector] popScene];
    
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
