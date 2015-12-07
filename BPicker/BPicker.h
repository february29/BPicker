//
//  BPicker.h
//  contact
//
//  Created by bai on 15/11/30.
//  Copyright © 2015年 Yaocui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BPickerDelegate <NSObject>
-(void)BPickdidSelectDataAtIndex:(NSInteger )indext selectedData:(id)selectedData;
@end

@interface BPicker : UIView<UITableViewDataSource,UITableViewDelegate>
//@property(nonatomic,retain,readwrite)UIView *bgView;
@property(nonatomic,retain,readwrite)UITableView *tableView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,retain,readwrite)UILabel *tilelab;
@property(nonatomic,strong) id<BPickerDelegate> delegate;
-(void)show;
-(void)modeShow;
@end
