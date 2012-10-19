//
//  BookData.m
//  EbookTemplate
//
//  Created by Justin's Clone on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookData.h"


@implementation BookData


static BookData *sharedData = nil;

+(BookData*) sharedData {
    
    if (sharedData == nil) {
        sharedData = [[BookData alloc] init] ;
        
    }
    return  sharedData;
    
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        currentPage = 0;
        thePage = [NSString stringWithFormat:@"page%i.png", currentPage];
        theAudioFile = [NSString stringWithFormat:@"audioTrack%i.wav", currentPage];
        
        defaults = [NSUserDefaults standardUserDefaults];
        isBookUnlocked = [defaults boolForKey:@"isTheBookUnlocked" ];
        
        if (isBookUnlocked == NO) {
            
            CCLOG(@" the book isn't unlocked, so lets check if its been purchased in the store...");
            
            if ( [MKStoreManager featureAPurchased] ) { // returns YES if purchases
                
                isBookUnlocked = YES;
                CCLOG(@"We checked with the Store and the book is actually unlocked");
                
            } else {
                
                CCLOG(@"We checked with the Store and the book hasn't been bought");
            }
            
        } else if (isBookUnlocked == YES) {
            
            CCLOG(@"the book was unlocked based on the NSUserDefaults key");
            
        }
        
        
        
    }
    return self;
}

-(void) unlockTheBook {
    
    isBookUnlocked = YES;
    [defaults setBool:YES forKey:@"isTheBookUnlocked" ];
    
    CCLOG(@"Unlock the book");
    
}



-(void) turnPage { 
    
    currentPage ++;
    
    // theMaxNumberOfPages is defined in Constants.h
    
    if (currentPage > theMaxNumberOfPages && isBookUnlocked == YES) {
        
        currentPage = 0;
        
    } else if (currentPage > theMaxNumberOfFreePages  && isBookUnlocked == NO) {
        
        currentPage = 0;
    }
    
    CCLOG(@" Current page is %i", currentPage);
    
    thePage = [NSString stringWithFormat:@"page%i.png", currentPage];
    theAudioFile = [NSString stringWithFormat:@"audioTrack%i.wav", currentPage];
    
}
-(void) turnBackPage { 
    
    currentPage = currentPage - 1;
    
    if (currentPage == -1 && isBookUnlocked == YES) {
        
        currentPage = theMaxNumberOfPages;
        
    } else if (currentPage == -1 && isBookUnlocked == NO ) {
        
        currentPage = theMaxNumberOfFreePages;
    }
    
    CCLOG(@" Current page is %i", currentPage);
    
    thePage = [NSString stringWithFormat:@"page%i.png", currentPage];
    theAudioFile = [NSString stringWithFormat:@"audioTrack%i.wav", currentPage];
    
}

-(int) returnCurrentPageSpecialProperty {
    
    if (currentPage == 26 ) {
        
        return hearts;
        
    } else if (currentPage == 1 ) {
        
        return page1;
        
    } else if (currentPage == 2 ) {
        
        return page2;
        
    } else if (currentPage == 3 ) {
        
        return page3;
        
    } else {
        
        return nothingSpecialToReturn;
        
    }
}

-(bool) isThisBookUnlocked {
    
    return isBookUnlocked;
}

-(NSString*) returnTheCurrentPageString {
    
    return thePage;
    
}

-(NSString*) returnTheCurrentAudioFile {
    
    return theAudioFile;
}


-(void) gotoSpecificPage:(int)thePageToGoTo {
    
    currentPage = thePageToGoTo - 1; 
    
    if ( currentPage > theMaxNumberOfFreePages && isBookUnlocked == NO) {
        
        currentPage = theMaxNumberOfFreePages - 1;
    }
    
    
}


//used for restoring purchases...

-(BOOL) checkForPurchaseA {
    
    if ( [MKStoreManager featureAPurchased] ) { // returns YES if purchases
        
        isBookUnlocked = YES;
        CCLOG(@"We checked with the Store again and the book is actually unlocked");
        
        [defaults setBool:YES forKey:@"isTheBookUnlocked" ];
        [defaults synchronize];
        
        CCLOG(@"Unlock the book");
        
        return YES;
    } else {
        
        return NO;
    }
}



@end
