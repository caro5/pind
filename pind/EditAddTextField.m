//
//  EditAddTextField.m
//  pind
//
//  Created by Caroline Wong on 3/8/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "EditAddTextField.h"

@implementation EditAddTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.font = [UIFont systemFontOfSize:15];
        self.keyboardType = UIKeyboardTypeDefault;
        self.returnKeyType = UIReturnKeyDone;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return self;
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
