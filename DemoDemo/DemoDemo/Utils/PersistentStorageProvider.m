//
//  PersistentStorageProvider.m
//  Newsfeed
//
//  Created by Tomer Shiri on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PersistentStorageProvider.h"

@implementation PersistentStorageProvider

static NSUserDefaults* storage;

- (id)init {
    return nil;
}

+(void)initialize {
    storage = [[NSUserDefaults standardUserDefaults] retain];
}

+(void) removeObjectWithKey:(NSString*) key {
    [PersistentStorageProvider storeObject:nil withKey:key];
}

+(void) storeObject:(id) object withKey:(NSString*) key {
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [storage setValue:data forKey:key];
    [storage synchronize];
}

+(id) fetchObjectByKey:(NSString*) key {
    id data = [storage objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
