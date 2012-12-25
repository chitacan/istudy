//
//  PlayersViewController.m
//  redkookie-Ratings
//
//  Created by Kim cloody on 12. 12. 25..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import "PlayersViewController.h"
#import "Player.h"
#import "PlayerCell.h"

@implementation PlayersViewController

@synthesize players = _players;

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

// Why : The prepareForSegue method is invoked whenever a segue is about to take place. The new view controller has been loaded from the storyboard at this point but it’s not visible yet, and we can use this opportunity to send data to it. (You never call prepareForSegue yourself, it’s a message from UIKit to let you know that a segue has just been triggered.)
// Remember: Segues only go one way, they are only used to open a new screen. To go back you dismiss the screen (or pop it from the navigation stack), usually from a delegate.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddPlayer"])
	{
        // the destination of the segue is the Navigation Controller, because that is what we connected to the Bar Button Item.
        // 바 버튼에서 + 로 바꾼 녀석을 네이게이션 컨트롤러에 새규 로 연결했기 때문.
		UINavigationController *navigationController = segue.destinationViewController;
        // 이전과 같은 이유 
		PlayerDetailsViewController *playerDetailsViewController = 
        [[navigationController viewControllers] objectAtIndex:0];
        // 이건 문법을 아직 다 이해하지 못하여 모르겠음...
		playerDetailsViewController.delegate = self;
	}
}

#pragma mark - PlayerDetailsViewControllerDelegate

- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

/*
- (void)playerDetailsViewControllerDidSave:(PlayerDetailsViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
 */

- (void)playerDetailsViewController:(PlayerDetailsViewController *)controller 
                       didAddPlayer:(Player *)player
{
    // add
	[_players addObject:player];
    // Why : We could have just done a [self.tableView reloadData] but it looks nicer to insert the new row with an animation. UITableViewRowAnimationAutomatic is a new constant in iOS 5 that automatically picks the proper animation, depending on where you insert the new row, very handy.
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_players count] - 1 inSection:0];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                          withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If there is no existing cell that can be recycled, this will automatically make a new copy of the prototype cell and return it to you.
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
	Player *player = [_players objectAtIndex:indexPath.row];
    /*
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
	nameLabel.text = player.name;
	UILabel *gameLabel = (UILabel *)[cell viewWithTag:101];
	gameLabel.text = player.name;
	UIImageView * ratingImageView = (UIImageView *)[cell viewWithTag:102];
	ratingImageView.image = [self imageForRating:player.rating];
    */
    cell.nameLabel.text = player.name;
	cell.gameLabel.text = player.game;
	cell.ratingImageView.image = [self imageForRating:player.rating];
    return cell;
}

- (UIImage *)imageForRating:(int)rating
{
	switch (rating)
	{
		case 1: return [UIImage imageNamed:@"1StarSmall.png"];
		case 2: return [UIImage imageNamed:@"2StarsSmall.png"];
		case 3: return [UIImage imageNamed:@"3StarsSmall.png"];
		case 4: return [UIImage imageNamed:@"4StarsSmall.png"];
		case 5: return [UIImage imageNamed:@"5StarsSmall.png"];
	}
	return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[_players removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}  
}


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

// (Note that the table view delegate method didSelectRowAtIndexPath in PlayerDetailsViewController is still called when you tap the Game row, so make sure you don’t do anything there that will conflict with the segue.)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
