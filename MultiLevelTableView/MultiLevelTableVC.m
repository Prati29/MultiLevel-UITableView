//
//  MultiLevelTableVC.m
//  MultiLevelTableView
//
//  Created by Admin on 18/09/15.
//  Copyright (c) 2015 ITC. All rights reserved.
//

#import "MultiLevelTableVC.h"


@interface MultiLevelTableVC ()
{
    NSArray *_plistDataNSA;
}
@end

@implementation MultiLevelTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    _menuArrayNSMA = [NSMutableArray array];
    _plistDataNSA = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuArray" ofType:@"plist"]];
    NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    for(NSDictionary *item in _plistDataNSA){
        File *_file = [[File alloc]init];
        _file._nameNSS = [item valueForKey:@"_NAME"];
        _file._levelNSN = [[item valueForKey:@"_LEVEL"]intValue];
        _file._parentNSS = [item valueForKey:@"_PARENT"];
        _file._sourceIdNSS = [item valueForKey:@"_SOURCE_ID"];
        _file._classNSS = [item valueForKey:@"_CLASS"];
        
        if((_file._levelNSN == 1))
        {
            [_menuArrayNSMA addObject:_file];
            NSLog(@" Menu Array Level ---- %d",_file._levelNSN);
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - tableview datasource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArrayNSMA.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *_identifier = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:_identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier];
    }
    
    cell.textLabel.text = [[_menuArrayNSMA objectAtIndex:indexPath.row] _nameNSS];
    [cell setIndentationLevel:[[_menuArrayNSMA objectAtIndex:indexPath.row] _levelNSN]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == _menuArrayNSMA.count-1){
        File *file = [_menuArrayNSMA objectAtIndex:indexPath.row];
        NSLog(@"Expand Cell");
        [self expandCell : file._sourceIdNSS andCount:indexPath.row+1 andTableView:tableView];
        
    }
    else if(indexPath.row < _menuArrayNSMA.count-1){
        File *file = [_menuArrayNSMA objectAtIndex:indexPath.row];
        File *file1 = [_menuArrayNSMA objectAtIndex:indexPath.row +1];
        
        if([file1._parentNSS isEqualToString:file._sourceIdNSS]){
            NSLog(@"Collapse Cell");
            [self collapseCell : file._sourceIdNSS andCount:(int)indexPath.row  andTableView:tableView];
            
            
        }
        else{
            NSLog(@"Expand Cell");
            [self expandCell : file._sourceIdNSS andCount:indexPath.row+1 andTableView:tableView];
            
        }
    }
    
}

#pragma marks - user define methods

-(void)expandCell: (NSString *)_sourceIdNSS andCount:(NSInteger)count andTableView:(UITableView *)tableView{
    NSMutableArray *arCells=[NSMutableArray array];
    for(NSDictionary *item in _plistDataNSA){
        File *_file = [[File alloc]init];
        _file._nameNSS = [item valueForKey:@"_NAME"];
        _file._levelNSN = [[item valueForKey:@"_LEVEL"]intValue];
        _file._parentNSS = [item valueForKey:@"_PARENT"];
        _file._sourceIdNSS = [item valueForKey:@"_SOURCE_ID"];
        _file._classNSS = [item valueForKey:@"_CLASS"];
        
        if([_file._parentNSS isEqualToString:_sourceIdNSS])
        {
            [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
            [_menuArrayNSMA insertObject:_file atIndex:count++];
            NSLog(@" Menu Array Level ---- %d",_file._levelNSN);
        }
    }
    [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(void)collapseCell: (NSString *)_sourceId andCount:(int)count andTableView:(UITableView *)tableView{
    NSMutableArray *arCells=[NSMutableArray array];
    NSMutableArray *removeObject = [NSMutableArray array];
    
    File *file = [_menuArrayNSMA objectAtIndex:count];
    int _collapseLevel = file._levelNSN;
    
    for(int i = count+1 ; i<_menuArrayNSMA.count;i++){
        
        File *file1 = [_menuArrayNSMA objectAtIndex:i];
        int _level = file1._levelNSN;
        
        if(_level > _collapseLevel){
            [arCells addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            [removeObject addObject:file1];
            //count++;
        }
        else if(_level <= _collapseLevel){
            break;
        }
        
        
    }
    [_menuArrayNSMA removeObjectsInArray:removeObject];
    [tableView deleteRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (IBAction)expandCells:(id)sender {
    NSMutableString *_searchSourceIdNSS = [[NSMutableString alloc]initWithFormat:@"ASD123"];
    
    NSMutableArray *_sourceIdArrayNSMA = [NSMutableArray array];
    
    for(int i = 0;i<_plistDataNSA.count;i++)
    {
        NSLog(@"%d",i);
        for(NSDictionary *item in _plistDataNSA){
            File *_file = [[File alloc]init];
            _file._nameNSS = [item valueForKey:@"_NAME"];
            _file._levelNSN = [[item valueForKey:@"_LEVEL"]intValue];
            _file._parentNSS = [item valueForKey:@"_PARENT"];
            _file._sourceIdNSS = [item valueForKey:@"_SOURCE_ID"];
            _file._classNSS = [item valueForKey:@"_CLASS"];
            
            if([_searchSourceIdNSS isEqualToString:_file._sourceIdNSS]){
                [_sourceIdArrayNSMA addObject:_file._sourceIdNSS];
                NSLog(@"%@",_file._sourceIdNSS);
                if(_file._parentNSS == nil)
                    break;
                else
                    _searchSourceIdNSS = (NSMutableString *)_file._parentNSS;
                
            }
            
        }
    }
    
    NSLog(@"%@",_sourceIdArrayNSMA);
    
    for(NSString *item in [_sourceIdArrayNSMA reverseObjectEnumerator]){
        NSLog(@"%@",item);
        for(int i=0;i<_menuArrayNSMA.count;i++){
            if([item isEqualToString:[[_menuArrayNSMA objectAtIndex:i] _sourceIdNSS]]){
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self tableView:_tableViewUITV didSelectRowAtIndexPath:indexPath];
            }
        }
    }
    
}
@end
