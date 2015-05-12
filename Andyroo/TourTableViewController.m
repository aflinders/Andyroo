//
//  TourTableViewController.m
//  Andyroo
//
//  Created by Andrew Flinders on 5/10/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import "TourTableViewController.h"
#import "NewsItem.h"

@interface TourTableViewController ()

@property (strong, nonatomic) NSArray *newsItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TourTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsItems = [self getNewsItems];
    
}

- (NSArray*) getNewsItems {
    
    // Right now create statically with test data.
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    NewsItem *item = [[NewsItem alloc] init];
    item.type = News;
    item.headline = @"New music album Andyroo 5 Alive coming soon.";
    item.info = @"Andyroo is currently working on his 5th major music album, Andyroo 5 Alive, and will soon release a short version of the album as an EP on iTunes. The album features new songs such as Shake Your Body, Time Boy 2, and Ethereal Trance Number 262, all of which can be experienced now for free on YouTube. The album marks a return to Andyroo's 'happy dance music' and is 'very early 80s,' featuring lots of Yamaha DX7, Roland TR-707 and Fairlight C.M.I., the venerable musical instruments of the decade, which Andyroo combines with the sounds of his modern Yamaha Motif workstation.";
    
    NSString *startTimeString = @"Sun, 10 May 2015 16:45:00 -0500";
    NSString *endTimeString = @"Fri, 10 July 2015 16:45:00 -0500";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    item.startTime = [dateFormatter dateFromString:startTimeString];
    item.endTime = [dateFormatter dateFromString:endTimeString];
    
    [items addObject:item];
    
    item = [[NewsItem alloc] init];
    item.type = Performance;
    item.headline = @"Andyroo plays the Midway Cafe.";
    item.info = @"Andyroo plays the Midway Cafe in Jamaica Plain, Boston, USA. Doors open at 8:30 p.m.";
    item.country = @"USA";
    item.streetAddress = @"3496 Washington Street";
    item.city = @"Jamaica Plain, Boston";
    item.state = @"Massachusetts";
    item.postalCode = @"02130";
    
    startTimeString = @"Wed, 20 May 2015 20:30:00 -0500";
    endTimeString = nil;
    item.startTime = [dateFormatter dateFromString:startTimeString];
    
    [items addObject:item];
    
    return [NSArray arrayWithArray:items];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.newsItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsItem" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
