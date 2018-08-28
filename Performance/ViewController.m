//
//  ViewController.m
//  Performance
//
//  Created by honglianglu on 06/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "ViewController.h"
#import "memory.h"
#import "CPU.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)appInfo
{
    [memory memoryInfo];
    [CPU cpuInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                 repeats:YES
                                                   block:^(NSTimer * _Nonnull timer) {
                                                       [self appInfo];
                                                   }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInteger j = 0;
        for (NSInteger i = 0; i < 100000000000000000; i ++) {
            j += j + 1;
        }
    });
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
