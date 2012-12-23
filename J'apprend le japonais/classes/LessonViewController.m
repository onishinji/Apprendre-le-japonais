//
//  LessonViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 22/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonViewController.h"
#import "ContentViewController.h"

@interface LessonViewController ()

@end

@implementation LessonViewController

@synthesize popoverController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createContentPages];
    
    popoverClass = [WEPopoverController class];
    
    nbSizeUpDown = [self getDefaultNbUpDownFont];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject: [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    _pageController.dataSource = self;
    [[_pageController view] setFrame:[[self view] bounds]];
    
    ContentViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    [_pageController didMoveToParentViewController:self];
    
    
    UIBarButtonItem *Button1 = [[UIBarButtonItem alloc]initWithTitle:@"aA" style:UIBarButtonItemStylePlain
                                                              target:self action:@selector(sizeUp:)] ;
    
    UIBarButtonItem *Button2 = [[UIBarButtonItem alloc] initWithTitle:@"Aa" style:UIBarButtonItemStylePlain
                                                               target:self action:@selector(sizeDown:)] ;
    
    UIBarButtonItem *btnSommaire = [[UIBarButtonItem alloc] initWithTitle:@"Sommaire" style:UIBarButtonItemStylePlain target:self action:@selector(openPopup:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:btnSommaire, Button1,Button2, nil];
    
    [self restoreIndex];
    
}

#pragma mark - data source

- (void) createContentPages
{
    NSArray * lessons = [NSArray arrayWithObjects:
                         @"d_1start",
                         @"d_2_01_hiragana",
                         @"d_2_02_katakana",
                         @"d_2_03_kanji",
                         @"d_2writingsys",
                         @"d_3_01_copula",
                         @"d_3_02_particles",
                         @"d_3_03_adjectives",
                         @"d_3_04_verbs",
                         @"d_3_05_negverb",
                         @"d_3_06_pastverb",
                         @"d_3_07_particles2",
                         @"d_3_08_transtype",
                         @"d_3_09_subclause",
                         @"d_3_10_particles3",
                         @"d_3_11_adgobi",
                         @"d_3basicgram",
                         @"d_4_01_polite",
                         @"d_4_02_people",
                         @"d_4_03_question",
                         @"d_4_04_compound",
                         @"d_4_05_teform",
                         @"d_4_06_potential",
                         @"d_4_07_surunaru",
                         @"d_4_08_conditionals",
                         @"d_4_09_must",
                         @"d_4_10_desire",
                         @"d_4_11_actionsubclause",
                         @"d_4_12_define",
                         @"d_4_13_try",
                         @"d_4_14_favors",
                         @"d_4_15_requests",
                         @"d_4_16_numbers",
                         @"d_4_18_gobi",
                         @"d_4essential",
                         @"d_5_01_causepass",
                         @"d_5_02_honorific",
                         @"d_5_03_unintended",
                         @"d_5_04_genericnouns",
                         @"d_5_05_certainty",
                         @"d_5_06_amount",
                         @"d_5_07_similarity",
                         @"d_5_08_comparison",
                         @"d_5_09_easyhard",
                         @"d_5_10_negativeverbs2",
                         @"d_5_11_reasoning",
                         @"d_5_12_timeactions",
                         @"d_5_13_nochange",
                         @"d_6_01_formal",
                         @"d_6_02_should",
                         @"d_6_03_even",
                         @"d_6_04_signs",
                         @"d_6_05_feasibility",
                         @"d_6_06_tendency",
                         @"d_6_07_volitional2",
                         @"d_6_08_covered",
                         @"d_6_10_immedate",
                         @"d_6_11_other",
                         @"d_6advanced",
                         @"gram_credits",
                         
                         nil];
    
    titleLessons = [NSArray arrayWithObjects:
                    @"Intro",
                    @"Hiragana",
                    @"Katakana",
                    @"Kanji",
                    @"Les alphabets",
                    @"Expression de l'état d'être",
                    @"Les particules de bases",
                    @"Les adjectifs",
                    @"Les verbes",
                    @"Forme Négative",
                    @"Le passé",
                    @"Les particules, le retour",
                    @"Verbe transitif, intransifif",
                    nil];
    
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    for (int i = 0; i < lessons.count; i++)
    {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:[lessons objectAtIndex:i] ofType:@"xml"];
        NSData* htmlData = [NSData dataWithContentsOfFile:filePath];
        NSString* htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
        
        [pageStrings addObject:htmlString];
    }
    _pageContent = [[NSArray alloc] initWithArray:pageStrings];
}

#pragma mark - UIPageViewController Delegate

