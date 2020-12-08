//
//  DetailViewController.h
//  DubizzleTest
//
//  Created by Saqib Bhatti on 06/12/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray* arrayOfListData;
@property (strong, nonatomic) NSString* imgString;
@property (nonatomic, strong) IBOutlet UIImageView* imageView;

@end

NS_ASSUME_NONNULL_END
