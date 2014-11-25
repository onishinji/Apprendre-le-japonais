//
//  KanaStatsController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 13/01/13.
//  Copyright (c) 2013 Guillaume chave. All rights reserved.
//

#import "KanaStatsController.h"
#import "Kana.h"
#import "Computer.h"
#import "StatUtils.h"
#import "UIColor+RGB.h"

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 50.0f

@implementation KanaStatsController

@synthesize globalScoreImg = _globalScoreImg;
@synthesize nekoMsg = _nekoMsg;
@synthesize msg = _msg;


- (void) viewDidLoad
{
    if([self isForHiragana])
    {
        _msg.text = NSLocalizedString(@"STATS.LABEL.MSG.HIRAGANA", "");
    }
    else
    {
        _msg.text = NSLocalizedString(@"STATS.LABEL.MSG.KATAKANA", "");
    }
    
    
    NSFetchedResultsController * resultsController;
    if([self isForHiragana])
    {
        resultsController = [[Computer sharedInstance] getHiraganaPerSections];
    }
    else
    {
        resultsController = [[Computer sharedInstance] getKatakanaPerSections];
    }
    
    allResult = [[NSMutableDictionary  alloc] init];
    allKanas = [[NSMutableArray alloc] init];
    
    int sectionId = 0;
    for(int i = 0; i < [[resultsController sections] count]; i++)
    {
        
        NSMutableArray * kanas = [[NSMutableArray alloc] init];
        
        id <NSFetchedResultsSectionInfo> info = [[resultsController sections] objectAtIndex:i];
        for(int j = 0; j < [info numberOfObjects]; j++)
        {
            Kana * k = [[info objects] objectAtIndex:j];
            [kanas addObject:k];
            [allKanas addObject:k];
        }
        
        [allResult setObject:kanas forKey:[NSString stringWithFormat:@"section_%d", sectionId] ];
        sectionId++;
        
    }
    
    smileyImgYes = [UIImage imageNamed:@"ic_pastille_gold.png"];
    smileyImgMedium = [UIImage imageNamed:@"ic_pastille.png"];
    smileyImgNo = nil;
    
    
    
    UIImage * smileyImgYesGlobal;
    UIImage * smileyImgNoGlobal;
    UIImage * smileyImgMediumGlobal;
    
    smileyImgYesGlobal = [UIImage imageNamed:@"ic_gold"];
    smileyImgMediumGlobal = [UIImage imageNamed:@"ic_silver"];
    smileyImgNoGlobal = [UIImage imageNamed:@"ic_bronze"];
    
    
    
    smileyImgYesHeader = [UIImage imageNamed:@"ic_gold_small"];
    smileyImgMediumHeader = [UIImage imageNamed:@"ic_silver_small"];
    smileyImgNoHeader = [UIImage imageNamed:@"ic_bronze_small"];
    
    if([StatUtils entityIsKnow:allKanas])
    {
        [_globalScoreImg setImage:smileyImgYesGlobal];
        [_nekoMsg setText:NSLocalizedString(@"STATS.NEKO.MSG.GOOD", "")];
        
    }
    else if([StatUtils entityIsPendingKnow:allKanas])
    {
        [_globalScoreImg setImage:smileyImgMediumGlobal]; 
        [_nekoMsg setText:NSLocalizedString(@"STATS.NEKO.MSG.PENDING", "")];
    }
    else
    {
        [_globalScoreImg setImage:smileyImgNoGlobal];
        [_nekoMsg setText:NSLocalizedString(@"STATS.NEKO.MSG.BAD", "")];
    }
    
}


#pragma - UITableView for summary

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"sections %i",[allResult count]);
    return [allResult count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int nb = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d", section ]] count];
    NSLog(@"section %i a %i item", section, nb);
    
    return nb;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    static NSString *CellIdentifier = @"HeaderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel * label;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithR:255 G:63 B:77 A:1];
        
        label =  [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
        [label setNumberOfLines:0];
        [label setFont:[UIFont boldSystemFontOfSize:28]];
        
        [[cell contentView] addSubview:label];
        
    }
    
    switch (section) {
        case 0:
            label.text = NSLocalizedString(@"SECTION_GOJUON", "");
            break;
        case 1:
            label.text = NSLocalizedString(@"SECTION_GOJUON_DAKUTEN", "");
            break;
        case 2:
            label.text = NSLocalizedString(@"SECTION_YOON", "");
            break;
        case 3:
            label.text = NSLocalizedString(@"SECTION_YOON_DAKUTEN", "");;
            break;
        default:
            break;
    }
    
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.minimumFontSize = 8;
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 1;
    [cell addSubview:label];
    
    NSArray * elements = [allResult objectForKey:[NSString stringWithFormat:@"section_%d", section ]];
    
    
    UIImage * smileyImg;
    
    
    if([StatUtils entityIsKnow:elements])
    {
        smileyImg = smileyImgYesHeader;
    }
    else if([StatUtils entityIsPendingKnow:elements])
    {
        smileyImg = smileyImgMediumHeader;
    }
    else
    {
        smileyImg = smileyImgNoHeader;
    }
    
    [cell.imageView setImage:smileyImg];
    
    
    return cell;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifierStats = @"CellStats";
    
    
    UITableViewCell *cell = nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierStats];
        [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    }
    
    
    Kana * hir = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d",indexPath.section ]] objectAtIndex:indexPath.row];
    
    
    UIImage * smileyImg;
    
    if([StatUtils entityIsKnow:hir])
    {
        smileyImg = smileyImgYes;
    }
    else if([StatUtils entityIsPendingKnow:hir])
    {
        smileyImg = smileyImgMedium;
    }
    else
    {
        smileyImg = smileyImgNo;
    }
 
     [cell textLabel].minimumFontSize = 8;
     [cell textLabel].adjustsFontSizeToFitWidth = YES;
     [cell textLabel].numberOfLines = 1;

   
    
    
    [cell.imageView setImage:smileyImg];
    
    NSString *text = [NSString stringWithFormat:NSLocalizedString(@"STATS.CELL.KANA", ""), hir.romanji, hir.japan, [hir.scoring intValue]];
    
    [cell.textLabel setText:text];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Kana * objetInArray = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d",indexPath.section ]] objectAtIndex:indexPath.row];
    
    NSLog(@"didSelectRowAtIndexPath %i %i %@", indexPath.section, indexPath.row, objetInArray.romanji);
    
}


@end
