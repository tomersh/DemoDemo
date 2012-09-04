//
//  NSCodingAspect.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/2/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "NSCodingAspect.h"
#import <objc/runtime.h>

@implementation NSCodingAspect

+ (id) initWithCoder:(NSCoder *)decoder forObject:(id)object withClass:(id)clazz {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	unsigned int numIvars = 0;
	Ivar * ivars = class_copyIvarList(clazz, &numIvars);
	for(int i = 0; i < numIvars; i++) {
		Ivar thisIvar = ivars[i];
		NSString * key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
		NSString * keyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)];
		id value = [decoder decodeObjectForKey:key];
		if (value == nil) {
			if ([keyType length]>2) {
				value = nil;
			}
			else {
				value = [NSNumber numberWithFloat:0.0];
			}
		}
		[object setValue:value forKey:key];
	}
	if (numIvars > 0) { free(ivars); }
	[pool drain];
	return object;
	
}


+ (void) encodeWithCoder:(NSCoder *)encoder forObject:(id)object withClass:(id)clazz {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	unsigned int numIvars = 0;
	Ivar * ivars = class_copyIvarList(clazz, &numIvars);
	for (int i = 0; i < numIvars; i++) {
		Ivar thisIvar = ivars[i];
		NSString * key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
		id value = [object valueForKey:key];
		[encoder encodeObject:value forKey:key];
	}
	if (numIvars > 0) { free(ivars); }
	[pool drain];
}

@end