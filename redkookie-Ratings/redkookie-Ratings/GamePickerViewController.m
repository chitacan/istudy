//
//  GamePickerViewController.m
//  redkookie-Ratings
//
//  Created by Kim cloody on 12. 12. 26..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import "GamePickerViewController.h"


@implementation GamePickerViewController
{
    // ....왜 해더의 인터페이스에 선언하지 않고 여기다가 선언해도 되는거더라...
    NSArray *games;
	NSUInteger selectedIndex;
}

@synthesize delegate = _delegate;
@synthesize game = _game;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    games = [NSArray arrayWithObjects:
             @"Angry Birds",
             @"Chess",
             @"Russian Roulette",
             @"Spin the Bottle",
             @"Texas Hold’em Poker",
             @"Tic-Tac-Toe",
             nil];
    
    // We’ll use that index to set a checkmark in the table view cell
    // For this work, _game must be filled in before the view is loaded. That will be no problem because we’ll do this in the caller’s prepareForSegue, which takes place before viewDidLoad.
    selectedIndex = [games indexOfObject:_game];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    // Even though viewDidUnload will never actually be called on this screen (we never obscure it with another view), it’s still good practice to always balance your allocations with releases.
    
    // 1. viewDidLoad 에서 만들어준 객체는 viewDidUnload 에서 해제할 것
    // 2. IBOutlet 을 통해 만들어준 객체 역시 viewDidUnload 에서 해제할 것
    // 왜???
    /*
     viewDidUnload 는,
     viewController 가 네비게이션 컨트롤러에 푸시되거나 모달뷰로 인해 가려지는 경우와 같이 viewController 의 view가 보이지 않을때 memory warning 이 나게 되면 호출된다.
     당연히 dealloc 직전 호출 되겠지 하고 별생각 없이 코딩하면 안된다.
     
     더 자세하게 말하자면, 네비게이션 컨트롤러나 모달뷰처럼, 
     ui stack 에 들어간 보이지 않는 뷰 컨트롤러가 있는 상황에서 memory warning 을 받게 되면 메모리 확보를 위해 보이지 않는 뷰를 해제하게 된다.
     viewController.view = nil, IBOutlet 객체들을 날림과 함께 viewDidUnload 가 불려진다.
     viewController의 view는 날아간 상황이므로, 그 하부에 달려 있는 객체들은 미아가 되었고,
     viewController 가 이따 다시 pop 되어 보여지게 될 때, viewDidLoad 는 또 다시 호출될 것이므로,
     viewDidUnload 에서 처음 viewDidLoad 에서 만들어진 것들을 해제해주어야 하는 것이다.
     */
    games = nil;
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
    return [games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCell"];
    cell.textLabel.text = [games objectAtIndex:indexPath.row];
    // selectedIndex 에 따라 체크마크를 보여주거나 없애거나로 설정 
	if (indexPath.row == selectedIndex)
    {
		cell.accessoryType = 
        UITableViewCellAccessoryCheckmark;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
	if (selectedIndex != NSNotFound)
	{
        // 0 섹션(첫번째 섹션, 여기서는 오직 하나만 있음)에서 번호를 가지고 셀을 찾아옴 
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:
                                 [NSIndexPath indexPathForRow:selectedIndex inSection:0]];
        // 체크마크 제거 
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    // 다시 사용자가 누른 셀의 번호를 넣음 
	selectedIndex = indexPath.row;
    // 그 셀 가져와서..
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 케그마크를 나타냄 
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
    // 게임의 텍스트도 가져옴
	NSString *theGame = [games objectAtIndex:indexPath.row];
    // 그 텍스트를 델리게이트를 통해서 전달 
	[_delegate gamePickerViewController:self didSelectGame:theGame];
}

@end
