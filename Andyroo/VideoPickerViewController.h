//
//  VideoPickerViewController.h
//  Andyroo
//
//  Created by Andrew Flinders on 4/27/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) NSString *selectedVideo;

@end
