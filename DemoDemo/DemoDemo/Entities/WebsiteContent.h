//
//  WebsiteContent.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

@interface WebsiteContent : NSObject<NSCoding>
{
    NSString* url;
    NSString* content;
    NSDate* lastupdated;
}

@property (nonatomic,retain) NSString* url;
@property (nonatomic,retain) NSString* content;
@property (nonatomic,retain) NSDate* lastupdated;

-(id)initWithWebsite:(NSString*) theUrl andContent:(NSString*)theContent andUpdateDate:(NSDate*) date;

@end
