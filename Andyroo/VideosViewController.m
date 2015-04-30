//
//  VideosViewController.m
//  Andyroo
//
//  Created by Andrew Flinders on 2/18/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import "VideosViewController.h"
#import "VideoPickerViewController.h"
#import "Reachability.h"

@interface VideosViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *videoView;
@property (strong, nonatomic) NSDictionary *videos;
@property (strong, nonatomic) NSString *selectedVideo;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.selectedVideo = [userDefaults stringForKey:@"SelectedVideo"];

    if (self.selectedVideo == nil) {
        self.selectedVideo = @"Booster Buddy";
    }
    
    self.videos = [userDefaults dictionaryForKey:@"VideoURLs"];
    
    if (self.videos == nil) {
        NSMutableDictionary *videoMap = [[NSMutableDictionary alloc] initWithCapacity:7];
        [videoMap setValue:@"www.youtube.com/watch?v=V5UUHbRzjek" forKey:@"Booster Buddy"];
        [videoMap setValue:@"www.youtube.com/watch?v=5smoXLztStE" forKey:@"I Wish I Were a Princess"];
        [videoMap setValue:@"www.youtube.com/watch?v=_j1uw_HyPI4" forKey:@"Jammin' TQ5"];
        [videoMap setValue:@"www.youtube.com/watch?v=oFGzsQwDnrw" forKey:@"2Shybaby 2"];
        [videoMap setValue:@"www.youtube.com/watch?v=WslyRrA6T4w" forKey:@"Midnight Casanova"];
        [videoMap setValue:@"www.youtube.com/watch?v=5uh9-2FDu1s" forKey:@"Booster Buddy Jam"];
        [videoMap setValue:@"www.youtube.com/watch?v=_ytclAOUrfo" forKey:@"Monkeys Bedazzling Jam"];
        
        self.videos = [NSDictionary dictionaryWithDictionary:videoMap];
        
        [userDefaults setObject:self.videos forKey:@"VideoURLs"];
        [userDefaults synchronize];
    }
    
    [self initVideo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"PickVideo"])
    {
        // Get reference to the destination view controller
        VideoPickerViewController *dest = [segue destinationViewController];
        
        // Pass any objects to the view controller here
        dest.selectedVideo = self.selectedVideo;
    }
}

- (IBAction)unwindToVideo:(UIStoryboardSegue *)segue {
    VideoPickerViewController *source = [segue sourceViewController];
    if ([source.selectedVideo length] > 0) {
        self.selectedVideo = source.selectedVideo;
        [self initVideo];
    }
}

- (void)initVideo {
    
    // Check Internet connection
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        self.statusLabel.text = @"! No Internet connection !";
        [self.statusLabel setHidden:false];
    }
    else {
        self.statusLabel.text = @"Loading video...";
        [self.statusLabel setHidden:false];
    
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"https://", [self.videos valueForKey:self.selectedVideo]];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.videoView setDelegate:self];
        [self.videoView loadRequest:request];
    }
}

- (IBAction)openAndyrooDotCom:(id)sender {
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.andyroo.com"]];
    }
}

- (IBAction)openAndyrooYouTube:(id)sender {
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/channel/UCsgoouwNAL_0ikhk-ImbT4w"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIWebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.statusLabel setHidden:true];
}




@end
