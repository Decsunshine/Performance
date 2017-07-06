//
//  ViewController.m
//  Performance
//
//  Created by honglianglu on 06/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "ViewController.h"
#import "memory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[memory new] memoryInfo];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
