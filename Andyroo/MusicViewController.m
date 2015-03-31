//
//  MusicViewController.m
//  Andyroo
//
//  Created by Andrew Flinders on 2/17/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@property (nonatomic, strong) AudioPlayer *audioPlayer;
@property (nonatomic, strong) AudioPlayer *audioPlayer2;
@property (nonatomic, strong) AudioPlayer *audioPlayer3;

@property NSArray *audioPlayers;
@property NSArray *currentTimeSliders;
@property NSArray *durations;
@property NSArray *playButtons;
@property NSArray *timesElapsed;
@property NSMutableArray *paused;
@property NSMutableArray *scrubbing;
@property NSTimer *timer;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *sliders = [NSMutableArray arrayWithCapacity:3];
    [sliders addObject:self.currentTimeSlider];
    [sliders addObject:self.currentTimeSlider2];
    [sliders addObject:self.currentTimeSlider3];
    self.currentTimeSliders = [NSArray arrayWithArray: sliders];
    
    NSMutableArray *elapsedLabels = [NSMutableArray arrayWithCapacity:3];
    [elapsedLabels addObject:self.timeElapsed];
    [elapsedLabels addObject:self.timeElapsed2];
    [elapsedLabels addObject:self.timeElapsed3];
    self.timesElapsed = [NSArray arrayWithArray: elapsedLabels];
    
    NSMutableArray *durationLabels = [NSMutableArray arrayWithCapacity:3];
    [durationLabels addObject:self.duration];
    [durationLabels addObject:self.duration2];
    [durationLabels addObject:self.duration3];
    self.durations = [NSArray arrayWithArray: durationLabels];
    
    NSMutableArray *playButtons = [NSMutableArray arrayWithCapacity:3];
    [playButtons addObject:self.playButton];
    [playButtons addObject:self.playButton2];
    [playButtons addObject:self.playButton3];
    self.playButtons = [NSArray arrayWithArray: playButtons];
    
    self.paused = [NSMutableArray arrayWithArray:@[@TRUE,@TRUE,@TRUE]];
    
    NSMutableArray *players = [NSMutableArray arrayWithCapacity:3];
    
    self.audioPlayer = [[AudioPlayer alloc] init];
    [players addObject:self.audioPlayer];
    
    self.audioPlayer2 = [[AudioPlayer alloc] init];
    [players addObject:self.audioPlayer2];
    
    self.audioPlayer3 = [[AudioPlayer alloc] init];
    [players addObject:self.audioPlayer3];
    
    self.audioPlayers = [NSArray arrayWithArray:players];
    
    [self setupAudioPlayer:@"Booster Buddy MP3" atIndex:0];
    [self setupAudioPlayer:@"Wizard Love MP3" atIndex:1];
    [self setupAudioPlayer:@"Monkeys Bedazzling MP3" atIndex:2];
    

    // Do any additional setup after loading the view, typically from a nib.
}

/*
 * Setup the audio player with MP3 file
 * and initialize the time labels.
 */
- (void)setupAudioPlayer:(NSString*)fileName atIndex:(NSUInteger)index
{
    //insert Filename & FileExtension
    NSString *fileExtension = @"mp3";
    
    //init the Player to get file properties to set the time labels
    AudioPlayer *player = self.audioPlayers[index];
    [player initPlayer:fileName fileExtension:fileExtension];
    
    UISlider *slider = self.currentTimeSliders[index];
    slider.maximumValue = [player getAudioDuration];
    
    //init the current timedisplay and the labels. if a current time was stored
    //for this player then take it and update the time display
    UILabel *elapsedLabel = self.timesElapsed[index];
    elapsedLabel.text = @"0:00";
    
    UILabel *durationLabel = self.durations[index];
    durationLabel.text = [NSString stringWithFormat:@"-%@",
                          [player timeFormat:[player getAudioDuration]]];
    
}

/*
 * Pause all other audio players except
 * for the one at the playingIndex.
 */

-(void)pauseOtherAudioPlayers:(NSUInteger) playingIndex {
    
    int index = 0;
    for (; index < 3; index++) {
        if (index == playingIndex)
            continue;
        if (![self.paused[index] boolValue]) {
            [self.playButtons[index] setImage:[UIImage imageNamed:@"play button"]
                        forState:UIControlStateNormal];
            [self.audioPlayers[index] pauseAudio];
            self.paused[index] = @TRUE;
        }
    }
    
}

/*
 * PlayButton is pressed
 * plays or pauses the audio and sets
 * the play/pause image of the button
 */
- (IBAction)playAudioPressed:(id)playButton
{
    [self.timer invalidate];
    
    int index = 0;
    for (; index < 3; index++) {
        if (playButton == self.playButtons[index])
            break;
    }
    
    //play audio for the first time or if paused
    if ([self.paused[index] boolValue]) {
        [playButton setImage:[UIImage imageNamed:@"pause button"]
                                   forState:UIControlStateNormal];
        
        [self pauseOtherAudioPlayers:index];
        
        //start a timer to update the time label display
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateTime:)
                                                    userInfo:[NSNumber numberWithInt:index]
                                                     repeats:YES];
        
        [self.audioPlayers[index] playAudio];
        self.paused[index] = @FALSE;
        
    } else {
        //pause the audio and set button to play again
        [playButton setImage:[UIImage imageNamed:@"play button"]
                                   forState:UIControlStateNormal];
        
        [self.audioPlayers[index] pauseAudio];
        self.paused[index] = @TRUE;
    }
}

/*
 * Updates the time label display and
 * the current value of the slider
 * while audio is playing
 */
- (void)updateTime:(NSTimer *)timer {
    
    NSNumber *num = timer.userInfo;
    int index = [num intValue];
    UISlider *slider = self.currentTimeSliders[index];
    AudioPlayer *player = self.audioPlayers[index];
    UILabel *elapsedLabel = self.timesElapsed[index];
    UILabel *durationLabel = self.durations[index];
    if (![self.scrubbing[index] boolValue]) {
        slider.value = [player getCurrentAudioTime];
    }
    elapsedLabel.text = [NSString stringWithFormat:@"%@",
                             [player timeFormat:[player getCurrentAudioTime]]];
    
    durationLabel.text = [NSString stringWithFormat:@"-%@",
                          [player timeFormat:[player getAudioDuration] - [player getCurrentAudioTime]]];
}

/*
 * Sets the current value of the slider
 * to the audio file when slider is used
 */
- (IBAction)setCurrentTime:(id)scrubber {
    
    UISlider *slider = scrubber;
    int index = 0;
    for (; index < 3; index++) {
        if (self.currentTimeSliders[index] == slider)
            break;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(updateTime:)
                                   userInfo:[NSNumber numberWithInt:index]
                                    repeats:NO];
    
    AudioPlayer *player = self.audioPlayers[index];
    [player setCurrentAudioTime:slider.value];
    self.scrubbing[index] = @FALSE;
}

/*
 * Sets if the user is scrubbing right now
 * to avoid slider update while dragging the slider
 */
- (IBAction)userIsScrubbing:(id)sender {
    UISlider *slider = sender;
    int index = 0;
    for (; index < 3; index++) {
        if (self.currentTimeSliders[index] == slider)
            break;
    }
    self.scrubbing[index] = @TRUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Opens the Andyroo music catalog in iTunes.
 */

- (IBAction)openAndyrooiTunes:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/artist/andyroo/id567828684"]];
}

@end
