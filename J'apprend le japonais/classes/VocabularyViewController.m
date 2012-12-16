//
//  VocabularyViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 16/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "VocabularyViewController.h"
#import "GData.h"
#import "GDataSpreadsheet.h"  
#import "VocabularyItem.h"
#import "UIColor+RGB.h"


@interface VocabularyViewController ()

@end

@implementation VocabularyViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // NSURL * url = [NSURL URLWithString:@"docs.google.com/spreadsheet/ccc?key=0AqdL0GlDYDmQdGVLRXVkZklUSjA1NGtsWmJZYTFkRWc#gid=0"];
    
    
    NSString * baseUrl = @"http://spreadsheets.google.com/feeds/cells/%@/1/public/values";
    NSString * idSpreadsheet = @"0AqdL0GlDYDmQdGVLRXVkZklUSjA1NGtsWmJZYTFkRWc";
    
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:baseUrl, idSpreadsheet]];
    
    results = [[NSMutableArray alloc] init];
    
        
    GDataServiceGoogleSpreadsheet * service = [[GDataServiceGoogleSpreadsheet alloc] init];
     
    [service fetchFeedWithURL:url delegate:self didFinishSelector:@selector(ticket:finishedWithFeed:error:)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)ticket:(GDataServiceTicket *)ticket
finishedWithFeed:(GDataFeedCalendar *)feed
         error:(NSError *)error {
    
    if (error == nil) {
        
        NSArray *entries = [feed entries];
        if ([entries count] > 0) {
            
            int currentRow = 1;
            
            VocabularyItem * currentItem = [[VocabularyItem alloc] init];
            
            for(GDataEntrySpreadsheetCell * entry in entries)
            {
                NSString * title = entry.title.contentStringValue;
                NSString * content = entry.content.contentStringValue;
                
                GDataSpreadsheetCell *cell = [entry cell];
                
                NSLog(@"row: %i cell: %i %@ %@", [cell row], [cell column], title, content);
                
                switch (cell.column) {
                    case 2:
                        [currentItem setTraduction:content];
                        break;
                        
                    case 3:
                        [currentItem setRomanji:content];
                        break;
                        
                    case 4:
                        [currentItem setKana:content];
                        break;
                        
                    case 5:
                        [currentItem setKanji:content];
                        break;
                        
                    case 6:
                        [currentItem setSampleUsageRomanji:content];
                        break;
                    case 7:
                        [currentItem setSampleUsageJapan:content];
                        break; 
                    case 8:
                        [currentItem setSampleUsageTraduction:content];
                        break;
                        
                    default:
                        break;
                }
                
                if(currentRow != (int)cell.row)
                {
                    [results addObject:currentItem];
                    currentItem = [[VocabularyItem alloc] init];
                    currentRow = cell.row;
                }
            }
            [results addObject:currentItem];
            
            [self.tableView reloadData];
            
        } else {
            NSLog(@"the user has no calendars");
        }
    } else {
        NSLog(@"fetch error: %@", error);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    VocabularyItem * item = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = item.romanji;
    cell.detailTextLabel.text = item.traduction;
    cell.detailTextLabel.textColor = [UIColor colorWithR:0 G:0 B:0 A:0.9];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell.backgroundView.hidden = TRUE;
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    // Configure the cell...
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     VocabularyDetailViewController *detailViewController = [[VocabularyDetailViewController alloc] initWithNibName:@"VocabularyDetailViewController" bundle:nil];
    
    VocabularyItem * item = [results objectAtIndex:indexPath.row];
    
    detailViewController.currentItem = item;
    
     [self.parent.navigationController pushViewController:detailViewController animated:YES];
     
}

@end
