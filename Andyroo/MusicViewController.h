//
//  SecondViewController.h
//  Andyroo
//
//  Created by Andrew Flinders on 2/17/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioPlayer.h"

@interface MusicViewController : UIViewController

@property (nonatomic, strong) AudioPlayer *audioPlayer;
@property (nonatomic, strong) AudioPlayer *audioPlayer2;
@property (nonatomic, strong) AudioPlayer *audioPlayer3;

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

@property BOOL isPaused;
@property BOOL scrubbing;

@property BOOL isPaused2;
@property BOOL scrubbing2;

@property BOOL isPaused3;
@property BOOL scrubbing3;

@property NSTimer *timer;

- (IBAction)openAndyrooiTunes:(id)sender;


@end

