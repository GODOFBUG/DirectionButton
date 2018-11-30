//
//  DirectionButton.m
//  Intercom
//
//  Created by 江世豪 on 2018/11/29.
//  Copyright © 2018年 江世豪. All rights reserved.
//

#import "DirectionButton.h"
#import <CoreText/CoreText.h>

NSString  * const SHForegroundNormalColorAttributeName = @"ForegroundNormalColor";

NSString  * const SHForegroundSelecteColorAttributeName = @"ForegroundSelecteColor";

@interface DirectionButton ()

@property (nonatomic ,strong) id target;

@property (nonatomic ,assign) SEL action;

@end

@implementation DirectionButton

- (instancetype)init{
    
    if (self = [super init]) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickButtonEvent:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickButtonEvent:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {

    if (self.direction==IMAGEDIRECTIONTYP_Bottom){

        [self imageBottomNeedsDisplay];

    }else if(self.direction==IMAGEDIRECTIONTYP_Right){

        [self imageRightNeedsDisplay];

    }else if(self.direction==IMAGEDIRECTIONTYP_Top){

        [self imageTopNeedsDisplay];

    }else{

        [self imageLeftNeedsDisplay];
    }

}

#pragma mark  --重绘
- (void)againDraw{
    
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected{
    
    _selected = selected;
    
    [self againDraw];
}

#pragma mark  --绘制
- (void)imageLeftNeedsDisplay{
    
    [self buttonSeletedStyle:NSTextAlignmentLeft];
    
    CGSize size = [self.title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:self.parame context:NULL].size;
    
    UIImage *currentImage = self.selected&&self.selImage?self.selImage:self.image;
    
    CGFloat countW = currentImage.size.width + self.space + size.width;
    
    /*  绘制图片*/
    CGFloat imageX = countW>self.frame.size.width?0:(self.frame.size.width - countW)*0.5;
    CGFloat imageY = (self.frame.size.height-currentImage.size.height)*0.5;
    [currentImage drawInRect:CGRectMake(imageX, imageY, currentImage.size.width, currentImage.size.height)];
    
    /*  创建文本*/
    UIFont *font = self.parame[NSFontAttributeName];
    CGFloat titleX = imageX + currentImage.size.width + self.space;
    CGFloat titleY = (self.frame.size.height - font.lineHeight)*0.5;
    [self.title drawInRect:CGRectMake(titleX, titleY, self.frame.size.width - titleX, font.lineHeight) withAttributes:self.parame];
}

- (void)imageBottomNeedsDisplay{
    
    [self buttonSeletedStyle:NSTextAlignmentCenter];
    
    UIFont *font = self.parame[NSFontAttributeName];
    
    UIImage *currentImage = self.selected&&self.selImage?self.selImage:self.image;
    
    CGFloat countH = currentImage.size.height + self.space + font.lineHeight;
    
    /*  创建文本*/
    CGFloat titleY = countH>self.frame.size.height?0:(self.frame.size.height-countH)*0.5;
    
    [self.title drawInRect:CGRectMake(0, titleY, self.frame.size.width, font.lineHeight) withAttributes:self.parame];
    
    /*  绘制图片*/
    CGFloat imageY = titleY + font.lineHeight + self.space;
    CGFloat imageH = countH>self.frame.size.height?(self.frame.size.height - imageY):currentImage.size.height;
    [currentImage drawInRect:CGRectMake((self.frame.size.width-currentImage.size.width)*0.5, imageY, currentImage.size.width, imageH)];
    
    
}

- (void)imageRightNeedsDisplay{
    
    [self buttonSeletedStyle:NSTextAlignmentRight];
    
    CGSize size = [self.title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:self.parame context:NULL].size;
    
    UIImage *currentImage = self.selected&&self.selImage?self.selImage:self.image;
    
    CGFloat countW = currentImage.size.width + self.space + size.width;
    
    /*  创建文本*/
    UIFont *font = self.parame[NSFontAttributeName];
    CGFloat titleX = countW>self.frame.size.width?0:(self.frame.size.width - countW)*0.5;
    CGFloat titleY = (self.frame.size.height - font.lineHeight)*0.5;
    [self.title drawInRect:CGRectMake(titleX, titleY, size.width, font.lineHeight) withAttributes:self.parame];
    
    
    /*  绘制图片*/
    CGFloat imageX = titleX + size.width + self.space;
    CGFloat imageY = (self.frame.size.height - currentImage.size.height)*0.5;
    [currentImage drawInRect:CGRectMake(imageX, imageY, currentImage.size.width, currentImage.size.height)];
    
    
}

- (void)imageTopNeedsDisplay{
    
    [self buttonSeletedStyle:NSTextAlignmentCenter];
    
    UIFont *font = self.parame[NSFontAttributeName];
    
    UIImage *currentImage = self.selected&&self.selImage?self.selImage:self.image;
    
    CGFloat countH = currentImage.size.height + self.space + font.lineHeight;
    
    /*  绘制图片*/
    CGFloat imageY = countH>self.frame.size.height?0:(self.frame.size.height-countH)*0.5;
    
    CGFloat imageH = countH>self.frame.size.height?(self.frame.size.height - font.lineHeight - self.space):currentImage.size.height;
    [currentImage drawInRect:CGRectMake((self.frame.size.width - currentImage.size.width)*0.5, imageY, currentImage.size.width, imageH)];
    
    
    /*  创建文本*/
    CGFloat titleY = (imageY + currentImage.size.height + self.space);
    
    [self.title drawInRect:CGRectMake(0, titleY, self.frame.size.width, font.lineHeight) withAttributes:self.parame];
    
}


- (void)buttonSeletedStyle:(NSTextAlignment)alignment{
    
    if (!self.parame) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = alignment;
        self.parame = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], NSFontAttributeName, [UIColor blackColor], SHForegroundSelecteColorAttributeName, [UIColor blackColor], SHForegroundNormalColorAttributeName, style, NSParagraphStyleAttributeName,nil];
    }else{
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = alignment;
        [self.parame setObject:style forKey:NSParagraphStyleAttributeName];
        
        if (self.selected) {
            
            UIColor *color = self.parame[SHForegroundSelecteColorAttributeName]?:[UIColor blackColor];
            
            [self.parame setObject:color forKey:NSForegroundColorAttributeName];
            
        }else{
            
            UIColor *color = self.parame[SHForegroundNormalColorAttributeName]?:[UIColor blackColor];
            
            [self.parame setObject:color forKey:NSForegroundColorAttributeName];
        }
    }
    
}


#pragma mark  --事件
- (void)clickButtonEvent:(UITapGestureRecognizer *)tap{
    
    if ([self.target respondsToSelector:self.action]) {
        
        [self.target performSelector:self.action withObject:self afterDelay:0];
    }
}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    self.target = target;
    self.action = action;
}
@end
