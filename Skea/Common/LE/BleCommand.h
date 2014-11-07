//
//  BleCommand.h
//  Skea
//
//  Created by mosn on 10/28/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//


///4.3 APP设置压力传感器的门限值
static NSString * const cAppCommandLevel1 = @"2503010000000029"; //门限值为level 1
static NSString * const cAppCommandLevel2 = @"250302000000002a";
static NSString * const cAppCommandLevel3 = @"250303000000002b";
static NSString * const cAppCommandLevel4 = @"250304000000002c";
static NSString * const cAppCommandLevel5 = @"250305000000002d";
static NSString * const cAppCommandLevel6 = @"250306000000002e";
static NSString * const cAppCommandLevel7 = @"250307000000002f";
static NSString * const cAppCommandLevel8 = @"2503080000000030";


///4.2 APP控制电机转动速度和时长
static NSString * const cAppCommandRate1 = @"2502000000000027"; //忽略，不做任何处理
static NSString * const cAppCommandRate2 = @"250201020000002a";// //电机以2档转速转动1s
static NSString * const cAppCommandRate3 = @"2502040600000032"; //电机以6档转速转动4s
