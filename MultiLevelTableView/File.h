//
//  File.h
//  MultiLevelTableView
//
//  Created by Admin on 18/09/15.
//  Copyright (c) 2015 ITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject
@property (nonatomic, strong) NSString *_nameNSS;
@property (nonatomic, assign) int _levelNSN;
@property (nonatomic, strong) NSString *_parentNSS;
@property (nonatomic, strong) NSString *_sourceIdNSS;
@property (nonatomic, strong) NSString *_classNSS;
@end
