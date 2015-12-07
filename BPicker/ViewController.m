//
//  ViewController.m
//  BPicker
//
//  Created by bai on 15/12/7.
//  Copyright © 2015年 bai.xianzhi. All rights reserved.
//

#import "ViewController.h"
#import "BPicker.h"

@interface ViewController ()<BPickerDelegate>{
    NSArray *da;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(69, 69, 200,50)];
    [showButton addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [showButton setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:showButton];
    
    
    UIButton *showButton2 = [[UIButton alloc]initWithFrame:CGRectMake(69, 69+100, 200,50)];
    [showButton2 addTarget:self action:@selector(modleshow) forControlEvents:UIControlEventTouchUpInside];
    [showButton2 setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:showButton2];
    

}

-(void)modleshow{
    da = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    BPicker *picker = [[BPicker alloc]initWithFrame:CGRectMake(0, 0, 250, 300)];
    picker.delegate =self;
    picker.dataArray =da;
    NSLog(@"%@",picker.dataArray);
    //[self.view addSubview: picker];
    [picker modeShow];
}
-(void)show{
    da = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    BPicker *picker = [[BPicker alloc]initWithFrame:CGRectMake(0, 0, 250, 300)];
    picker.delegate =self;
    picker.dataArray =da;
    NSLog(@"%@",picker.dataArray);
    [self.view addSubview: picker];
    [picker show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
