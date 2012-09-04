//
//  NSMutableArray+Linq.h
//  Newsfeed
//
//  Created by Tomer Shiri on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface NSArray (filter)

-(NSArray*) filterByClass:(Class)clazz;
-(NSArray*) filterByBlock:(BOOL (^)(id obj))filterFunc;
-(NSArray*) mappedArray:(id (^)(id obj))mapFunc;
-(NSArray*) each:(void (^)(id obj))doFunction;
- (NSArray *)distinctArray;


@end
