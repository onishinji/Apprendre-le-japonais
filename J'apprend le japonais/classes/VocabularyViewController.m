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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        [self runDownload:YES];
        // prepend data to dataSource, insert cells at top of table view
        // call [tableView.pullToRefreshView stopAnimating] when done
    }];
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VocabularyTableViewEmpty"];
    [self.tableView setNxEV_emptyView:viewController.view];
    
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
        [[Computer sharedInstance] setWithKey:self.url.absoluteString andValue:nil];
    }
    
    if([[self kownUrl:self.url.absoluteString] isEqualToString:@"alreayKnow"])
    {
        if([self.mode isEqualToString:@"list"])
        {
            Cache * cache = [[Computer sharedInstance] getWithKey:self.url.absoluteString];
            NSString * xmlString = [[NSString alloc] initWithData:cache.value encoding:NSUTF8StringEncoding];
            GDataFeedWorksheet * feed;
            NSError * error;
            
            NSXMLElement *xmlElement = [[NSXMLElement alloc] initWithXMLString:xmlString error: &error];
            feed =  [[GDataFeedWorksheet alloc] initWithXMLElement:xmlElement parent:nil];
            
            [self ticket:nil finishedWithFeed:feed error:nil];
        }
        else
        {
            Cache * cache = [[Computer sharedInstance] getWithKey:self.url.absoluteString];
            NSString * xmlString = [[NSString alloc] initWithData:cache.value encoding:NSUTF8StringEncoding];
            GDataFeedSpreadsheetCell * feed;
            NSError * error;
            
            NSXMLElement *xmlElement = [[NSXMLElement alloc] initWithXMLString:xmlString error: &error];
            feed =  [[GDataFeedSpreadsheetCell alloc] initWithXMLElement:xmlElement parent:nil];
            
            [self ticket:nil finishedWithFeed:feed error:nil];
        }
        
        
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
    Cache * cache = [[Computer sharedInstance] getWithKey:url];
    
    if(cache != nil && cache.value != nil)
    {
        return @"alreayKnow";
    }
    else
    {
        return @"ko";
    }
}



- (void)ticket:(GDataServiceTicket *)ticket
finishedWithFeed:(GDataFeedBase *)feed
         error:(NSError *)error {
    
    if(feed != nil)
    {
        // if ticket, it's grabed from the net
        if(ticket != nil)
        {
            NSString * xmlString = [[feed XMLElement] XMLString];
            NSData * data = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
            
            [[Computer sharedInstance] setWithKey:self.url.absoluteString andValue:data];
        }
        
        [self performBlock:^{
            [self.tableView.pullToRefreshView stopAnimating];
        } afterDelay:0.3];
        
        //self.tableView.tableHeaderView = nil;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error == nil) {
            
            NSArray *entries = [feed entries];
            [self createDataSource:entries];
            
        } else {
            NSLog(@"fetch error: %@", error);
        }
    }
    else
    {
        [self.tableView.pullToRefreshView stopAnimating];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
        NSLog(@"fetch error: %@", error);
    }
}

- (void) createDataSource:(NSArray *) entries
{
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
                NSString * content = entry.content.contentStringValue;
                
                GDataSpreadsheetCell *cell = [entry cell];
                
                
                NSLog(@"row: %i  %i ", cell.row, cell.column);
                
                if((int)cell.row > currentRow)
                {
                    NSLog(@"add %@ %@", currentItem.romanji, currentItem.traduction);
                    [results addObject:currentItem];
                    currentItem = [[VocabularyItem alloc] init];
                    currentRow = cell.row;
                }
                
                
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
            }
            
            [results addObject:currentItem];
            
        }
        
        [self.tableView reloadData];
        
    } else {
        NSLog(@"Oups");
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
        
        
        if([self.mode isEqualToString:@"list"])
        {
            cell.textLabel.text = item.romanji;
            cell.detailTextLabel.text = item.traduction;
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", item.romanji, item.traduction];
            
            if(item.kanji == nil)
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", item.kana];
            }
            else
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", item.kana, item.kanji];
                
            }
        }
        
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
    {   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
        
        VocabularyViewController *subListController = [storyboard instantiateViewControllerWithIdentifier:@"vocabularyList"];
        
        subListController.mode = @"detail";
        subListController.url = item.url;
        [subListController activeDetail];
        [subListController runDownload:FALSE];
        [self.navigationController pushViewController:subListController animated:YES];
        
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
        
        VocabularyDetailViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"vocabularyDetail"];
        
        detailViewController.currentItem = item;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
}

@end
