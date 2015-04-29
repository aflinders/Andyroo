//
//  VideoPickerViewController.m
//  Andyroo
//
//  Created by Andrew Flinders on 4/27/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import "VideoPickerViewController.h"

@interface VideoPickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *dataSourceArray;
@property (strong, nonatomic) NSDictionary *videos;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation VideoPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    self.dataSourceArray = @[@"Booster Buddy",
                             @"I Wish I Were a Princess",
                             @"Jammin' TQ5",
                             @"2Shybaby 2",
                             @"Booster Buddy Jam",
                             @"Midnight Casanova",
                             @"Monkeys Bedazzling Jam"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    NSUInteger index = [self.dataSourceArray indexOfObjectIdenticalTo:self.selectedVideo];
    [self.pickerView selectRow:index inComponent:0 animated:YES];
}


#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return  self.dataSourceArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSourceArray[row];
    
    
}

#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedVideo = self.dataSourceArray[row];
}
 



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // if user cancels, set selectedVideo to nil
    if (sender == self.cancelButton) {
        self.selectedVideo = nil;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
