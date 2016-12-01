//
//  TNAnimateSlider.m
//  TNAnimateSlider
//
//  Created by Trai Nguyen on 11/8/16.
//  Copyright © 2016 Trai Nguyen. All rights reserved.
//

#import "TNAnimateSlider.h"

#define LEFT_VALUE_PADDING 1

#define NAME_VALUE_PADDING_LEFT 8

@interface TNAnimateSlider()

@property (strong, nonatomic)  UILabel *lblLeftValue;

@property (strong, nonatomic)  UILabel *lblName;

@end

@implementation TNAnimateSlider

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGRect newRect = rect;
    newRect.size.height = 34;
    
    [super drawRect:newRect];
    
    self.lblLeftValue = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_VALUE_PADDING, LEFT_VALUE_PADDING, newRect.size.height-2*LEFT_VALUE_PADDING, newRect.size.height-2*LEFT_VALUE_PADDING)];
    [self.lblLeftValue.layer setMasksToBounds:YES];
    [self.lblLeftValue.layer setCornerRadius:(newRect.size.height-2*LEFT_VALUE_PADDING)/2];
    [self.lblLeftValue setBackgroundColor:[UIColor whiteColor]];
    [self.lblLeftValue setTextAlignment:NSTextAlignmentCenter];
    [self.lblLeftValue setText:self.leftValue];
    
    [self addSubview:self.lblLeftValue];
    
    [self setThumbImage:[UIImage imageNamed:self.thumbImage] forState:UIControlStateNormal];
    
    for (id imvSub in self.subviews) {
        if ([imvSub isKindOfClass:[UIImageView class]]) {
            //UIView>UIImageVIew(maximum track) 1st object in subviews
            //UIImageView(minimum track) 2nd object in subviews
            //UIImageView(Thumb track) 3rd object in subviews
            ((UIImageView *)imvSub).layer.cornerRadius = newRect.size.height/2;
            break;
        }
    }
    
    self.lblName = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.lblName setText:self.name];
    CGFloat widthIs = [self.lblName.text boundingRectWithSize:self.lblName.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:self.lblName.font} context:nil].size.width;
    CGRect lblNameRect = CGRectMake(0, 0, widthIs, newRect.size.height);
    self.lblName.frame = lblNameRect;
    
    [self setValue:self.value animated:YES];
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    CGRect newBounds = bounds;
    newBounds.size.height = self.frame.size.height;
    return newBounds;
}

- (void)setValue:(float)value animated:(BOOL)animated {
    [super setValue:value animated:animated];
    [self.lblName removeFromSuperview];
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            NSMutableArray *arrImage = [NSMutableArray new];
            for (int i = 1; i <= 11; i++) {
                NSString *strName = [NSString stringWithFormat:@"%.2d.png", i];
                [arrImage addObject:[UIImage imageNamed:strName]];
            }
            UIImageView *imvThumb = self.subviews.lastObject;
            imvThumb.animationImages = arrImage;
            imvThumb.animationDuration = 0.35;
            imvThumb.animationRepeatCount = INTMAX_MAX;
            [imvThumb startAnimating];
            [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:1.5];
            
            UIImage *imgThumb = [UIImage imageNamed:self.thumbImage];
            CGFloat width = ((UIImageView *)subView).frame.size.width;
            CGFloat namePaddingLeft = self.lblLeftValue.frame.origin.x + self.lblLeftValue.frame.size.width + NAME_VALUE_PADDING_LEFT;
            CGFloat leftDistance = width - imgThumb.size.width/2 - namePaddingLeft;
            if (self.lblName.frame.size.width < leftDistance) {
                self.lblName.frame = CGRectMake(namePaddingLeft, 0, self.lblName.frame.size.width, self.frame.size.height);
                [((UIImageView *)subView) addSubview:self.lblName];
            }
            else {
                self.lblName.frame = CGRectMake(width + imgThumb.size.width/2 + NAME_VALUE_PADDING_LEFT, 0, self.lblName.frame.size.width, self.frame.size.height);
                [self addSubview:self.lblName];
                
            }
            self.lblName.alpha = 0.0;
            CGFloat widthName = self.lblName.frame.size.width;
            CGRect rect =self.lblName.frame;
            rect.size.width = 0;
            self.lblName.frame = rect;
            [UIView animateWithDuration:2.25 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                CGRect rect1 = self.lblName.frame;
                rect1.size.width = widthName;
                self.lblName.frame = rect1;
                self.lblName.alpha = 1.0;
            } completion:^(BOOL finished) {
                
            }];
            break;
        }
    }
    
}

- (void)stopAnimation {
    for (id object in [self.subviews reverseObjectEnumerator]) {
        if ([object isKindOfClass:[UIImageView class]]) {
            UIImageView *imvThumb = object;
            [imvThumb stopAnimating];
            [imvThumb setImage:[UIImage imageNamed:@"01.png"]];
            break;
        }
    }
}
@end
