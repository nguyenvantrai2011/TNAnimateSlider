//
//  ViewController.m
//  TNSliderCustom
//
//  Created by Trai Nguyen on 11/4/16.
//  Copyright © 2016 Trai Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "TNAnimateSlider.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet TNAnimateSlider *sldCustom;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (IBAction)onclickRefreshButton:(id)sender {
    [UIView animateWithDuration:1.5 animations:^{
        [self.sldCustom setValue:1.0 animated:YES];
    }];
}
- (IBAction)onclickAnimateButton:(id)sender {
    [UIView animateWithDuration:1.5 animations:^{
        [self.sldCustom setValue:7.0 animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
