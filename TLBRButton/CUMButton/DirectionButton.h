//
//  DirectionButton.h
//  Intercom
//
//  Created by 江世豪 on 2018/11/29.
//  Copyright © 2018年 江世豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString  * const SHForegroundNormalColorAttributeName;

extern NSString  * const SHForegroundSelecteColorAttributeName;

typedef  NS_ENUM(NSInteger , IMAGEDIRECTIONTYP){
    
    IMAGEDIRECTIONTYP_Left,
    IMAGEDIRECTIONTYP_Bottom,
    IMAGEDIRECTIONTYP_Right,
    IMAGEDIRECTIONTYP_Top
};

@interface DirectionButton : UIView

/*  文字*/
@property (nonatomic, copy) NSString *title;

/*  图片*/
@property (nonatomic, strong) UIImage *image;

/*  选中状态的图片*/
@property (nonatomic, strong) UIImage *selImage;

/*  图片文字的间隔*/
@property (nonatomic, assign) CGFloat space;

/*  文字属性（文字大小、颜色）*/
@property (nonatomic, strong) NSMutableDictionary <NSAttributedStringKey, id> *parame;

/*  选中状态*/
@property (nonatomic, assign) BOOL selected;

/*  结构方向*/
@property (nonatomic, assign) IMAGEDIRECTIONTYP direction;

/*  添加事件*/
- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/*  绘制*/
- (void)againDraw;

@end

NS_ASSUME_NONNULL_END
