//
//  Tipper.m
//  w2d5_tipCalculator
//
//  Created by Seantastic31 on 07/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "Tipper.h"

@implementation Tipper

- (instancetype)initWithBillAmount:(NSDecimalNumber *)billAmount TipPercentage:(NSDecimalNumber *)tipPercentage
{
    self = [super init];
    if (self) {
        _billAmount = billAmount;
        _tipPercentage = tipPercentage;
    }
    return self;
}

- (NSDecimalNumber*)calculateTipWithBillAmount:(NSDecimalNumber*)billAmount andTipPercentage:(NSDecimalNumber*)tipPercentage
{
    self.billAmount = billAmount;
    self.tipPercentage = tipPercentage;
    return [self.billAmount decimalNumberByMultiplyingBy:tipPercentage];
}


@end
