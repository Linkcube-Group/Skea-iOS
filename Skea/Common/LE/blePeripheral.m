//
//  blePeripheral.m
//  MonitoringCenter
//
//  Created by David ding on 13-1-10.
//
//

#import "blePeripheral.h"


//================== TransmitMoudel =====================
// TransmitMoudel Receive Data Service UUID
NSString *kReceiveDataServiceUUID                       = @"180A";
// TransmitMoudel characteristics UUID
NSString *kReceive20BytesDataCharateristicUUID          = @"49535343-1E4D-4BD9-BA61-23C647249616";

// TransmitMoudel Send Data Service UUID
NSString *kSendDataServiceUUID                          = @"49535343-FE7D-4AE5-8FA9-9FAFD205E455";
// TransmitMoudel characteristics UUID
NSString *kSend20BytesDataCharateristicUUID             = @"49535343-8841-43F4-A8D4-ECBE34729BB3";

@implementation blePeripheral{
    NSTimer         *autoSendDataTimer;
    UInt16          testSendCount;
}


#pragma mark -
#pragma mark Init
/******************************************************/
//          类初始化                                   //
/******************************************************/
// 初始化蓝牙
-(id)init{
    self = [super init];
    if (self) {
        [self initPeripheralWithSeviceAndCharacteristic];
        [self initPropert];
    }
    return self;
}

-(void)setActivePeripheral:(CBPeripheral *)AP{
    _activePeripheral = AP;
    NSString *aname = [[NSString alloc]initWithFormat:@"%@",_activePeripheral.name];
    NSLog(@"aname:%@",aname);
    if (![aname isEqualToString:@"(null)"]) {
        _nameString = aname;
    }
    else{
        _nameString = @"Error Name";
    }
    NSString *auuid = [[NSString alloc]initWithFormat:@"%@", _activePeripheral.UUID];
    if (auuid.length >= 36) {
        _uuidString = [auuid substringWithRange:NSMakeRange(auuid.length-36, 36)];
        NSLog(@"uuidString:%@",_uuidString);
    }
}


-(void)initPeripheralWithSeviceAndCharacteristic{
    // CBPeripheral
    [_activePeripheral setDelegate:nil];
    _activePeripheral = nil;
    // CBService and CBCharacteristic
    _ReceiveDataService = nil;
    _Receive20BytesDataCharateristic = nil;
    _SendDataService = nil;
    _Send20BytesDataCharateristic = nil;
}

-(void)initPropert{
    // Property
    _staticString = @"Init";
    _currentPeripheralState = blePeripheralDelegateStateInit;
    nPeripheralStateChange
    _connectedFinish = kDisconnected;
    _receiveData = 0;
    _sendData = 0;
    _txCounter = 0;
    _rxCounter = 0;
    _ShowStringBuffer = [[NSString alloc]init];
    _AutoSendData = NO;
    
    [autoSendDataTimer invalidate];
    autoSendDataTimer = nil;
    testSendCount = 0;
}

#pragma mark -
#pragma mark Scanning
/****************************************************************************/
/*						   		Scanning                                    */
/****************************************************************************/
// 按UUID进行扫描
-(void)startPeripheral:(CBPeripheral *)peripheral DiscoverServices:(NSArray *)services{
    if ([peripheral isEqual:_activePeripheral] && [peripheral state]==CBPeripheralStateConnected){
        _activePeripheral = peripheral;
        [_activePeripheral setDelegate:(id<CBPeripheralDelegate>)self];
        [_activePeripheral discoverServices:services];
    }
}

-(void)disconnectPeripheral:(CBPeripheral *)peripheral{
    if ([peripheral isEqual:_activePeripheral]){
        // 内存释放
        [self initPeripheralWithSeviceAndCharacteristic];
        [self initPropert];
    }
}

#pragma mark -
#pragma mark CBPeripheral
/****************************************************************************/
/*                              CBPeripheral								*/
/****************************************************************************/
// 扫描服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    if (!error)
    {
        if ([peripheral isEqual:_activePeripheral]){
            // 新建服务数组
            NSArray *services = [peripheral services];
            if (!services || ![services count])
            {
                NSLog(@"发现错误的服务 %@\r\n", peripheral.services);
            }
            else
            {
                // 开始扫描服务
                _staticString = @"Discover services";
                _currentPeripheralState = blePeripheralDelegateStateDiscoverServices;
                nPeripheralStateChange
                for (CBService *services in peripheral.services)
                {
                    NSLog(@"发现服务UUID: %@\r\n", services.UUID);
                    //================== TransmitMoudel =====================// FFE0
                    if ([[services UUID] isEqual:[CBUUID UUIDWithString:kReceiveDataServiceUUID]])
                    {
                        // 扫描接收数据服务特征值
                        _ReceiveDataService = services;
                        [peripheral discoverCharacteristics:nil forService:_ReceiveDataService];
                    }
                    //================== TransmitMoudel =====================// FFE5
                    else if ([[services UUID] isEqual:[CBUUID UUIDWithString:kSendDataServiceUUID]])
                    {
                        // 扫描发送数据服务特征值
                        _SendDataService = services;
                        [peripheral discoverCharacteristics:nil forService:_SendDataService];
                    }
                    //======================== END =========================
                }
            }
        }
    }
}

