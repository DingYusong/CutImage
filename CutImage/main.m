//
//  main.m
//  CutImage
//
//  Created by 丁玉松 on 2018/11/29.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 1.输入参数校验
        if (argc < 2) {
            NSLog(@"请输入图片地址");
            return 0;
        }
        
        NSString *inputFile = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        
        NSString *outPutPath = [inputFile stringByDeletingPathExtension];
        
        CGFloat titleSize = 256;
        
        //加载大图
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputFile];
        NSSize size = [image size];
        NSArray<NSImageRep *> *representations = [image representations];
        if ([representations count]) {
            NSBitmapImageRep *representation = representations[0];
            size.width = [representation pixelsWide];
            size.height = [representation pixelsHigh];
        }
        
        
        
        
    }
    return 0;
}
