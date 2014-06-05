//
//  TipViewController.m
//  tipCalculator
//
//  Created by Praveen P N on 6/3/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property  NSNumberFormatter *currencyFormatter;

- (IBAction)onTap:(id)sender;
@end

int cachedSelection = -1;

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


- (void) setupDefaults {

    //change keyboard to a numeric keypad
    [self.billTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    // set focus on inpout value
    [self.billTextField becomeFirstResponder];
    
    //setup l10n
    self.currencyFormatter = [[NSNumberFormatter alloc]init];
    [self.currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [self.currencyFormatter setLocale:[NSLocale currentLocale]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefaults];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    if (cachedSelection >=0) {
        // Don't change value if user has a value selected
        [self.tipControl setSelectedSegmentIndex: cachedSelection];
        
    } else {
        //once the view loads, load the default settings value (if any)
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int intValue = [defaults integerForKey:@"defaultTip"];
        //set the tip contorl to that value
        [self.tipControl setSelectedSegmentIndex: intValue];
    }
    
    [self updateView];
    
}


- (void) onSettingsButton {
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:settingsViewController animated:YES];
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
    
    self.totalLabel.text = [self.currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    self.tipLabel.text = [self.currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    
}

- (IBAction)onTap:(id)sender {
    [self updateView];
    
    //hide keyboard
    [self.view endEditing:YES];
}

- (IBAction)tipControlChanged:(id)sender {
    [self updateView];
    
    //cache the value
    cachedSelection = [self.tipControl selectedSegmentIndex];
    
    //hide keyboard
    [self.view endEditing:YES];
}

- (IBAction)tipEdited:(id)sender {
    [self updateView];
}
@end
