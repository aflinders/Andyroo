//
//  TourTableViewController.m
//  Andyroo
//
//  Created by Andrew Flinders on 5/10/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import "TourTableViewController.h"
#import "NewsItem.h"
#import "Address.h"
#import "AppDelegate.h"

@interface TourTableViewController ()

@property (strong, nonatomic) NSArray *newsItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSURLConnection *newsConnection;
@property (strong, nonatomic) NSMutableData *newsData;
@property (strong, nonatomic) NSArray *newsArray;

@end

@implementation TourTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsItems = [self getNewsItems];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self startNewsConnection];
}


- (NSArray*) getNewsItems {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
        
    // Create Managed Object
    NewsItem *item = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"NewsItem"
                                    inManagedObjectContext:appDelegate.managedObjectContext];

    
    // Right now create statically with test data.
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    
    item.type = News;
    item.headline = @"Andyroo 5 Alive, new music album coming soon.";
    item.info = @"Andyroo is currently working on his 5th major music album, Andyroo 5 Alive, and will soon release a short version of the album as an EP on iTunes. The album features new songs such as Shake Your Body, Time Boy 2, and Ethereal Trance Number 262, all of which can be experienced now for free on YouTube. The album marks a return to Andyroo's 'happy dance music' and is 'very early 80s,' featuring lots of Yamaha DX7, Roland TR-707 and Fairlight C.M.I., the venerable musical instruments of the decade, which Andyroo combines with the sounds of his modern Yamaha Motif workstation.";
    
    NSString *startTimeString = @"Thu, 21 May 2015 16:45:00 -0500";
    NSString *endTimeString = @"Fri, 10 July 2015 16:45:00 -0500";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    item.startTime = [dateFormatter dateFromString:startTimeString];
    item.endTime = [dateFormatter dateFromString:endTimeString];
    
    NSError *error = nil;
    if (![item.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    [items addObject:item];
    
    
    item = [NSEntityDescription
            insertNewObjectForEntityForName:@"NewsItem"
            inManagedObjectContext:appDelegate.managedObjectContext];
    item.type = Performance;
    item.headline = @"Midway Cafe in Jamaica Plain, Boston, USA.";
    item.info = @"Andyroo plays the Midway Cafe in Jamaica Plain, Boston, USA. Doors open at 8:30 p.m.";
    
    Address *address = [NSEntityDescription
            insertNewObjectForEntityForName:@"Address"
            inManagedObjectContext:appDelegate.managedObjectContext];
    
    address.number = 3496;
    address.street = @"Washington Street";
    address.city = @"Jamaica Plain, Boston";
    address.state = @"Massachusetts";
    address.postalCode = @"02130";
    item.address = address;
    
    startTimeString = @"Wed, 20 May 2015 20:30:00 -0500";
    endTimeString = nil;
    item.startTime = [dateFormatter dateFromString:startTimeString];
    
    if (![item.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    if (![address.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    [items addObject:item];
    
    
    item = [NSEntityDescription
            insertNewObjectForEntityForName:@"NewsItem"
            inManagedObjectContext:appDelegate.managedObjectContext];

    item.type = Performance;
    item.headline = @"T.T. the Bear's in Cambridge, MA, USA.";
    item.info = @"Andyroo plays the T.T. the Bear's in Cambridge, MA, USA. Doors open at 8:30 p.m.";
    
    address = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Address"
                        inManagedObjectContext:appDelegate.managedObjectContext];
    address.number = 3496;
    address.street = @"Washington Street";
    address.city = @"Jamaica Plain, Boston";
    address.state = @"Massachusetts";
    address.postalCode = @"02130";
    item.address = address;
    
    startTimeString = @"Wed, 20 May 2015 20:30:00 -0500";
    endTimeString = nil;
    item.startTime = [dateFormatter dateFromString:startTimeString];
    
    if (![item.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    if (![address.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    [items addObject:item];
    
    return [NSArray arrayWithArray:items];
}

#pragma mark - NSURLConnection delegate

- (void) startNewsConnection {
    
    // Initiate connection request
    NSURLRequest *theRequest =
    [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.guilmo.com/tvguide/showtrends.php"]
                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                 timeoutInterval:10.0];
    
    self.newsConnection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (self.newsConnection) {
        
        // Create the NSMutableData to hold the received data.
        self.newsData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to newsData.
    [self.newsData appendData:data];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"NSURLConnection newsData failure.");
    NSLog(@"%@, %@", error, error.localizedDescription);    
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *jsonError = nil;
    NSString *testDataString = @"[{\"type\":0,\"headline\":\"Andyroo 5 Alive, new music album coming soon.\",\"info\":\"Andyroo is currently working on his 5th major music album, Andyroo 5 Alive, and will soon release a short version of the album as an EP on iTunes. The album features new songs such as Shake Your Body, Time Boy 2, and Ethereal Trance Number 262, all of which can be experienced now for free on YouTube. The album marks a return to Andyroo's 'happy dance music' and is 'very early 80s,' featuring lots of Yamaha DX7, Roland TR-707 and Fairlight C.M.I., the venerable musical instruments of the decade, which Andyroo combines with the sounds of his modern Yamaha Motif workstation.\",\"startTime\":\"Thu, 21 May 2015 16:45:00 -0500\",\"endTime\":\"Fri, 10 July 2015 16:45:00 -0500\"},{\"type\":1,\"headline\":\"Midway Cafe in Jamaica Plain, Boston, USA.\",\"info\":\"Andyroo plays the Midway Cafe in Jamaica Plain, Boston, USA. Doors open at 8:30 p.m.\",\"startTime\":\"Wed, 20 May 2015 20:30:00 -0500\",\"number\":3496,\"street\":\"Washington Street\",\"city\":\"Jamaica Plain, Boston\",\"state\":\"Massachusetts\",\"postalCode\":\"02130\"}]";
    
    //id jsonObject = [NSJSONSerialization JSONObjectWithData:newsData options:kNilOptions error:&jsonError];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[testDataString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&jsonError];
    self.newsArray = jsonObject;
    
    self.newsItems = [self getNewsItems];
    [self.tableView reloadData];
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
    
    NewsItem *item = self.newsItems[indexPath.row];
    NSString *identifier = nil;
    if (item.type == News) {
        identifier = @"NewsItem";
    }
    else {
        identifier = @"Performance";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yy"];
    NSString *dateString = [format stringFromDate:item.startTime];
    NSString *info = [NSString stringWithFormat:@"%@. %@", dateString, item.info];
    
    cell.textLabel.text = item.headline;
    cell.detailTextLabel.text = info;
    
    if (item.type == News) {
        [cell.imageView setImage:[UIImage imageNamed:@"info-icon2"]];

    }
    
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
