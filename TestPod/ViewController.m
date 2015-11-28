//
//  ViewController.m
//  podAFNetwork
//
//  Created by mifit on 15/9/9.
//  Copyright (c) 2015年 mifit. All rights reserved.
//

#import "ViewController.h"

#import "XMVideoViewController.h"

#import "XMBaseViewController.h"
#import "AppDelegate.h"

#import "XMChiZi.h"
#import "XMHttp.h"

#import "XMPieView.h"
#import "LXPieView.h"

#import "XMLoadProgress.h"

#import "YCLanguageTools.h"

@interface ViewController ()
@property (nonatomic,strong) XMChiZi *tChizi;
@property (nonatomic,strong) XMLoadProgress *loadProgress;

- (IBAction)showMV:(id)sender;
- (IBAction)addTime:(id)sender;
- (IBAction)show:(id)sender;
- (IBAction)fdsfs:(id)sender;

@property (weak, nonatomic) IBOutlet XMChiZi *layChizi;
@property (weak, nonatomic) IBOutlet UIImageView *iamge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XMChiZi *f = [[XMChiZi alloc]initWithFrame:CGRectMake(10, 130, 300, 100)];
    [[YCLanguageTools shareInstanceLanguage]initUserLanguage];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"2015-09-08 12:30:20 ~ 2015-09-08 14:20:30",@"2015-09-08 0:30:20 ~ 2015-09-08 3:20:30", nil];
    f.times = arr;
    [f timeChanged:^(NSString *timeStr, BOOL isEnd) {
        //NSLog(@"%d---%@",isEnd,timeStr);
    }];
    [self.view addSubview:f];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.layChizi.times = arr;
    _tChizi = f;
    
    CGRect rf = CGRectMake(180, 180, 120, 120);
    LXPieView *lxView = [[LXPieView alloc]initWithFrame:rf];
    [lxView addBlue:0.2 red:0.3];
    [self.view addSubview:lxView];
    
    CGRect rr = CGRectMake(30, 180, 120,120);
    XMPieView *xxView = [[XMPieView alloc]initWithFrame:rr];
    [self.view addSubview:xxView];
    [xxView addPersent:0.2 color:[UIColor redColor]];
    [xxView addPersent:0.4 color:[UIColor blueColor]];
    
    XMLoadProgress *xxL = [[XMLoadProgress alloc]initWithFrame:CGRectMake(30, 80, 100, 4)];
    [self.view addSubview:xxL];
    _loadProgress = xxL;
    
    dispatch_time_t ttt = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1);
    dispatch_after(ttt, dispatch_get_main_queue(), ^{
        xxL.progress = 1;
        [xxView startRotation];
        [lxView startAnimation:2];
    });
    
    dispatch_time_t sss = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 3);
    dispatch_after(sss, dispatch_get_main_queue(), ^{
        [xxView stopRotation];
        //xxL.loadColor = [UIColor purpleColor];
        xxL.progress = 0.2;
    });
    
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addProgress:) userInfo:nil repeats:YES];
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSString *ppp = [cachesDir stringByAppendingPathComponent:@"LaunchImages"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:ppp error:&error];
    NSLog(@"路径==%@,fileList%@",cachesDir,fileList);
    
    /// --------------------------
    [self testRequest];
    [self testGet];
    [self testPost];
    [self testPosts];
    [self testDown];
    [self testUpload];
    self.navigationItem.title = NSLocalizedString(@"title", @"");
    [@"image" hasSuffix:@""];
    if ([@[@"图片",@"圖片",@"image"] containsObject:[@"smb://192.168.100.1/usrdata0/圖片" lowercaseString]]) {
        NSLog(@"333");

    }
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addProgress:(NSTimer *)timer{
    if (self.loadProgress.loadProgress >= 0.999999) {
        self.loadProgress.loadProgress        = 0.0;
    }
    self.loadProgress.loadProgress = self.loadProgress.loadProgress + 0.1;
}
#pragma mark - private method
- (void)testRequest{
    //    [XMHttp http_RequestWithURL:@"http://www.picoman.cn/api/commend/list" params:@{@"type":@"10"} httpMethod:@"GET" success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"gr:%@",responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"ge:%@",error);
    //    }];
    
    //http://www.weather.com.cn/data/cityinfo/101280601.html
    //http://www.weather.com.cn/data/sk/101280601.html
    //http://m.weather.com.cn/data/101280601.html
    //    [XMHttp http_RequestWithURL:@"http://www.weather.com.cn/data/sk/101280601.html" requestHeader:nil params:nil httpMethod:@"GET" success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"rs:%@",responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"e:%@",error);
    //    }];
    
    //    [XMHttp http_RequestWithURL:@"http://www.picoman.cn/api/commend/list" requestHeader:@{@"Content-Type":@"application/json"} params:@{@"type":@"10"} httpMethod:@"GET" success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"ffs:%@",responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"ffr:%@",error);
    //    }];
}

