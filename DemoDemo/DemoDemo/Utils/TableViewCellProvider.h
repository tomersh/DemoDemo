//
//  TableViewCellProvider.h
//  Newsfeed
//
//  Created by Tomer Shiri on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UITableView (TableViewCellProvider)

-(UITableViewCell*) createCellwithType:(Class)type;
-(UITableViewCell*) createCellwithType:(Class)type andIdentifier:(NSString*) identifier;
@end

@interface TableViewCellProvider : NSObject {
 
}

+(UITableViewCell*) createCellInTable:(UITableView*)tableView withCellType:(Class)type andIdentifier:(NSString*) identifier;

+(UITableViewCell*) createCellInTable:(UITableView*)tableView withCellType:(Class)type;
@end
