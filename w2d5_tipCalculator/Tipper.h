//
//  Tipper.h
//  w2d5_tipCalculator
//
//  Created by Seantastic31 on 07/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tipper : NSObject

@property (strong, nonatomic) NSDecimalNumber *billAmount;
@property (strong, nonatomic) NSDecimalNumber *tipPercentage;

- (instancetype)initWithBillAmount:(NSDecimalNumber*)billAmount TipPercentage:(NSDecimalNumber*)tipPercentage;
- (NSDecimalNumber*)calculateTipWithBillAmount:(NSDecimalNumber*)billAmount andTipPercentage:(NSDecimalNumber*)tipPercentage;

@end
