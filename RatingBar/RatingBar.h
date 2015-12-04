//
//  RatingBar.h
//  MyRatingBar
//
//  Created by Leaf on 14-8-28.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RatingBar : UIView
@property (nonatomic,assign) NSInteger starNumber;
/*
 *调整底部视图的颜色
 */
@property (nonatomic,strong) UIColor *viewColor;

/*
 *是否允许可触摸
 */
@property (nonatomic,assign) BOOL enable;
@property (nonatomic,assign) BOOL panEnable;


@property (nonatomic, assign) id  delegate;
@end

@protocol RatingDelegate
@optional
-(void) setRating:(NSInteger)rating isHuman:(BOOL) isHuman sender:(RatingBar *) ratingBar;
@end
