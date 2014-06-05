//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Praveen P N on 6/4/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property NSUserDefaults *defaults;

- (IBAction)tipControlChanged:(id)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setupDefaults];

    
}

- (void) setupDefaults {
    //load the default settings values (if any)
    self.defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [self.defaults integerForKey:@"defaultTip"];
    
    //set the tip contorl to that value
    [self.defaultTipControl setSelectedSegmentIndex: intValue];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveSettings {
    //get the selected value
    int tip = [self.defaultTipControl selectedSegmentIndex];
    
    //convert it
    NSString *tipString = [NSString stringWithFormat:@"%d",tip];
    
    [self.defaults setObject:tipString forKey:@"defaultTip"];
    
    //imp. don't forget to synchronize (save in other words)
    [self.defaults synchronize];
}

- (IBAction)tipControlChanged:(id)sender {
    [self saveSettings];
}
@end
