//
//  VideosViewController.m
//  Andyroo
//
//  Created by Andrew Flinders on 2/18/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import "VideosViewController.h"

@interface VideosViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *videoView;

@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initVideos];
}

- (void)initVideos {
    NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/watch?v=V5UUHbRzjek"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.videoView loadRequest:request];
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

@end
