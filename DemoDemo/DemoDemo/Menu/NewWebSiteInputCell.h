//
//  NewWebSiteInputCell.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewWebSiteInputCell : UITableViewCell
{
    UIButton* addButton;
    UITextField* textField;
    id target;
    SEL selector;
}

-(void) setAddbuttonDelegateWithTarget:(id) target andSelector:(SEL) selector;

@end

