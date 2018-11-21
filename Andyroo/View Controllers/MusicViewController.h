//
//  MusicViewController.h
//  Andyroo
//
//  Created by Andrew Flinders on 2/17/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioPlayer.h"

@interface MusicViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *timeElapsed;

@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider2;
@property (weak, nonatomic) IBOutlet UIButton *playButton2;
@property (weak, nonatomic) IBOutlet UILabel *duration2;
@property (weak, nonatomic) IBOutlet UILabel *timeElapsed2;

@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider3;
@property (weak, nonatomic) IBOutlet UIButton *playButton3;
@property (weak, nonatomic) IBOutlet UILabel *duration3;
@property (weak, nonatomic) IBOutlet UILabel *timeElapsed3;


@end

