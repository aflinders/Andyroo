//
//  InfoViewController.m
//  Andyroo
//
//  Created by Andrew Flinders on 5/1/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Scroll to top of textview
    NSRange r  = {0,0};
    [self.textView scrollRangeToVisible:r];
    // Do any additional setup after loading the view.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    // Scroll to top of textview after orientation change
    NSRange r  = {0,0};
    [self.textView scrollRangeToVisible:r];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
