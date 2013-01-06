//
//  PlayerDetailsViewController.m
//  chitacan-storyboards
//
//  Created by kyung yeol Kim on 13. 1. 2..
//  Copyright (c) 2013년 kyung yeol Kim. All rights reserved.
//

#import "PlayerDetailsViewController.h"
#import "Player.h"

@interface PlayerDetailsViewController ()

@end

@implementation PlayerDetailsViewController {
    NSString *game;
}

@synthesize delegate;
@synthesize nameTextField;
@synthesize detailLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailLabel.text = game;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickGame"])
	{
		GamePickerViewController *gamePickerViewController =
        segue.destinationViewController;
		gamePickerViewController.delegate = self;
		gamePickerViewController.game = game;
	}
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        [self.nameTextField becomeFirstResponder];
}

#pragma mark - handle Bar Button Events

-(IBAction)done:(id)sender {
    
    Player *player = [[Player alloc]init];
    player.name = self.nameTextField.text;
    player.game = @"Chess";
    player.rating = 1;
    
    [self.delegate playerDetailsViewController:self didAddPlayer:player];
}

-(IBAction)cancel:(id)sender {
    [self.delegate playerDetailsViewControllerDidCancel:self];
}

#pragma mark - GamePickerControllerDelegate

- (void)gamePickerViewController:(GamePickerViewController *)controller
                   didSelectGame:(NSString *)theGame {
    game = theGame;
    self.detailLabel.text = game;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - see when storyboards init & dealloc

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		NSLog(@"init PlayerDetailsViewController");
        game = @"Chess";
	}
	return self;
}
- (void)dealloc
{
	NSLog(@"dealloc PlayerDetailsViewController");
}


@end
