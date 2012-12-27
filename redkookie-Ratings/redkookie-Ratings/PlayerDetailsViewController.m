//
//  PlayerDetailsViewController.m
//  redkookie-Ratings
//
//  Created by Kim cloody on 12. 12. 25..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import "PlayerDetailsViewController.h"

#import "Player.h"

@implementation PlayerDetailsViewController
{
	NSString *game;
    NSInteger ratings;
}

@synthesize delegate = _delegate;
@synthesize nameTextField = _nameTextField;
@synthesize detailLabel = _detailLabel;
@synthesize ratingLabel = _ratingLabel;

// 최초에 호출 됨 
- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		game = @"Chess";
        ratings = 1;
	}
	return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"PickGame"])
	{
		GamePickerViewController *gamePickerViewController = segue.destinationViewController;
		gamePickerViewController.delegate = self;
		gamePickerViewController.game = game;
	}
    
    if ([segue.identifier isEqualToString:@"SetRating"])
	{
		RatingDetailViewController *ratingDetailViewController = segue.destinationViewController;
		ratingDetailViewController.delegate = self;
        ratingDetailViewController.rating = ratings - 1;
	}
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _detailLabel.text = game;
    _ratingLabel.text = [NSString stringWithFormat:@"%d", ratings];
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setDetailLabel:nil];
    _ratingLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)cancel:(id)sender
{
	[_delegate playerDetailsViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
	//[_delegate playerDetailsViewControllerDidSave:self];
    Player *player = [[Player alloc] init];
	player.name = _nameTextField.text;
	player.game = game;
	player.rating = ratings;
	[_delegate playerDetailsViewController:self didAddPlayer:player];
}

// 프로토콜에 있는 메소드 구현 
- (void)gamePickerViewController:(GamePickerViewController *)controller 
                   didSelectGame:(NSString *)theGame
{
	game = theGame;
	_detailLabel.text = game;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)ratingDetailViewController:(RatingDetailViewController *)controller didSelectRating:(NSInteger)rating
{
    ratings = rating + 1;
    _ratingLabel.text = [NSString stringWithFormat:@"%d", ratings];
	[self.navigationController popViewControllerAnimated:YES];    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// deleted
// Why : When you use static cells, your table view controller doesn’t need a data source. Because we used an Xcode template to create our PlayerDetailsViewController class, it still has some placeholder code for the data source, so let’s remove that code now that we have no use for it.

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 사용자는 어디가 입력인지 모르기 때문에 0 번 cell 의 어디를 클릭하던지 키보드가 나오도록 하자. 
    // It’s just a little tweak, but one that can save users a bit of frustration.
    if (indexPath.section == 0)
    {
		[self.nameTextField becomeFirstResponder];
    }
}

@end
