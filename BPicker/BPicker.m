//
//  BPicker.m
//  contact
//
//  Created by bai on 15/11/30.
//  Copyright © 2015年 Yaocui. All rights reserved.
//

#import "BPicker.h"
static const CGFloat TitleH = 40.0;
static const CGFloat CellH = 30.0;

@interface BCancleButton : UIButton

@end
@interface BPicker()
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UIView *activieyView;
@property (strong,nonatomic) BCancleButton *cancelButton;
@property (nonatomic,readwrite) BOOL modleShow;

@end




@implementation BPicker

@synthesize tableView,dataArray,tilelab,activieyView,cancelButton;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //边框
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [[UIColor grayColor]CGColor];
        self.layer.borderWidth = 1.0f;
        
        //阴影
        
        self.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 5;
        self.layer.shadowPath = [self shadowPath].CGPath;
        [self setHidden:YES];
       
        tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, TitleH, self.frame.size.width, self.frame.size.height-TitleH);
        [self addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setBackgroundColor:[UIColor clearColor]];
       
        
        tilelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, TitleH)];
        tilelab.textAlignment = NSTextAlignmentCenter;
        [tilelab setTextColor:[UIColor blackColor]];
        [tilelab setFont:[UIFont systemFontOfSize:15]];
        if (!tilelab.text) {
            tilelab.text = @"请选择";
        }
        
        [self addSubview:tilelab];
        
      
        
    }
    return self;
}

-(UIBezierPath *)shadowPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = 20;
    
    CGPoint topLeft      = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    CGPoint leftMiddle = CGPointMake(x,y+(height/2));
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    
    return path;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!dataArray) {
        NSLog(@"plase set dataArray like this pickview.dataArray = ");
        return 0;
    }

    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor=[UIColor clearColor];
    //[cell.textLabel setTextAlignment: NSTextAlignmentCenter];
    [cell.textLabel setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setTintColor:[UIColor grayColor]];
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellH;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hidePick];
    [_delegate BPickdidSelectDataAtIndex:indexPath.row selectedData:[dataArray objectAtIndex:indexPath.row]];
}
-(void)hidePick{
    
    
    
    
    
    if (self.modleShow) {
        [UIView animateWithDuration:0.35f animations:^{
            self.activieyView.alpha = 0.5;
            self.activieyView.transform = CGAffineTransformScale(self.transform, 0.4, 0.4);
        } completion:^(BOOL finished) {
            [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
            [self.activieyView setHidden:YES];
            [self.activieyView removeFromSuperview];
            self.viewController = nil;
            [self.window removeFromSuperview];
            self.window = nil;
            
            NSLog(@"model hid finished");
            
        }];

    }else{
        [UIView animateWithDuration:0.35f animations:^{
            self.alpha = 0.5;
            self.transform = CGAffineTransformScale(self.transform, 0.4, 0.4);
        } completion:^(BOOL finished) {
            //[bgView removeFromSuperview];
            [self setHidden:YES];
            [self removeFromSuperview];
           
            
            
            
        }];

    }
    
    
}
-(void)show{
    if (!self.superview) {
        NSLog(@"you must add this view to a conrenview");
        return;
    }
    
    self.center = self.superview.center;
    [self setHidden:NO];
    
    cancelButton = [[BCancleButton alloc]init];
    CGRect closeFrame = cancelButton.frame;
    closeFrame.origin.x = -10;
    closeFrame.origin.y = -10;
    cancelButton.frame = closeFrame;
    [cancelButton addTarget:self action:@selector(hidePick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];

       self.alpha = 0.0f;
    self.layer.shouldRasterize = YES;
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:0.35f animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
             self.alpha = 1;
             self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished2) {
             self.layer.shouldRasterize = NO;
        }];

    }];
}

