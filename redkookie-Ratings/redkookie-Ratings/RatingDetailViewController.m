//
//  RatingDetailViewController.m
//  redkookie-Ratings
//
//  Created by cloody on 12. 12. 27..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import "RatingDetailViewController.h"
#import "RatingCell.h"

@interface RatingDetailViewController ()

@end

@implementation RatingDetailViewController

@synthesize delegate = _delegate;
@synthesize rating = _rating;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RatingCell";
    RatingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            [cell.ratingImageView setImage:[UIImage imageNamed:@"1Star"]];
            break;
        case 1:
            [cell.ratingImageView setImage:[UIImage imageNamed:@"2Stars"]];
            break;
        case 2:
            [cell.ratingImageView setImage:[UIImage imageNamed:@"3Stars"]];
            break;
        case 3:
            [cell.ratingImageView setImage:[UIImage imageNamed:@"4Stars"]];
            break;
        case 4:
            [cell.ratingImageView setImage:[UIImage imageNamed:@"5Stars"]];
            break;
        default:
            break;
    }
    
	if (indexPath.row == _rating)
    {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
	else
    {
		cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
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
    // That makes it fade from the blue highlight color back to the regular white.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 먼저 이전에 있던 번호의 셀의 체크마크를 제거
	if (_rating != NSNotFound)
	{
        // 0 섹션(첫번째 섹션, 여기서는 오직 하나만 있음)에서 번호를 가지고 셀을 찾아옴
		RatingCell *cell = (RatingCell*)[tableView cellForRowAtIndexPath:
                                 [NSIndexPath indexPathForRow:_rating inSection:0]];
        // 체크마크 제거
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    // 다시 사용자가 누른 셀의 번호를 넣음
	_rating = indexPath.row;
    // 그 셀 가져와서..
	RatingCell *cell = (RatingCell*)[tableView cellForRowAtIndexPath:indexPath];
    // 케그마크를 나타냄
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [_delegate ratingDetailViewController:self didSelectRating:_rating];
}

@end
