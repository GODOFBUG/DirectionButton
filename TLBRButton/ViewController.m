//
//  ViewController.m
//  TLBRButton
//
//  Created by 江世豪 on 2018/11/30.
//  Copyright © 2018年 江世豪. All rights reserved.
//

#import "ViewController.h"
#import "DirectionButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self testDemo];
}

-(void)testDemo{
    
    DirectionButton *button = [[DirectionButton alloc] initWithFrame:CGRectMake(0, 100, 200, 80)];
    button.image = [UIImage imageNamed:@"hongbao"];
    button.title = @"领取红包";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    button.parame = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20], NSFontAttributeName, [UIColor redColor], SHForegroundSelecteColorAttributeName, [UIColor blueColor], SHForegroundNormalColorAttributeName,style, NSParagraphStyleAttributeName,nil];
    button.selected = YES;
    button.direction = IMAGEDIRECTIONTYP_Left;
    button.space = 20;
    button.backgroundColor = [UIColor lightGrayColor];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(clickTest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)clickTest:(id)sender{
    
    NSLog(@"123456789");
    
    [sender setSelected:![sender selected]];
    
}


@end
