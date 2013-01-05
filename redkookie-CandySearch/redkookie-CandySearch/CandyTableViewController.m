//
//  CandyTableViewController.m
//  redkookie-CandySearch
//
//  Created by cloody on 13. 1. 5..
//  Copyright (c) 2013년 cloody. All rights reserved.
//

#import "CandyTableViewController.h"

#import "Candy.h"

@interface CandyTableViewController ()

@end

@implementation CandyTableViewController

@synthesize candyArray = _candyArray;

@synthesize filteredCandyArray = _filteredCandyArray;
@synthesize candySearchBar = _candySearchBar;

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

    // Don't show the scope bar or cancel button until editing begins
    [_candySearchBar setShowsScopeBar:NO];
    [_candySearchBar sizeToFit];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Sample Data for candyArray
    _candyArray = [NSArray arrayWithObjects:
                  [Candy candyOfCategory:@"chocolate" name:@"chocolate bar"],
                  [Candy candyOfCategory:@"chocolate" name:@"chocolate chip"],
                  [Candy candyOfCategory:@"chocolate" name:@"dark chocolate"],
                  [Candy candyOfCategory:@"hard" name:@"lollipop"],
                  [Candy candyOfCategory:@"hard" name:@"candy cane"],
                  [Candy candyOfCategory:@"hard" name:@"jaw breaker"],
                  [Candy candyOfCategory:@"other" name:@"caramel"],
                  [Candy candyOfCategory:@"other" name:@"sour chew"],
                  [Candy candyOfCategory:@"other" name:@"peanut butter cup"],
                  [Candy candyOfCategory:@"other" name:@"gummi bear"], nil];
    
    // Reload the table
    [self.tableView reloadData];
    
    _filteredCandyArray = [NSMutableArray arrayWithCapacity:[_candyArray count]];
    
    // Hide the search bar until user scrolls up
    // 원래 테이블 뷰의 바운스에다가 서치컨트롤러의 높이만큼 더해줘서 뷰를 로드하도록 함.
    // 단점은 처음에 이 뷰가 로드될 때에만 유효함
    // 디테일 들어갔다 나오거나, 서치하고나서 취소하거나 하면 서치컨트롤러가 그대로 남아있음
    // 이걸, 윌디드어피어 등등에 넣으면 좀 달라질까??
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + _candySearchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
}

-(IBAction)goToSearch:(id)sender {
    // If you're worried that your users might not catch on to the fact that a search bar is available if they scroll to reveal it, a search icon will help them
    // If you don't hide your search bar in your app, don’t include this, as it would be redundant
    // 키보드를 올라오게 하므로써 써치 ui 가 나바타도록 해주는듯 함.
    [_candySearchBar becomeFirstResponder];
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
    //return [_candyArray count];
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_filteredCandyArray count];
    } else {
        return [_candyArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Create a new Candy Object
    Candy *candy = nil;
    //candy = [_candyArray objectAtIndex:indexPath.row];
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    // 어떤 테이블 뷰 컨트롤러인가에 따라 원본을 보여줄지, 필터된 것을 보여줄지 나뉜다.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        candy = [_filteredCandyArray objectAtIndex:indexPath.row];
    } else {
        candy = [_candyArray objectAtIndex:indexPath.row];
    }
    
    // Configure the cell
    cell.textLabel.text = candy.name;
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    // Perform segue to candy detail
    // 나는 현재 스토리보드에서 그냥 테이블뷰의 셀이 선택되었을 때 push 가 동작하도록 되어있음
    // 이렇게 서치 컨트롤러의 테이블뷰 일 때에는 셀 선택시 동작이 스토리보드에는 정의되어 있지 않으므로
    // 여기에 코드로 생성함
    // 이렇게 if 로 서치 컨트롤러의 테이블뷰 만 동작하도록 하지 않으면,
    // 그냥 테이블 뷰에서는 2번 호출되는 꼴이 되어서 네이게이션이 2 스탭 들어가게 된다.
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self performSegueWithIdentifier:@"candyDetail" sender:tableView];
    }

}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"candyDetail"]) {
        UIViewController *candyDetailViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSString *destinationTitle = [[_filteredCandyArray objectAtIndex:[indexPath row]] name];
            [candyDetailViewController setTitle:destinationTitle];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSString *destinationTitle = [[_candyArray objectAtIndex:[indexPath row]] name];
            [candyDetailViewController setTitle:destinationTitle];
        }
        
    }
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [_filteredCandyArray removeAllObjects];
    // Filter the array using NSPredicate
    // SELF.name tells the NSPredicate to look at the “name” property of the Candy objects in the candyArray.
    // Candy 객체에서 name 으로 정의된 것과 비교하겠다.
    //“contains[c]” tells the predicate to search the “name” property for the provides text string, which is the search text in this case, in a case-insensitive manner.
    // [c](case insensitive) 라는 뜻.
    // searchText 에 입려되는 스트링을 가지고 [c] 옵션으로 contains 되어 있는지 비교하겠다.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    //_filteredCandyArray = [NSMutableArray arrayWithArray:[_candyArray filteredArrayUsingPredicate:predicate]];
    // searchText 의 입력 비교값과 스코프 값의 비교까지 더해짐.
    NSArray *tempArray = [_candyArray filteredArrayUsingPredicate:predicate];
    if (![scope isEqualToString:@"All"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    _filteredCandyArray = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark - UISearchDisplayController Delegate Methods
// runs the text filtering function whenever the user changes the search string in the search bar
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

// will handle the changes in the Scope Bar input, 이번 연습에서 스코프를 사용하지 않으므로 의미 없음 
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