- (void)testGet{
//    [XMHttp setResponseSerializer:[AFHTTPResponseSerializer serializer]];
//    [XMHttp http_Get:@"http://wenxiang.4006188666.com/getxiangchanlist.php?page=1" success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"rr:%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"3%@--3",[error localizedDescription]);
//    }];
    

//    [XMHttp http_Get:@"http://www.weather.com.cn/adat/sk/101280601.html" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"r:%@----",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //NSLog(@"3%@--3",[error localizedDescription]);
//    }];

}

- (void)testPost{

    //[XMHttp setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [XMHttp http_Post:@"http://www.picoman.cn/api/app/newApp" parameters:@{@"type":@3,@"categoryid":@"1139833457"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"rs:%@----",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"3%@--3",[error localizedDescription]);
    }];
    
    //[XMHttp setResponseSerializer:[AFHTTPResponseSerializer serializer]];
//    [XMHttp http_Post:@"http://wenxiang.4006188666.com/getxiangchanlist.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //NSLog(@"r:%@----",responseObject);
//        NSData *doubi = responseObject;
//        NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
//        shabi = [shabi substringFromIndex:1];
//        shabi = [shabi substringToIndex:shabi.length-1];
//        NSData *doubi2 = [shabi dataUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%@",shabi);
//        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:doubi2 options:NSJSONReadingMutableContainers error:nil];
//
//        ttt1111 *fd = [RMMapper objectWithClass:[ttt1111 class] fromDictionary:content];
//        fffff11111 *ffds;
//        ffds.id = @"fdsf";
//        NSLog(@"fff:%@",fd.d);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"3:%@",[error localizedDescription]);
//    }];
}

//A299A1FA7A0EC26580CD0443C0000205-n1.001
- (void)testPosts{
//    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1);
//    dispatch_after(t, dispatch_get_main_queue(), ^{
//        [XMHttp http_RequestWithURL:@"http://www.picoman.cn/api/user/modifyIcon" params:@{@"image":UIImagePNGRepresentation([UIImage imageNamed:@"f"]),@"type":@0 ,@"jsessionid":@"A299A1FA7A0EC26580CD0443C0000205-n1.001"} httpMethod:@"POST" mimeType:@"image/png" success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"rrr%@",responseObject);
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            //NSLog(@"333%@--3",[error localizedDescription]);
//        }];
//    });
    
    
    ////////   ------  ok -------
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachesDir = [paths objectAtIndex:0];
//    NSString *filePath = [cachesDir stringByAppendingPathComponent:@"headerIcon.png"];
//    [UIImageJPEGRepresentation([UIImage imageNamed:@"f"], 1)writeToFile:filePath atomically:YES];
//    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
//    dispatch_after(t, dispatch_get_main_queue(), ^{
//        [XMHttp http_Posts:@"http://www.picoman.cn/api/user/modifyIcon" parameters:@{@"type":@0 ,@"jsessionid":@"A299A1FA7A0EC26580CD0443C0000205-n1.001"} filePath:filePath fileType:@"image" success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"s:%@",responseObject);
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"e:%@",[error localizedDescription]);
//        }];
//    });

    
    ////////   ------  ok -------
//    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1);
//    dispatch_after(t, dispatch_get_main_queue(), ^{
//        [XMHttp http_Posts:@"http://www.picoman.cn/api/user/modifyIcon" parameters:@{@"type":@0 ,@"jsessionid":@"A299A1FA7A0EC26580CD0443C0000205-n1.001"} fileData:UIImagePNGRepresentation([UIImage imageNamed:@"f"]) fileType:@"image" fileName:@"fds.png" mimeType:@"image/png" success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"s:%@",responseObject);
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            //NSLog(@"e:%@",[error localizedDescription]);
//        }];
//    });
}

