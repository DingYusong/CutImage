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
        
        NSRect rect = NSMakeRect(0, 0, size.width, size.height);
        CGImageRef imageRef = [image CGImageForProposedRect:&rect context:NULL hints:nil];
        
        NSInteger rows = ceil(size.width/titleSize);
        NSInteger cols = ceil(size.height/titleSize);
        
        for (int y = 0 ; y < rows; y++) {
            for (int x = 0; x < cols; x++) {
                //获得图片切块
                CGRect titleRect = CGRectMake(x*titleSize, y*titleSize, titleSize, titleSize);
                CGImageRef titleImage = CGImageCreateWithImageInRect(imageRef, titleRect);
                
                //转换为图片数据
                NSBitmapImageRep *imageRef = [[NSBitmapImageRep alloc] initWithCGImage:titleImage];
                NSData *data = [imageRef representationUsingType:NSBitmapImageFileTypeJPEG properties:nil];
                CGImageRelease(titleImage);
                
                NSString *path = [outPutPath stringByAppendingFormat:@"_%02i_%02i.jpg",x,y];
                [data writeToFile:path atomically:NO];
            }
        }
    }
    return 0;
}
