//
//  ViewController.m
//  A06.车小弟模仿
//
//  Created by apple on 15-1-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "OBShapedButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //往图片添加三个 “扇形” 按钮
    
    for (NSInteger i = 0; i < 3; i++) {
        //获取按钮图片的名称
        NSString *imageName = [NSString stringWithFormat:@"circle%ld",i+1];
        
        //添加按钮
        UIButton *btn = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.circleImageView.bounds;
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //往图片添加按钮
        [self.circleImageView addSubview:btn];
    }
    
    
    //添加中心的按钮
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    centerBtn.bounds = CGRectMake(0, 0, 112, 112);
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_dealer_had_bind"] forState:UIControlStateNormal];
    centerBtn.center = self.circleImageView.center;
    //监听按钮的事件
    [centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerBtn];
    
    
}

- (void)centerBtnClick:(UIButton *)btn {
    
    //当前的透明度
    CGFloat currentAlpha = self.circleImageView.alpha;
    
    // 1.先实现隐藏和显示
    //hidden alpha
    if (currentAlpha == 1) {//隐藏
        self.circleImageView.alpha = 0;
    }else{//显示
    
        self.circleImageView.alpha = 1;
    }
    
    // 2再添加动画 //透明度、缩放、旋转效果
    // 2.1创建组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 2.1 透明度动画
#warning 这里设置的透明度是图层opacity
    CABasicAnimation *opacityAni = [CABasicAnimation animation];
    opacityAni.keyPath = @"opacity";
    
    
    // 2.2 缩放动画
    CAKeyframeAnimation *scaleAni = [CAKeyframeAnimation animation];
    scaleAni.keyPath = @"transform.scale";
    
    // 2.3 旋转动画
    CABasicAnimation *rotationAni = [CABasicAnimation animation];
    rotationAni.keyPath = @"transform.rotation";
    
    // 如果是要隐藏，透明度是由“显示“到”看不见“
    if (currentAlpha == 1) {//隐藏
        opacityAni.fromValue = @1;
        opacityAni.toValue = @0;
        
        scaleAni.values = @[@1,@1.2,@0];
        
        //旋转的时候从原来的位置 逆时针 旋转45度
        rotationAni.fromValue = @0;
        rotationAni.toValue = @(-M_PI_4);
    }else{
        //显示
        opacityAni.fromValue = @0;
        opacityAni.toValue = @1;
        
        scaleAni.values = @[@0,@1.2,@1];
        
        //显示的时，旋转是从 -M_PI_4开始
        rotationAni.fromValue = @(-M_PI_4);
        rotationAni.toValue = @0;
    
    }
    
    
    
    group.animations = @[opacityAni,scaleAni,rotationAni];
    group.duration = 1.0;
    [self.circleImageView.layer addAnimation:group forKey:nil];
    
    
}



-(void)btnClick:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
}
@end
