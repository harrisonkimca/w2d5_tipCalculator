//
//  TipperViewController.m
//  w2d5_tipCalculator
//
//  Created by Seantastic31 on 07/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "TipperViewController.h"

@interface TipperViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageField;

@end

@implementation TipperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)caculateTipButton:(UIButton *)sender {
}


- (IBAction)adjustTipPercentage:(UISlider *)sender {
}


@end
