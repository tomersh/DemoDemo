//
//  PersistentStorageProvider.h
//  Newsfeed
//
//  Created by Tomer Shiri on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface PersistentStorageProvider : NSObject

+(void) storeObject:(id) object withKey:(NSString*) key;
+(void) removeObjectWithKey:(NSString*) key;
+(id) fetchObjectByKey:(NSString*) key;

@end
