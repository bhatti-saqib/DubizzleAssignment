//
//  DetailViewController.m
//  DubizzleTest
//
//  Created by Saqib Bhatti on 06/12/2020.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController {
    NSArray *tableData;
}

@synthesize arrayOfListData;
@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableData = [NSArray arrayWithObjects:@"Name", @"Price", @"Posted On", nil];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    
    [self changeDateFormat: @"2019-02-24 04:04:17.566515"];
    [self displayImage];
}

-(void) displayImage {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicator.center = imageView.center;
            [activityIndicator startAnimating];
            [imageView addSubview:activityIndicator];
            self.view.userInteractionEnabled = NO;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self->_imgString]];
                UIImage *image = [UIImage imageWithData: data];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            self->imageView.image = image;
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
        });
    });
}

-(void) changeDateFormat: (NSString *)dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *date = [dateFormat dateFromString: dateString];
    
    [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    NSLog(@"%@", dateStr);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"ItemDetailCell";
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
 
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [arrayOfListData objectAtIndex:indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:25]];
     
    [label setText:@"Details"];
    [view addSubview:label];
    
    return view;
}

@end