// 从服务中扫描特征值
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (!error) {
        if ([peripheral isEqual:_activePeripheral]){
            // 开始扫描特征值
            _staticString = @"Discover characteristics";
            _currentPeripheralState = blePeripheralDelegateStateDiscoverCharacteristics;
            nPeripheralStateChange
            // 新建特征值数组
            NSArray *characteristics = [service characteristics];
            CBCharacteristic *characteristic;
            //================== TransmitMoudel =====================// FFE1 FFE2 FFE3 FFE4
//            if ([[service UUID] isEqual:[CBUUID UUIDWithString:kReceiveDataServiceUUID]])
//            {
//                for (characteristic in characteristics)
//                {
//                    NSLog(@"发现特值UUID: %@\n", [characteristic UUID]);
//                     [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//                    
//                    if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:kReceive20BytesDataCharateristicUUID]])
//                    {
//                        _Receive20BytesDataCharateristic = characteristic;
//                        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//                    }
//                }
//            }
            //================== TransmitMoudel =====================// FFE6 FFE7 FFE8 FFE9
             if ([[service UUID] isEqual:[CBUUID UUIDWithString:kSendDataServiceUUID]])
            {
                for (characteristic in characteristics)
                {
                    NSLog(@"发现特值UUID: %@\n", [characteristic UUID]);
                    if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:kSend20BytesDataCharateristicUUID]])
                    {
                        _Send20BytesDataCharateristic = characteristic;
                        
                        // 完成连接
                        [self FinishConnected];
                    }
                    else if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:kReceive20BytesDataCharateristicUUID]]){
                         _Receive20BytesDataCharateristic = characteristic;
                         [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                    }
                }
            }
            //======================== END =========================
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
     NSLog(@"发现特值UUID: %@\n ERROR=%@", [characteristic UUID],error);
    
    if (error==nil) {
        //调用下面的方法后 会调用到代理的- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        [peripheral readValueForCharacteristic:characteristic];
    }
    
}

// 更新特征值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if ([error code] == 0) {
        if ([peripheral isEqual:_activePeripheral]){
            //===================== AntiLost ========================FE21、FE22、FE23、FE24、FE25
            // 读其它数据
            if ([characteristic isEqual:_Receive20BytesDataCharateristic])
            {
                //if (characteristic.value.length == TRANSMIT_20BYTES_DATA_LENGHT) {
                    _receiveData = characteristic.value;
                    [self receiveData:_receiveData];
                //}
            }
            //======================== END =========================
        }
    }
    else{
        NSLog(@"参数更新出错: %d",[error code]);
    }
}

