//
//  TNAnimateSlider.h
//  TNAnimateSlider
//
//  Created by Trai Nguyen on 11/8/16.
//  Copyright © 2016 Trai Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface TNAnimateSlider : UISlider

@property (strong, nonatomic) IBInspectable NSString *leftValue;
@property (strong, nonatomic) IBInspectable NSString *name;
@property (strong, nonatomic) IBInspectable NSString *thumbImage;

@end
