//
//  AudioPlayer.h
//  Andyroo
//
//  Created by Andrew Flinders on 2/19/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : UIViewController

@property (nonatomic, retain) AVAudioPlayer *avAudioPlayer;

// Public methods
- (void)initPlayer:(NSString*) audioFile fileExtension:(NSString*)fileExtension;
- (void)playAudio;
- (void)pauseAudio;
- (void)setCurrentAudioTime:(float)value;
- (float)getAudioDuration;
- (NSString*)timeFormat:(float)value;
- (NSTimeInterval)getCurrentAudioTime;

@end
