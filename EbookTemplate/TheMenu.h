//
//  TheMenu.h
//  EbookTemplate
//
//  Created by Justin's Clone on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ThePage.h"
#import "BookData.h"
#import "Constants.h"
#import "MKStoreManager.h"

@interface TheMenu : CCLayer {
    
    CCMenu *indexAndPurchaseMenu;
    CCSprite *purchaseNotFound; 
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
