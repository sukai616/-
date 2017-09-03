//
//  StarRatingBar.h
//  StarRatingBar
//
//  Created by suk on 15/12/21.
//  Copyright © 2015年 suk. All rights reserved.
//

#import "StarRatingBar.h"
const NSUInteger DEFAULT_STAR_COUNT = 5;
@interface StarRatingBar()
@property (nonatomic,strong) NSMutableArray *stars;
-(void)initWithStarCount:(NSUInteger)count;
-(BOOL)touch:(UITouch*)touch inStar:(UIImageView*)star;
@end
@implementation StarRatingBar
-(void)setRating:(NSUInteger)rating
{
    if (_rating != rating) {
        _rating = MIN(rating, self.stars.count);
        if (self.ratingChangedBlock) {
            self.ratingChangedBlock(_rating);
        }
        
        [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ((UIImageView*)obj).image = [UIImage imageNamed:@"星星"];
            [obj setHighlighted:(idx < rating)];
        }];
    }
}

- (void)setRate:(float)rate{
    [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setHighlighted:NO];
        if ((int)rate > idx) {
            ((UIImageView*)obj).image = [UIImage imageNamed:@"星星2"];
        }else if (round(rate) > idx){
            ((UIImageView*)obj).image = [UIImage imageNamed:@"星星"];
        }else{
            ((UIImageView*)obj).image = [UIImage imageNamed:@"星星"];
        }
    }];
}

-(void)initWithStarCount:(NSUInteger)count
{
    self.stars = [NSMutableArray array];
    for (NSUInteger idx = 0; idx < count; ++idx) {
        UIImageView *star = [UIImageView new];
//        star.image = [UIImage imageNamed:@"FinalStarRatingBar.bundle/star"];
//        star.highlightedImage = [UIImage imageNamed:@"FinalStarRatingBar.bundle/star_highlighted"];
        star.image = [UIImage imageNamed:@"星星"];
        star.highlightedImage = [UIImage imageNamed:@"星星2"];
        star.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:star];
        [self.stars addObject:star];
    }
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initWithStarCount:DEFAULT_STAR_COUNT];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initWithStarCount:DEFAULT_STAR_COUNT];
        [self setRating:5];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame starCount:(NSUInteger)count
{
    if (self = [super initWithFrame:frame]) {
        [self initWithStarCount:count];
    }
    return self;
}

-(void)layoutSubviews
{
    const CGFloat BAR_WIDTH = CGRectGetWidth(self.frame);
    const CGFloat BAR_HEIGHT = CGRectGetHeight(self.frame);
    const CGFloat STAR_WIDTH = BAR_WIDTH / self.stars.count;
    [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setFrame:CGRectMake(idx * STAR_WIDTH, 0, STAR_WIDTH, BAR_HEIGHT)];
    }];
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    __block StarRatingBar *blockSelf = self;
    [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([blockSelf touch:touch inStar:obj]) {
            self.rating = idx + 1;
            *stop = YES;
        }
    }];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    __block StarRatingBar *blockSelf = self;
    [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([blockSelf touch:touch inStar:obj]) {
            self.rating = idx + 1;
            *stop = YES;
        }
    }];
    return YES;
}

#pragma mark - Private Method
-(BOOL)touch:(UITouch *)touch inStar:(UIImageView *)star
{
    CGPoint pt = [touch locationInView:self];
    return CGRectContainsPoint(star.frame, pt);
}
@end
