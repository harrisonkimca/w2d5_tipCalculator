//
//  TipperViewController.m
//  w2d5_tipCalculator
//
//  Created by Seantastic31 on 07/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//
//  Methods are applied to both billAmountTextField & tipPercentageTextField together
//  Use tags to apply methods separately if needed (ie, empty textfield

#import "TipperViewController.h"
#import "Tipper.h"

@interface TipperViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageField;
@property (strong, nonatomic) Tipper *tipper;

@end

@implementation TipperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set delegates
    self.billAmountTextField.delegate = self;
    self.tipPercentageField.delegate = self;
    
    NSDecimalNumber *initialBillAmount = [[NSDecimalNumber alloc]initWithFloat:0.00];
    NSDecimalNumber *initialTipAmount = [[NSDecimalNumber alloc]initWithFloat:0.15];
    
    self.tipper = [[Tipper alloc]initWithBillAmount:initialBillAmount TipPercentage:initialTipAmount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)caculateTipButton:(UIButton *)sender
{
    [self calculateTip];
}

// COMMENT THIS OUT TO REACTIVATE BUTTON
//- (IBAction)adjustTipPercentage:(UISlider *)sender
//{
//    self.tipPercentageField.text = [NSString stringWithFormat:@"%.f", [sender value]];
//    [self calculateTip];
//}

- (void)calculateTip
{
    NSDecimalNumber *billAmount = [[NSDecimalNumber alloc]initWithString:@"0"];
    NSDecimalNumber *tipPercentage = [[NSDecimalNumber alloc]initWithString:@"15"];
    NSDecimalNumber *tipAmount = [[NSDecimalNumber alloc]initWithString:@"0"];
    NSDecimalNumber *percentConversion = [[NSDecimalNumber alloc]initWithString:@"100"];
    
    // app will crash if nothing or non-numbers are entered into the text fields
    NSCharacterSet *invalid = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    // require both text fields to be filled with decimal numbers
    if ([self.billAmountTextField.text rangeOfCharacterFromSet:invalid].location == NSNotFound && [self.tipPercentageField.text rangeOfCharacterFromSet:invalid].location == NSNotFound)
    {
        // also require non-empty fields to run calculation
        if (![self.billAmountTextField.text isEqualToString:@""] && ![self.tipPercentageField.text isEqualToString:@""])
        {
            billAmount = [[NSDecimalNumber alloc]initWithString:self.billAmountTextField.text];
            tipPercentage = [[NSDecimalNumber alloc]initWithString:self.tipPercentageField.text];
            tipPercentage = [tipPercentage decimalNumberByDividingBy:percentConversion];
            tipAmount = [self.tipper calculateTipWithBillAmount:billAmount andTipPercentage:tipPercentage];
        }
        else // error handle
        {
            tipAmount = [self.tipper calculateTipWithBillAmount:billAmount andTipPercentage:tipPercentage];
        }
        NSNumberFormatter *formatDollars = [[NSNumberFormatter alloc]init];
        [formatDollars setNumberStyle:NSNumberFormatterCurrencyStyle];
        [formatDollars setCurrencyCode:@"USD"];
        
        self.tipAmountLabel.text = [formatDollars stringFromNumber:tipAmount];
    }
    else // error handle
    {
        self.tipAmountLabel.text = @"$0.00";
    }
}




// ********** UITEXTFIELD DELEGATE USES NOTIFICATIONS TO POP UP KEYBOARD AND UPDATE TEXT FIELDS **********
// ********** delegate methods determine when events occur and notifications interact with the UI **********
// http://www.vigorouscoding.com/2012/02/adjusting-a-uiview-to-an-appearing-keyboard/
// https://www.youtube.com/watch?v=WB-QCv_4ANU

// STRETCH: open keyboard & selector
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    return YES; // returning YES allows editing
}
// COMMENT THIS OUT TO REACTIVATE BUTTON
// STRETCH: automatically update textfield
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(calculateTip) name:UITextFieldTextDidChangeNotification object:nil];
//    return YES;
//}

// STRETCH: close keyboard (but need event to trigger ==> CUSTOM TOUCH DETECTION)
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.view endEditing:YES];
}
// STRETCH: close keyboard and calculate tip when return hit
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.view endEditing:YES];
    [self calculateTip];
    return NO;
}
// STRETCH: animate up frame to show keyboard without covering anything up
- (void)keyboardWillShow:(NSNotificationCenter*)notification
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, -110, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
// STRETCH: animate keyboard back down
- (void)keyboardWillHide:(NSNotificationCenter*)notification
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
// STRETCH: use CUSTOM TOUCH DETECTION to so touching anywhere on screen resigns first reponder
// https://code.tutsplus.com/tutorials/ios-quick-tip-detecting-touches--mobile-6773
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.billAmountTextField resignFirstResponder];
    [self.tipPercentageField resignFirstResponder];
}

@end
