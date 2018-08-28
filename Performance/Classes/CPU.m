//
//  CPU.m
//  Performance
//
//  Created by honglianglu on 10/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "CPU.h"
#import <mach/mach.h>

@implementation CPU

+ (void)cpuInfo
{
    NSLog(@"cpuInfo:%f", [CPU appCPUUsage]);
}

+ (float)appCPUUsage
{
    kern_return_t kr;
    task_info_data_t info;
    mach_msg_type_number_t infoCount = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)info, &infoCount);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    thread_array_t thread_list;
    mach_msg_type_number_t thread_count;
    thread_info_data_t thinfo;
    mach_msg_type_number_t thread_info_count;
    thread_basic_info_t basic_info_th;
    
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++) {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th -> flags & TH_FLAGS_IDLE)) {
            tot_cpu += basic_info_th -> cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
    }
    
    vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    return tot_cpu;
}

@end
