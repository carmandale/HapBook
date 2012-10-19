//
//  BookData.h
//  EbookTemplate
//
//  Created by Justin's Clone on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "MKStoreManager.h"

@interface BookData : CCNode {
    
    int currentPage;
    NSString* thePage;
    NSString* theAudioFile;
    
    BOOL isBookUnlocked;
    NSUserDefaults *defaults;
    
}

+(BookData*) sharedData;

-(void) turnPage;
-(void) turnBackPage; 
-(NSString*) returnTheCurrentPageString;
-(NSString*) returnTheCurrentAudioFile;
-(int) returnCurrentPageSpecialProperty;
-(void) gotoSpecificPage:(int)thePageToGoTo;
-(void) unlockTheBook;
-(bool) isThisBookUnlocked;
-(BOOL) checkForPurchaseA;


@end
