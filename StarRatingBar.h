//
//  StarRatingBar.h
//  StarRatingBar
//
//  Created by suk on 15/12/21.
//  Copyright © 2015年 suk. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface StarRatingBar : UIControl
@property (nonatomic) NSUInteger rating;
@property (nonatomic,copy) void (^ratingChangedBlock)(NSUInteger rating);
-(id)initWithFrame:(CGRect)frame;
-(id)initWithFrame:(CGRect)frame starCount:(NSUInteger)count;
- (void)setRate:(float)rate;
@end
