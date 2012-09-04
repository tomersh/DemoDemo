//
//  NSCodingAspect.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/2/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//


@interface NSCodingAspect : NSObject {}

+ (id) initWithCoder:(NSCoder*)decoder forObject:(id)object withClass:(id)clazz;
+ (void) encodeWithCoder:(NSCoder*)encoder forObject:(id)object withClass:(id)clazz;

@end