//
//  MacroExtensions.h
//  Newsfeed
//
//  Created by Tomer shiri on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>

#define safeRelease(__var) {[(__var) release]; (__var) = nil;}

#define SERIALIZEABLE(__clazz) \
-(void)encodeWithCoder:(NSCoder*)coder { \
Class superclass = class_getSuperclass([__clazz class]);\
SEL constructor = @selector(encodeWithCoder:); \
if (class_conformsToProtocol(superclass,@protocol(NSCoding))) { \
class_getMethodImplementation(superclass,constructor)(self,constructor,coder);\
} \
[NSCodingAspect encodeWithCoder:coder forObject:self withClass:[__clazz class]]; \
} \
\
-(id)initWithCoder:(NSCoder*)coder { \
Class superclass = class_getSuperclass([__clazz class]);\
SEL constructor = @selector(initWithCoder:); \
if (class_conformsToProtocol(superclass,@protocol(NSCoding))) {\
self = class_getMethodImplementation(superclass,constructor)(self,constructor,coder);\
}\
else {\
self = [super init];\
}\
if (!self) return self;\
self = [NSCodingAspect initWithCoder:coder forObject:self withClass:[__clazz class]]; \
return self; \
}\
