//
//  MultiLevelTableVC.h
//  MultiLevelTableView
//
//  Created by Admin on 18/09/15.
//  Copyright (c) 2015 ITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "File.h"

@interface MultiLevelTableVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_menuArrayNSMA;
}

- (IBAction)expandCells:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableViewUITV;

@end
