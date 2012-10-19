//
//  MKStoreObserver.m
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//

#import "MKStoreObserver.h"
#import "MKStoreManager.h"

@implementation MKStoreObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	for (SKPaymentTransaction *transaction in transactions)
	{
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:
				
                [self completeTransaction:transaction];
				
				NSLog(@"Purchase was a success -J");
                break;
				
            case SKPaymentTransactionStateFailed:
				
                [self failedTransaction:transaction];
				NSLog(@"SKPaymentTransactionStateFailed -J");
                break;
				
            case SKPaymentTransactionStateRestored:
				NSLog(@"SKPaymentTransactionStateRestored -J");
                [self restoreTransaction:transaction];
				
            default:
				
                break;
		}			
	}
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{	
    if (transaction.error.code != SKErrorPaymentCancelled)		
    {	
        NSLog(@"failedTransaction is run -J");
        // Optionally, display an error here.		
    }	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];	
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{		
    NSLog(@"completeTransaction is run -J");
    [[MKStoreManager sharedManager] provideContent: transaction.payment.productIdentifier];	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];	
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{	
    NSLog(@"restoreTransaction is run -J");
    [[MKStoreManager sharedManager] provideContent: transaction.originalTransaction.payment.productIdentifier];	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];	
}

@end
