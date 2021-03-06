//
//  RatingBar.m
//  MyRatingBar
//
//  Created by Leaf on 14-8-28.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import "RatingBar.h"
#define ZOOM 0.8f
@interface RatingBar ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, assign) CGFloat starWidth;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@end

@implementation RatingBar

@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeWithFrame:self.frame];
}

-(void)initializeWithFrame:(CGRect)frame{
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
    self.bottomView = [[UIView alloc] initWithFrame:self.bounds];
    self.topView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:self.bottomView];
    [self addSubview:self.topView];
    
    self.topView.clipsToBounds = YES;
    self.topView.userInteractionEnabled = NO;
    self.bottomView.userInteractionEnabled = NO;
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    //
    CGFloat width = frame.size.width / 7.0;
    self.starWidth = width;
    for (int i = 0; i < 5; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width * ZOOM, width * ZOOM)];
        img.center = CGPointMake((i + 1.5) * width, frame.size.height / 2);
        img.image = [UIImage imageNamed:@"bt_star_a"];
        [self.bottomView addSubview:img];
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:img.frame];
        img2.center = img.center;
        img2.image = [UIImage imageNamed:@"bt_star_b"];
        [self.topView addSubview:img2];
    }
    self.enable = YES;
}

-(void)setPanEnable:(BOOL)panEnable{
    if (panEnable) {
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:self.pan];
    }else{
        [self removeGestureRecognizer:self.pan];
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeWithFrame:frame];
    }
    return self;
}
- (void)setViewColor:(UIColor *)backgroundColor {
    if (_viewColor != backgroundColor) {
        self.backgroundColor = backgroundColor;
        self.topView.backgroundColor = backgroundColor;
        self.bottomView.backgroundColor = backgroundColor;
    }
}
- (void)setStarNumber:(NSInteger)starNumber {
    if (_starNumber != starNumber) {
        _starNumber = starNumber;
        self.topView.frame = CGRectMake(0, 0, self.starWidth * (starNumber + 1), self.bounds.size.height);
    }
    if ([delegate respondsToSelector:@selector(setRating:isHuman:sender:)]) {
        [delegate setRating:_starNumber isHuman:NO sender:self];
    }
}
- (void)tap:(UITapGestureRecognizer *)gesture {
    if (self.enable) {
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x / self.starWidth) + 1;
        self.topView.frame = CGRectMake(0, 0, self.starWidth * count, self.bounds.size.height);
        if (count > 5) {
            _starNumber = 5;
        } else {
            _starNumber = count - 1;
        }
    }
    if ([delegate respondsToSelector:@selector(setRating:isHuman:sender:)]) {
        [delegate setRating:_starNumber isHuman:YES sender:self];
    }
}
- (void)pan:(UIPanGestureRecognizer *)gesture {
    if (self.enable && self.panEnable) {
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x / self.starWidth);
        if (count >= 0 && count <= 5 && _starNumber != count) {
            self.topView.frame = CGRectMake(0, 0, self.starWidth * (count + 1), self.bounds.size.height);
            _starNumber = count;
        }
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
