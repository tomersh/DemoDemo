//
//  MacroExtensions.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/2/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "SidebarViewController.h"
#import "PersistentStorageProvider.h"
#import "Website.h"
#import "NewWebSiteInputCell.h"

@implementation SidebarViewController
@synthesize sidebarDelegate;

typedef enum MenuSections {
    MenuSectionsAdd = 0,
    MenuSectionsBookmarks = 1,
    MenuSectionsCount = 2
}MenuSections;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (!self) return self;
    self.tableView.backgroundColor = [UIColor underPageBackgroundColor];
    sites = [[PersistentStorageProvider fetchObjectByKey:WEBSITES_STORAGE_KEY] retain];
    if (!sites) {
        sites = [[Websites alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.sidebarDelegate != nil) {
        NSIndexPath *indexPath = [self.sidebarDelegate lastSelectedIndexPathForSidebarViewController:self];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sites.websites count] == 0 ? MenuSectionsCount - 1 : MenuSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == MenuSectionsAdd)
        return 1;
    return [sites.websites count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == MenuSectionsBookmarks) return @"Bookmarks";
    return @"Add bookmark";
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    if (indexPath.section == MenuSectionsAdd) {
        cell = [tableView createCellwithType:[NewWebSiteInputCell class]];
        [((NewWebSiteInputCell*)cell) setAddbuttonDelegateWithTarget:self andSelector:@selector(addUrl:)];
    }
    else {
        cell = [tableView createCellwithType:[UITableViewCell class]];
        cell.textLabel.text = ((Website*)[sites.websites objectAtIndex:indexPath.row]).url;
    }
    return cell;
}

-(void) addUrl:(NSString*) url {
    
    Website* newSite = [[Website alloc] initWithUrl:url];
    [sites addWebsite:newSite];
    [newSite prefetchWithDelegate:self];
    [PersistentStorageProvider storeObject:sites withKey:WEBSITES_STORAGE_KEY];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[sites.websites count] - 1 inSection:MenuSectionsBookmarks];
    [self.view endEditing:YES];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
     safeRelease(newSite);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sidebarDelegate) {
        NSObject* object = nil;
        if (indexPath.section == MenuSectionsBookmarks) {
            object = [sites.websites objectAtIndex:indexPath.row];
        }
        [self.sidebarDelegate sidebarViewController:self didSelectObject:object atIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == MenuSectionsBookmarks;
}


- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [sites removeWebsiteAtIndex:indexPath.row];
    [PersistentStorageProvider storeObject:sites withKey:WEBSITES_STORAGE_KEY];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

-(void)viewDidUnload {
    safeRelease(sites);
    [super viewDidUnload];
}

@end
