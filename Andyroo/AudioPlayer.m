//
//  AudioPlayer.m
//  Andyroo
//
//  Created by Andrew Flinders on 2/19/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer

/*
 * Init the Player with Filename and FileExtension
 */
- (void)initPlayer:(NSString*) audioFile fileExtension:(NSString*)fileExtension
{
    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:audioFile withExtension:fileExtension];
    NSError *error;
    self.avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
}

/*
 * Simply fire the play Event
 */
- (void)playAudio {
    [self.avAudioPlayer play];
}

/*
 * Simply fire the pause Event
 */
- (void)pauseAudio {
    [self.avAudioPlayer pause];
}

/*
 * Format the float time values like duration
 * to format with minutes and seconds
 */
-(NSString*)timeFormat:(float)value{
    
    float minutes = floor(lroundf(value)/60);
    float seconds = lroundf(value) - (minutes * 60);
    
    int roundedSeconds = (int) lroundf(seconds);
    int roundedMinutes = (int) lroundf(minutes);
    
    NSString *time = [[NSString alloc]
                      initWithFormat:@"%d:%02d",
                      roundedMinutes, roundedSeconds];
    return time;
}

/*
 * To set the current Position of the
 * playing audio File
 */
- (void)setCurrentAudioTime:(float)value {
    [self.avAudioPlayer setCurrentTime:value];
}

/*
 * Get the time where audio is playing right now
 */
- (NSTimeInterval)getCurrentAudioTime {
    return [self.avAudioPlayer currentTime];
}

/*
 * Get the whole length of the audio file
 */
- (float)getAudioDuration {
    return [self.avAudioPlayer duration];
}

@end
