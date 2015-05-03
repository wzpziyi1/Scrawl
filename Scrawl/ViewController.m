//
//  ViewController.m
//  Scrawl
//
//  Created by 王志盼 on 15/5/3.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"


@interface ViewController ()

@property (nonatomic, weak) MyView *myView;

- (IBAction)clear:(id)sender;

- (IBAction)back:(id)sender;

- (IBAction)save:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyView *view = [[MyView alloc] initWithFrame:CGRectMake(20, 80, 300, 300)];
    [view setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:view];
    self.myView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clear:(id)sender {
    
    [self.myView clear];
}

- (IBAction)back:(id)sender {
    [self.myView back];
}

- (IBAction)save:(id)sender {
    
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(self.myView.frame.size, NO, 0.0);
    
    // 将控制器view的layer渲染到上下文
    [self.myView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    }else
    {
        NSLog(@"保存成功");
    }
}

@end
