//
//  VideosViewController.h
//  Andyroo
//
//  Created by Andrew Flinders on 2/18/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideosViewController : UIViewController <UIWebViewDelegate>

- (IBAction)unwindToVideo:(UIStoryboardSegue *)segue;

@end