-(void)modeShow{
    
    self.modleShow = YES;
   
    
    
    [self setHidden:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    UIViewController *viewController = [[UIViewController alloc] init];
    self.window.rootViewController = viewController;
    self.viewController = viewController;
    
    
    float actvitypading = 15;
    activieyView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.bounds.size.width+actvitypading*2,self.bounds.size.height+actvitypading*2 )];
    //[activieyView setBackgroundColor:[UIColor greenColor]];
    
    
    [self.viewController.view addSubview:activieyView];
    activieyView.center = self.viewController.view.center;
    

    CGRect rct = self.frame;
    rct .origin.x=actvitypading;
    rct.origin.y = actvitypading;
    self.frame = rct;
    [activieyView addSubview:self];
    
    
    
    cancelButton = [[BCancleButton alloc]init];
    CGRect closeFrame = cancelButton.frame;
    closeFrame.origin.x = 0;
    closeFrame.origin.y = 0;
    cancelButton.frame = closeFrame;
    [cancelButton addTarget:self action:@selector(hidePick) forControlEvents:UIControlEventTouchUpInside];
    [activieyView addSubview:cancelButton];
   
    
    //设置picker后看的遮盖背景颜色
    UIColor *BcanveColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    [self.viewController.view setBackgroundColor:BcanveColor];
   
  
    [self.window makeKeyAndVisible];
   
    UIView *containerView =activieyView;
    containerView.alpha = 0;
    containerView.layer.shouldRasterize = YES;
    containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:0.2f animations:^{
        containerView.alpha = 1;
        containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished2) {
            containerView.layer.shouldRasterize = NO;
            //[[NSNotificationCenter defaultCenter] postNotificationName:KGModalDidShowNotification object:self];
        }];
    }];

    
    
}

@end

@implementation BCancleButton

-(instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, 32, 32)];
    if (self) {
        
        static dispatch_once_t once;
        static UIImage *closeButtonImage;
        
        dispatch_once(&once, ^{
            closeButtonImage = [self closeButtonImage];
        });
        [self setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
        
    }
    return self;
}

-(UIImage *)closeButtonImage{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor *topGradient = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:0.9];
    UIColor *bottomGradient = [UIColor colorWithRed:0.03 green:0.03 blue:0.03 alpha:0.9];
    
    //// Gradient Declarations
    NSArray *gradientColors = @[(id)topGradient.CGColor,
                                (id)bottomGradient.CGColor];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Shadow Declarations
    CGColorRef shadow = [UIColor blackColor].CGColor;
    CGSize shadowOffset = CGSizeMake(0, 1);
    CGFloat shadowBlurRadius = 3;
    CGColorRef shadow2 = [UIColor blackColor].CGColor;
    CGSize shadow2Offset = CGSizeMake(0, 1);
    CGFloat shadow2BlurRadius = 0;
    
    
    //// Oval Drawing
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(4, 3, 24, 24)];
    CGContextSaveGState(context);
    [ovalPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(16, 3), CGPointMake(16, 27), 0);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow);
    [[UIColor whiteColor] setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    CGContextRestoreGState(context);
    
    
    //// Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(22.36, 11.46)];
    [bezierPath addLineToPoint:CGPointMake(18.83, 15)];
    [bezierPath addLineToPoint:CGPointMake(22.36, 18.54)];
    [bezierPath addLineToPoint:CGPointMake(19.54, 21.36)];
    [bezierPath addLineToPoint:CGPointMake(16, 17.83)];
    [bezierPath addLineToPoint:CGPointMake(12.46, 21.36)];
    [bezierPath addLineToPoint:CGPointMake(9.64, 18.54)];
    [bezierPath addLineToPoint:CGPointMake(13.17, 15)];
    [bezierPath addLineToPoint:CGPointMake(9.64, 11.46)];
    [bezierPath addLineToPoint:CGPointMake(12.46, 8.64)];
    [bezierPath addLineToPoint:CGPointMake(16, 12.17)];
    [bezierPath addLineToPoint:CGPointMake(19.54, 8.64)];
    [bezierPath addLineToPoint:CGPointMake(22.36, 11.46)];
    [bezierPath closePath];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2);
    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
    
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    UIGraphicsEndImageContext();
    
    
    return image;
}

@end