- (ContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count]))
    {
        return nil;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
    
    ContentViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
    dataViewController.dataObject = _pageContent[index];
    dataViewController.nbUpDown = [NSNumber numberWithInt:nbSizeUpDown];
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(ContentViewController *)viewController
{
    return [_pageContent indexOfObject:viewController.dataObject];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    currentIndex = [self indexOfViewController:(ContentViewController *)viewController];
    if ((currentIndex == 0) || (currentIndex == NSNotFound))
    {
        return nil;
    }
    
    currentIndex--;
    
    [self saveIndex:currentIndex];
    
    return [self viewControllerAtIndex:currentIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    currentIndex = [self indexOfViewController:(ContentViewController *)viewController];
    if (currentIndex == NSNotFound)
    {
        return nil;
    }
    
    currentIndex++;
    
    if (currentIndex == [self.pageContent count])
    {
        return nil;
    }
    
    [self saveIndex:currentIndex];
    
    return [self viewControllerAtIndex:currentIndex];
}

#pragma mark - bookmark actions

- (void) saveIndex:(int) index
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:index] forKey:@"current_page"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) restoreIndex
{
    NSNumber * index = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"current_page"];
    if(index != nil && [index intValue] > 0)
    {
        [self flipToPage:[index intValue]];
    }
}

#pragma mark - FontSize

- (CGFloat) getDefaultNbUpDownFont
{
    NSNumber * index = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"current_nb_up_down_font_size"];
    NSLog(@"fontSize %@", index);
    if(index != nil)
    {
        return [index intValue];
    }
    else
    {
        return 0;
    }
}

- (void) setDefaultNbUpDownFont:(CGFloat) index
{
    NSLog(@"index %2.f", index);
    if(index > -8 && index < 12)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:index] forKey:@"current_nb_up_down_font_size"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

#pragma mark - IBAction

- (IBAction)sizeUp:(id)sender
{
    if(nbSizeUpDown < 12)
    {
        nbSizeUpDown++;
        [self setDefaultNbUpDownFont:nbSizeUpDown];
        ContentViewController * content = (ContentViewController *)[[self.pageController viewControllers] objectAtIndex:0];
        [content sizeUp];
    }
}

- (IBAction)sizeDown:(id)sender
{
    if(nbSizeUpDown > -8)
    {
        nbSizeUpDown--;
        [self setDefaultNbUpDownFont:nbSizeUpDown];
        ContentViewController * content = (ContentViewController *)[[self.pageController viewControllers] objectAtIndex:0];
        [content sizeDown];
    }
}

# pragma mark - popover

- (void) openPopup:(id)sender
{
    
    if (!self.popoverController)
    {
		
		UITableViewController *contentViewController = [[UITableViewController alloc] init];
        contentViewController.tableView.dataSource = self;
        contentViewController.tableView.delegate = self;
        
		self.popoverController = [[popoverClass alloc] initWithContentViewController:contentViewController];
		self.popoverController.delegate = self;
		self.popoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
        
		if ([self.popoverController respondsToSelector:@selector(setContainerViewProperties:)])
        {
			[self.popoverController setContainerViewProperties:[self improvedContainerViewProperties]];
		}
		
		[self.popoverController presentPopoverFromBarButtonItem:sender
									   permittedArrowDirections:UIPopoverArrowDirectionUp
													   animated:YES];
        
	}
    else
    {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
	}
    
}

- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
	
	WEPopoverContainerViewProperties *props = [WEPopoverContainerViewProperties alloc];
	NSString *bgImageName = nil;
	CGFloat bgMargin = 0.0;
	CGFloat bgCapSize = 0.0;
	CGFloat contentMargin = 4.0;
	
	bgImageName = @"popoverBg.png";
	
	// These constants are determined by the popoverBg.png image file and are image dependent
	bgMargin = 13; // margin width of 13 pixels on all sides popoverBg.png (62 pixels wide - 36 pixel background) / 2 == 26 / 2 == 13
	bgCapSize = 31; // ImageSize/2  == 62 / 2 == 31 pixels
	
	props.leftBgMargin = bgMargin;
	props.rightBgMargin = bgMargin;
	props.topBgMargin = bgMargin;
	props.bottomBgMargin = bgMargin;
	props.leftBgCapSize = bgCapSize;
	props.topBgCapSize = bgCapSize;
	props.bgImageName = bgImageName;
	props.leftContentMargin = contentMargin;
	props.rightContentMargin = contentMargin - 1; // Need to shift one pixel for border to look correct
	props.topContentMargin = contentMargin;
	props.bottomContentMargin = contentMargin;
	
	props.arrowMargin = 4.0;
	
	props.upArrowImageName = @"popoverArrowUp.png";
	props.downArrowImageName = @"popoverArrowDown.png";
	props.leftArrowImageName = @"popoverArrowLeft.png";
	props.rightArrowImageName = @"popoverArrowRight.png";
	return props;
}

#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
	self.popoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}

#pragma - UITableView for summary

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleLessons.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
    NSString *cellValue = [titleLessons objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self flipToPage:indexPath.row];
    
}

-(void) flipToPage:(int)index {
    
    
    int x = index;
    ContentViewController *theCurrentViewController = [self.pageController.viewControllers   objectAtIndex:0];
    
    NSUInteger retreivedIndex = [self indexOfViewController:theCurrentViewController];
    
    ContentViewController *firstViewController = [self viewControllerAtIndex:x];
    
    
    NSArray *viewControllers = nil;
    
    viewControllers = [NSArray arrayWithObjects:firstViewController, nil];
    
    
    if (retreivedIndex < x)
    {
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    }
    else
    {
        if (retreivedIndex > x )
        {
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
        } 
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


@end
