//
//  ViewController.h
//  ExpandCollapseTable
//
//  Created by Jeff Tchang on 8/17/18.
//  Copyright © 2018 Jeff Tchang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSMutableArray* expandedSections;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

