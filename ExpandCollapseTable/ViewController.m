//
//  ViewController.m
//  ExpandCollapseTable
//
//  Created by Jeff Tchang on 8/17/18.
//  Copyright © 2018 Jeff Tchang. All rights reserved.
//

#import "ViewController.h"

const int NUM_SECTIONS = 10;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.expandedSections = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < NUM_SECTIONS; i++) {
        [self.expandedSections addObject:@(0)];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    NSInteger section = recognizer.view.tag;
    
    if (self.expandedSections[section] == [NSNumber numberWithInt:0]) {
        self.expandedSections[section] = @(1);
    }
    else {
        self.expandedSections[section] = @(0);
    }
    NSLog(@"Header tapped: %ld", (long)section);
    
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.expandedSections[section] == [NSNumber numberWithInt:0]) {
        return 0;
    }
    else {
        return 5;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    headerView.tag = section;
    headerView.backgroundColor = [UIColor yellowColor];
    headerView.layer.borderWidth = 1;
    headerView.layer.borderColor = [[UIColor redColor] CGColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 20)];
    label1.text = [NSString stringWithFormat:@"Header #%ld", section];
    [headerView addSubview:label1];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [headerView addGestureRecognizer:singleFingerTap];
    
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = @"Hello Cell";
    return cell;
}

@end
