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
#import "Computer.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "NSObject+Blocks.h"

static NSMutableDictionary * myDicData;

@interface VocabularyViewController ()

@end

@implementation VocabularyViewController

@synthesize tableView = _tableView;
@synthesize url = _url;

- (void) activeController
{
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"home_bkg.png"]];
    
    NSString * baseUrl = @"https://spreadsheets.google.com/feeds/worksheets/%@/public/basic";
    idSpreadsheet = @"0AhFKp-lXqsT9dDRpc1ZUeDRJa01XQW9iZEhRRl9Bc1E";
    
    self.url = [NSURL URLWithString:[NSString stringWithFormat:baseUrl, idSpreadsheet]];
    
    self.mode = @"list";
    
    self.title = @"Leçons disponibles";
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [self runDownload:FALSE];
}

- (void) activeDetail
{
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"home_bkg.png"]];
    self.title = @"Contenu de la leçon"; 
    
}

- (void) runDownload:(BOOL)removeCache
{
    results = [[NSMutableArray alloc] init];
    
    static GDataServiceGoogleSpreadsheet* service = nil;
    
    if (!service) {
        service = [[GDataServiceGoogleSpreadsheet alloc] init];
        
        [service setShouldCacheResponseData:YES];
        [service setServiceShouldFollowNextLinks:YES];
        
    }
    
    if(removeCache)
    {
        [myDicData setObject:@"waza" forKey:self.url.absoluteString];
    }
    
    if([[self kownUrl:self.url.absoluteString] isEqualToString:@"alreayKnow"])
    {
        [self ticket:nil finishedWithFeed:[myDicData objectForKey:self.url.absoluteString] error:nil];
    }
    else
    {
        [self.tableView.pullToRefreshView startAnimating];
        [service fetchFeedWithURL:self.url delegate:self didFinishSelector:@selector(ticket:finishedWithFeed:error:)];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    
}

- (id)kownUrl:(NSString *)url
{
    if(myDicData == nil)
    {
        myDicData = [[NSMutableDictionary alloc] init];
    }
    
    id laclasse = [[myDicData objectForKey:url] class];
    NSLog(@"%@", laclasse);
    
    if([laclasse isSubclassOfClass:[GDataFeedWorksheet class]] || [laclasse isSubclassOfClass:[GDataFeedSpreadsheetCell class]])
    {
        return @"alreayKnow";
    }
    else
    {
        return @"ko";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        [self runDownload:YES];
        // prepend data to dataSource, insert cells at top of table view
        // call [tableView.pullToRefreshView stopAnimating] when done
    }];
    
}

- (void)ticket:(GDataServiceTicket *)ticket
finishedWithFeed:(id)feed
         error:(NSError *)error {
    
    if(ticket != nil)
    {
        [myDicData setObject:feed forKey:self.url.absoluteString];
    }
    
    [self performBlock:^{
        [self.tableView.pullToRefreshView stopAnimating];
    } afterDelay:0.3];
    
    //self.tableView.tableHeaderView = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (error == nil) {
        
        NSArray *entries = [feed entries];
        if ([entries count] > 0) {
            
            VocabularyItem * currentItem = [[VocabularyItem alloc] init];
            
            if([self.mode isEqualToString:@"list"])
            {
                NSURL * currentUrl;
                
                
                
                for(GDataEntryWorksheet * entry in entries)
                {
                    NSString * title = entry.title.contentStringValue;
                    
                    currentItem.romanji = title;
                    
                    if(![entry.listFeedURL isEqual:currentUrl])
                    {
                        currentUrl = entry.listFeedURL;
                        
                        currentItem.url = [NSURL URLWithString:[[entry.cellsLink.URL absoluteString] stringByReplacingOccurrencesOfString:@"/basic" withString:@"/values"]];
                        
                        [results addObject:currentItem];
                        currentItem = [[VocabularyItem alloc] init];
                    }
                }
                
            }
            else
            {
                int currentRow = 1;
                
                for(GDataEntrySpreadsheetCell * entry in entries)
                {
                    NSString * title = entry.title.contentStringValue;
                    NSString * content = entry.content.contentStringValue;
                    
                    GDataSpreadsheetCell *cell = [entry cell];
                    
                    switch (cell.column) {
                        case 1:
                            [currentItem setTraduction:content];
                            break;
                            
                        case 2:
                            [currentItem setRomanji:content];
                            break;
                            
                        case 3:
                            [currentItem setKana:content];
                            break;
                            
                        case 4:
                            [currentItem setKanji:content];
                            break;
                            
                        case 5:
                            [currentItem setSampleUsageRomanji:content];
                            break;
                        case 6:
                            [currentItem setSampleUsageJapan:content];
                            break;
                        case 7:
                            [currentItem setSampleUsageTraduction:content];
                            break;
                            
                        default:
                            break;
                    }
                    
                    if(currentRow != (int)cell.row)
                    {
                        NSLog(@"row: %i", cell.row);
                        [results addObject:currentItem];
                        currentItem = [[VocabularyItem alloc] init];
                        currentRow = cell.row;
                    }
                }
                
                [results addObject:currentItem];
                
            }
            
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
    
    if([results count] > 0)
    {
        
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
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    VocabularyItem * item = [results objectAtIndex:indexPath.row];
    
    if([self.mode isEqualToString:@"list"])
    {
        VocabularyViewController * subListController = [[VocabularyViewController alloc] initWithNibName:@"VocabularyViewController" bundle:nil];
        subListController.mode = @"detail";
        subListController.url = item.url;
        [subListController activeDetail];
        [subListController runDownload:FALSE];
        [self.navigationController pushViewController:subListController animated:YES];
        
    }
    else
    {
        
        VocabularyDetailViewController *detailViewController = [[VocabularyDetailViewController alloc] initWithNibName:@"VocabularyDetailViewController" bundle:nil];
        
        detailViewController.currentItem = item;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
}

@end
