//
//  TableViewCellProvider.m
//  Newsfeed
//
//  Created by Tomer Shiri on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewCellProvider.h"


@implementation UITableView (TableViewCellProvider)

-(UITableViewCell*) createCellwithType:(Class)type {
    return [TableViewCellProvider createCellInTable:self withCellType:type];
}

-(UITableViewCell*) createCellwithType:(Class)type andIdentifier:(NSString*) identifier {
    return [TableViewCellProvider createCellInTable:self withCellType:type andIdentifier:identifier];
}

@end

@implementation TableViewCellProvider

+(UITableViewCell*) createCellInTable:(UITableView*)tableView withCellType:(Class)type {
    NSString* identifier = @"";
    if (type != nil)
        identifier = NSStringFromClass(type);
    return [TableViewCellProvider createCellInTable:tableView withCellType:type andIdentifier:identifier];
}

+(UITableViewCell*) createCellInTable:(UITableView*)tableView withCellType:(Class)type 
    andIdentifier:(NSString*) identifier {
    UITableViewCell* cell = [[tableView dequeueReusableCellWithIdentifier:identifier] retain];
    if (cell == nil) {
        cell = [[type alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    else {
        [cell prepareForReuse];
    }
    return [cell autorelease];
}


@end
