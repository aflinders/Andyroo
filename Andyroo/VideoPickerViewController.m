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
@property (strong, nonatomic) NSArray *videosArray;
@property (strong, nonatomic) NSDictionary *videos;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation VideoPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Retrieve the list of music videos from user defaults.
    // In next version, app will sync with Andyroo.com to retrieve updated list.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.videosArray = [userDefaults stringArrayForKey:@"VideosArray"];
    
    if (self.videosArray == nil) {
        // This is the standard set of music videos. Save them to user defaults.
        self.videosArray = @[@"Booster Buddy",
                             @"I Wish I Were a Princess",
                             @"Jammin' TQ5",
                             @"2Shybaby 2",
                             @"Booster Buddy Jam",
                             @"Midnight Casanova",
                             @"Monkeys Bedazzling Jam"];
        
        [userDefaults setObject:self.videosArray forKey:@"VideosArray"];
        [userDefaults synchronize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    // Set the picker view to the currently selected video.
    NSUInteger index = 0;
    for (NSUInteger i = 0; i < [self.videosArray count]; i++) {
        NSString *video = [self.videosArray objectAtIndex:i];
        if ([video isEqualToString:self.selectedVideo]) {
            index = i;
            break;
        }
    }
    [self.pickerView selectRow:index inComponent:0 animated:YES];
}


#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  self.videosArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.videosArray[row];
}

#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedVideo = self.videosArray[row];
}
 

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // if user cancels, set selectedVideo to nil
    if (sender == self.cancelButton) {
        self.selectedVideo = nil;
    }
    else {
        // Save the selected video to user defaults.
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.selectedVideo forKey:@"SelectedVideo"];
        [userDefaults synchronize];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
