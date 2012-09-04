//
//  NewWebSiteInputCell.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "NewWebSiteInputCell.h"

@implementation NewWebSiteInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    addButton = [[UIButton buttonWithType:UIButtonTypeContactAdd] retain];
    [addButton addTarget:self action:@selector(didPressAddButton:) forControlEvents:UIControlEventTouchUpInside];
    self.accessoryView = addButton;
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 100, self.frame.size.height - 10)] ;
    textField.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:textField];
    return self;
}

-(void) didPressAddButton:(id) sender {
    NSString* url = textField.text;
    if (!url || [url isEqualToString:@""]) return;
    textField.text = @"";
    [target performSelector:selector withObject:url];
}

-(void) setAddbuttonDelegateWithTarget:(id) _target andSelector:(SEL) _selector {
    target = _target;
    selector = _selector;
}

- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

-(void)dealloc {
    safeRelease(textField);
    safeRelease(addButton);
    [super dealloc];
}

@end
