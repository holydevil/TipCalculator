//
//  TipViewController.m
//  tipCalculator
//
//  Created by Praveen P N on 6/3/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //change keyboard to a numeric keypad
    [self.billTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    [self.billTextField becomeFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateView {
    float bill, tip, total;
    //get the bill amount
    bill = [self.billTextField.text floatValue];
    
    //get the tip amount
    int tempTip = [self.tipControl selectedSegmentIndex];
    
    //set tip values based on which segment is selected
    switch (tempTip) {
        case 0:
            tip = bill*0.10;
            break;
        case 1:
            tip = bill*0.15;
            break;
        case 2:
            tip = bill*0.20;
        default:
            break;
    }
    
    //do the math
    total = bill + tip;
    
    //change the label of total to bill+tip
    NSLog(@"values are, bill = %f, tip = %f, total = %f", bill, tip, total);
    
    //set both labels with calculated values
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f",total];
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f",tip];
}

- (IBAction)onTap:(id)sender {
    [self updateView];
    
    //hide keyboard
    [self.view endEditing:YES];
}

- (IBAction)tipControlChanged:(id)sender {
    [self updateView];
    
    //hide keyboard
    [self.view endEditing:YES];
}

- (IBAction)tipEdited:(id)sender {
    [self updateView];
}
@end
