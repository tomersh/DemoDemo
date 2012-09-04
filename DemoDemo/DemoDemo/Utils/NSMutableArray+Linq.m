//
//  NSMutableArray+Linq.m
//  Newsfeed
//
//  Created by Tomer Shiri on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+Linq.h"


@implementation NSArray (filter)

-(NSArray*) filterByClass:(Class)clazz {
    return [self filterByBlock:^BOOL(id obj) {
        return [obj isKindOfClass:clazz];
    }];
}

-(NSArray*) filterByBlock:(BOOL (^)(id obj))filterFunc {
    NSMutableArray * filteredArray = [NSMutableArray arrayWithCapacity:0];
    for (id obj in self) {
        if (filterFunc(obj))
            [filteredArray addObject:obj];
    }
    return [[[NSArray alloc] initWithArray:filteredArray] autorelease];
}

-(NSArray*) mappedArray:(id (^)(id obj))mapFunc {
    NSMutableArray * mappedArray = [NSMutableArray arrayWithCapacity:[self count]];

    for (id obj in self) {
        [mappedArray addObject:mapFunc(obj)];
    }
    
    return [[[NSArray alloc] initWithArray:mappedArray] autorelease];
}

-(NSArray*) each:(void (^)(id obj))doFunction {
    for (id obj in self) {
        doFunction(obj);
    }
    return self;
}

-(NSArray*)distinctArray {
    NSSet * distinctObjects = [NSSet setWithArray:self];

    return [[[NSArray alloc] initWithArray:[distinctObjects allObjects]] autorelease];
}

@end