#pragma mark -
#pragma mark read/write/notification
/******************************************************/
//          读写通知等基础函数                           //
/******************************************************/
// 写数据到特征值
-(void) writeValue:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic data:(NSData *)data{
    if ([peripheral isEqual:_activePeripheral] && [peripheral state]==CBPeripheralStateConnected)
    {
        if (characteristic != nil) {
            NSLog(@"成功写数据到特征值: %@ 数据:%@\n", characteristic.UUID, data);
            [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        }
    }
}

// 从特征值读取数据
-(void) readValue:(CBPeripheral *)peripheral characteristicUUID:(CBCharacteristic *)characteristic{
    if ([peripheral isEqual:_activePeripheral] && [peripheral state]==CBPeripheralStateConnected)
    {
        if (characteristic != nil) {
            NSLog(@"成功从特征值:%@ 读数据\n", characteristic);
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}

// 发通知到特征值
-(void) notification:(CBPeripheral *)peripheral characteristicUUID:(CBCharacteristic *)characteristic state:(BOOL)state{
    if ([peripheral isEqual:_activePeripheral] && [peripheral state]==CBPeripheralStateConnected)
    {
        if (characteristic != nil) {
            NSLog(@"成功发通知到特征值: %@\n", characteristic);
            [peripheral setNotifyValue:state forCharacteristic:characteristic];
        }
    }
}

#pragma mark -
#pragma mark Set property
/******************************************************/
//              BLE属性操作函数                          //
/******************************************************/
-(void)FinishConnected{
    // 更新标志
    _connectedFinish = YES;
    _staticString = @"Connected finish";
    _currentPeripheralState = blePeripheralDelegateStateKeepActive;
    nPeripheralStateChange
    NSLog(@"连接完成\n");
}

-(void)receiveData:(NSData *)data{
    Byte dataLength = data.length;
    // 接收计数加1
    _rxCounter++;
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    Byte data2Byte[dataLength];
//    [data getBytes:&data2Byte length:dataLength];
//    NSString *dataASCII = [[NSString alloc]initWithBytes:data2Byte length:dataLength encoding:NSUTF8StringEncoding];
//    NSLog(@"dataASCII:%@",dataASCII);
//    NSString *dataHex = [[NSString alloc]initWithFormat:@" %@",data];
//    dataASCII = [dataASCII stringByAppendingString:dataHex];
//    NSLog(@"dataASCII:%@",dataASCII);
//    [self addReceiveASCIIStringToShowStringBuffer:dataASCII];
//    _staticString = dataASCII;// [[NSString alloc]initWithFormat:@"Receive:%@",dataASCII];
////    nUpdataShowStringBuffer
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CBUpdataShowStringBuffer" object:nil userInfo:@{@"uuid":self.uuidString}];
    
}

-(void)addReceiveASCIIStringToShowStringBuffer:(NSString *)aString{
    // 在接到的数据前面叠加"PC:"后面加入换行后添加到显示缓存
    NSString *rxASCII = [[NSString alloc]initWithFormat:@"        PC:"];
    rxASCII = [rxASCII stringByAppendingString:aString];
    rxASCII = [rxASCII stringByAppendingString:@"\n"];
    _ShowStringBuffer = [_ShowStringBuffer stringByAppendingString:rxASCII];
}

- (void)sendHexCommand:(NSString *)hexString
{
    if (hexString==nil || [hexString length]!=16) {
        return;
    }
    showAlertMessage(hexString);
    int j=0;
    Byte bytes[8];  ///3ds key的Byte 数组， 128位
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:8];
    
    showAlertMessage(_S(@"%@",newData));
     [self writeValue:_activePeripheral characteristic:_Send20BytesDataCharateristic data:newData];
}


//-(void)setSendData:(NSData *)data{
//    Byte dataLength = data.length;
//    
////    if (dataLength == TRANSMIT_20BYTES_DATA_LENGHT) {
//        // 发送计数加1
//        _txCounter++;
//        
//        Byte data2Byte[dataLength];
//        [data getBytes:&data2Byte length:dataLength];
//        NSString *dataASCII = [[NSString alloc]initWithBytes:data2Byte length:dataLength encoding:NSASCIIStringEncoding];
//        DLog(@"dataASCII:%@",dataASCII);
//        NSString *dataHex = [[NSString alloc]initWithFormat:@" %@",data];
//        dataASCII = [dataASCII stringByAppendingString:dataHex];
//        DLog(@"dataASCII:%@",dataASCII);
//        [self writeValue:_activePeripheral characteristic:_Send20BytesDataCharateristic data:data];
//        [self addSendASCIIStringToShowStringBuffer:dataASCII];
//        _staticString = [[NSString alloc]initWithFormat:@"Send:%@",dataASCII];
//        nUpdataShowStringBuffer
////    }
//}
//
//-(void)addSendASCIIStringToShowStringBuffer:(NSString *)aString{
//    // 在发送的数据前面叠加"IP:"后面加入换行后添加到显示缓存
//    NSString *txASCII = [[NSString alloc]initWithFormat:@"IP:"];
//    txASCII = [txASCII stringByAppendingString:aString];
//    txASCII = [txASCII stringByAppendingString:@"\n"];
//    _ShowStringBuffer = [_ShowStringBuffer stringByAppendingString:txASCII];
//}

//-(void)setAutoSendData:(BOOL)AutoSendData{
//    if (AutoSendData == YES) {
//        // 自动发送测试数据
//        if (autoSendDataTimer != nil) {
//            [autoSendDataTimer invalidate];
//        }
//        autoSendDataTimer = [NSTimer scheduledTimerWithTimeInterval:kAutoSendTestDataTimer target:self selector:@selector(AutoSendDataEvent) userInfo:nil repeats:YES];
//    }
//    else{
//        [autoSendDataTimer invalidate];
//        autoSendDataTimer = nil;
//        testSendCount = 0;
//    }
//}

//-(void)AutoSendDataEvent{
//    // 发送数据自动加1
//    if ([_activePeripheral state]==CBPeripheralStateConnected) {
//        testSendCount++;
//        NSString *txAccString = [[NSString alloc]initWithFormat:@"%05d", testSendCount];
//        NSString *test20ByteASCII = [[NSString alloc]initWithFormat:@"ABCDEFGHIJKLMNO"];
//        test20ByteASCII = [test20ByteASCII stringByAppendingString:txAccString];
//        [self setSendData:[test20ByteASCII dataUsingEncoding:NSASCIIStringEncoding]];
//    }
//    else{
//        [autoSendDataTimer invalidate];
//        autoSendDataTimer = nil;
//        testSendCount = 0;
//        
//        _connectedFinish = kDisconnected;
//        _AutoSendData = NO;
//        
//        _staticString = @"Disconnect";
//        _currentPeripheralState = blePeripheralDelegateStateInit;
//        nPeripheralStateChange
//    }
//}

@end