- (void)testDown{
   //// ----------- ok -----------
//    [XMHttp http_DownImage:@"http://www.raywenderlich.com/wp-content/uploads/2014/01/sunny-background.png" success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        self.iamge.image = responseObject;
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ;
//    }];
    
    //// ----------- ok -----------
//    [XMHttp http_DownImage:@"http://www.raywenderlich.com/wp-content/uploads/2014/01/sunny-background.png" progress:^(CGFloat progress) {
//        NSLog(@"%f",progress);
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        self.iamge.image = responseObject;
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ;
//    }];
    
    
    ////--------- ok ----------
//    [XMHttp http_Down:@"http://e.hiphotos.baidu.com/image/h%3D200/sign=5a743f7eca1b9d1695c79d61c3dfb4eb/cc11728b4710b912e44e5b5fc7fdfc0393452287.jpg" savePath:nil completedBlock:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSData *d = [NSData dataWithContentsOfURL:filePath];
//        self.iamge.image = [UIImage imageWithData:d];
//    }];
    
    //// -------- ok -----------
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSString *path = [cachesDir stringByAppendingPathComponent:@"tem.png"];
    [XMHttp http_Down:@"http://www.raywenderlich.com/wp-content/uploads/2014/01/sunny-background.png" savePath:path progress:^(CGFloat progress) {
        NSLog(@"%f",progress);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.iamge.image = [UIImage imageWithContentsOfFile:path];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}

- (void)testUpload{
    
}

- (void)forceHhengping{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeLeft;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

//
//- (void)deviceOrientationDidChange{
//    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//    CGFloat startRotation = [[self valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
//    CGAffineTransform rotation;
//    switch (interfaceOrientation) {
//        case UIInterfaceOrientationLandscapeLeft:
//            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);
//            break;
//        case UIInterfaceOrientationLandscapeRight:
//            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);
//            break;
//        case UIInterfaceOrientationPortraitUpsideDown:
//            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 180.0 / 180.0);
//            break;
//        default:
//            rotation = CGAffineTransformMakeRotation(-startRotation + 0.0);
//            break;
//    }
//    self.view.transform = rotation;
//}

- (void)pushStory:(NSString *)sName vcName:(NSString *)vName{
    id showVC = [[UIStoryboard storyboardWithName:sName bundle:nil]instantiateViewControllerWithIdentifier:vName];
    [self.navigationController pushViewController:showVC animated:YES];
}
#pragma mark - button method
- (IBAction)showMV:(id)sender {
    NSURL *sUrl = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    XMVideoViewController *ss = [[UIStoryboard storyboardWithName:@"XMVidio" bundle:nil]instantiateViewControllerWithIdentifier:@"XMVideoViewController"];
    ss.videoURL = sUrl;
    //[self presentViewController:ss animated:YES completion:nil];
    [self.navigationController pushViewController:ss animated:YES];
}

- (IBAction)addTime:(id)sender {
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.isFull = YES;
    [self forceHhengping];
    [self.tChizi addTimeSection:@"2015-09-08 5:30:20 ~ 2015-09-08 8:20:30"];
}

- (IBAction)show:(id)sender {
    XMBaseViewController *v = [[XMBaseViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
    //自定义返回图片
    UIImage *backButtonImage = [[UIImage imageNamed:@"backIcon"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0) resizingMode:UIImageResizingModeTile];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //[[UIBarButtonItem appearance] setImageInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1);
    dispatch_after(t, dispatch_get_main_queue(), ^{
        [v uploadImageFromCamera:@"http://www.picoman.cn/api/user/modifyIcon" paramers:@{@"type":@0 ,@"jsessionid":@"A299A1FA7A0EC26580CD0443C0000205-n1.001"} imageWidth:200 completed:^(UIImage *image) {
            ;
        }];
    });
}

- (IBAction)fdsfs:(id)sender {
    //[self.tChizi addTimeSection:@"2015-09-08 4:30:20 ~ 2015-09-08 5:20:30"];
    [self.tChizi setTimePosition:@"2015-09-08 5:30:20"];
}

@end
