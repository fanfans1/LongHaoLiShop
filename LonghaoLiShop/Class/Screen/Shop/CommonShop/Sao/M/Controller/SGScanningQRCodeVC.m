//
//  SGScanningQRCodeVC.m
//  SGQRCodeExample
//
///
//  ViewController.h
//  ErWeiMa
//
//  Created by yy on 2016/12/8.
//  Copyright © 2016年 fanfan. All rights reserved.
//


/*
 二维码扫描的步骤：
 1、创建设备会话对象，用来设置设备数据输入
 2、获取摄像头，并且将摄像头对象加入当前会话中
 3、实时获取摄像头原始数据显示在屏幕上
 4、扫描到二维码/条形码数据，通过协议方法回调
 
 AVCaptureSession 会话对象。此类作为硬件设备输入输出信息的桥梁，承担实时获取设备数据的责任
 AVCaptureDeviceInput 设备输入类。这个类用来表示输入数据的硬件设备，配置抽象设备的port
 AVCaptureMetadataOutput 输出类。这个支持二维码、条形码等图像数据的识别
 AVCaptureVideoPreviewLayer 图层类。用来快速呈现摄像头获取的原始数据
 二维码扫描功能的实现步骤是创建好会话对象，用来获取从硬件设备输入的数据，并实时显示在界面上。在扫描到相应图像数据的时候，通过AVCaptureVideoPreviewLayer类型进行返回
 */

#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGScanningQRCodeView.h"


@interface SGScanningQRCodeVC ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) SGScanningQRCodeView *scanningView;

@property (nonatomic, strong) UIButton *right_Button;
@property (nonatomic, assign) BOOL first_push;

@end

@implementation SGScanningQRCodeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    // 创建扫描边框
    self.scanningView = [[SGScanningQRCodeView alloc] initWithFrame:self.view.frame outsideViewLayer:self.view.layer];
    [self.view addSubview:self.scanningView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = BACKGROUNDCOLOR;
    
    self.navigationItem.title = @"扫一扫";
    
    // 二维码扫描
    [self setupScanningQRCode];
    
    self.first_push = YES;
    
    
}




#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 会频繁的扫描，调用代理方法
    
    // 0、扫描成功之后的提示音
    [self playSoundEffect:@"sound.caf"];
    
    // 1、如果扫描完成，停止会话
    [self.session stopRunning];
    
    // 2、删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    // 3、设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        //        NSLog(@"metadataObjects = %@", obj.stringValue);
        
        if ([obj.stringValue  length] != 20) {
            [self jingshikuang:@"二维码扫描有误！"];
            
        } else { // 扫描结果为条形码

            [self setPost:obj.stringValue];
            
        }
    }
}



- (void)jingshikuang:(NSString *)sender{//封装了一个警示框可以重复调用
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示框" message:sender preferredStyle:UIAlertControllerStyleAlert];
    
    [APPDELEGATE.window.rootViewController presentViewController:alertC animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertC dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
}

- (void)setPostEmployee:(NSString *)dic{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionary];
    [dics setValue:dic forKey:@"order_sn"];
    [dics setValue:[user objectForKey:@"userid"] forKey:@"shop_user_id"];
    [dics setValue:[user objectForKey:@"comment_employee_id"] forKey:@"comment_employee_id"];
    [MJPush postWithURLString:@"" parameters:dics success:^(id success) {
        // NSLog(@"%@",success);
        if ([[[success objectForKey:@"tipmessage"] objectForKey:@"code"] isEqualToString:@"000"])  {
//            NSString *str = @"线上支付";
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"订单号:%@",dic] message:[NSString stringWithFormat:@"支付方式:%@",str] preferredStyle:UIAlertControllerStyleAlert];
//            
//            [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                
                NSDictionary *dic = [success objectForKey:@"tipmessage"];
                if ([[dic objectForKey:@"code"] isEqualToString:@"000"]) {
                    //                [self jingshikuang:@"验证成功"];
                    UIAlertController *alertControllera = [UIAlertController alertControllerWithTitle:@"验证成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [alertControllera addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"saoma" object:self ];
                        [self.navigationController popViewControllerAnimated:NO];
                        
                    }]];
                    [self presentViewController:alertControllera animated:YES completion:nil];
                    
                    //            [self.navigationController popViewControllerAnimated:NO];
                    //                [self.navigationController popViewControllerAnimated:NO];
                }else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                
                
//            }]];
//            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",@"验证失败"] message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:NO];
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)setPost:(NSString *)dic{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionary];
    [dics setValue:dic forKey:@"order_sn"];
    [dics setValue:[user objectForKey:@"userid"] forKey:@"shop_user_id"];
    
    [MJPush postWithURLString:@"" parameters:dics success:^(id success) {
       // NSLog(@"%@",success);
        if ([[[success objectForKey:@"tipmessage"] objectForKey:@"code"] isEqualToString:@"000"])  {
            NSString *str = @"线上支付";
            if ([[NSString stringWithFormat:@"%@",[success objectForKey:@"pay_id"]] isEqualToString:@"0"]) {
                
                if ([[NSString stringWithFormat:@"%@",[success objectForKey:@"installment"]] isEqualToString:@"0"]) {
                    str= @"线下支付";
                }else{
                    str= @"分期支付";
                }
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"订单号:%@",dic] message:[NSString stringWithFormat:@"支付方式:%@",str] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                NSDictionary *dic = [success objectForKey:@"tipmessage"];
                if ([[dic objectForKey:@"code"] isEqualToString:@"000"]) {
                    //                [self jingshikuang:@"验证成功"];
                    UIAlertController *alertControllera = [UIAlertController alertControllerWithTitle:@"验证成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [alertControllera addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"saoma" object:self ];
                        [self.navigationController popViewControllerAnimated:NO];
                        
                    }]];
                    [self presentViewController:alertControllera animated:YES completion:nil];
                    
                    //            [self.navigationController popViewControllerAnimated:NO];
                    //                [self.navigationController popViewControllerAnimated:NO];
                }else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",@"验证失败"] message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:NO];
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

// 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
    //    NSLog(@" - - -- viewDidAppear");
}

#pragma mark - - - 扫描提示声
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    //    NSLog(@"播放完成...");
}

/**
 *  播放音效文件
 *
 *  @param name 音频文件名称
 */
- (void)playSoundEffect:(NSString *)name{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
}



@end


