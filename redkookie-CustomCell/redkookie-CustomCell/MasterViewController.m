//
//  MasterViewController.m
//  redkookie-CustomCell
//
//  Created by Kim cloody on 12. 12. 24..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "MyCustomCell.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 고정된 높이 설정
    // 모든 cell 이 같은 설정을 갖는다면 추천(빠름)
    // 동적 높이 설정 방법 : http://shkam.tistory.com/113 
    // 다른 방법 및 차이점 : http://intel.tistory.com/2460659 
    self.tableView.rowHeight = 65;
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell 재사용 관련 : http://blog.naver.com/PostView.nhn?blogId=saturna&logNo=60111382669 
    
    static NSString *CellIdentifier = @"MyCustomCell";
    
    MyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MyCustomCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[MyCustomCell class]])
            {
                cell = (MyCustomCell *)currentObject;
                break;
            }
        }
    }

    if(indexPath.row % 4 == 0)
    {
        [[cell authorName] setText:@"Collin Ruffenach"];
        [[cell articleName] setText:@"Test Article 1"];
        [[cell date] setText:@"May 5th, 2009"];
        [[cell imageView] setImage:[UIImage imageNamed:@"1.png"]];
    }
    
    else if(indexPath.row % 4 == 1)
    {
        [[cell authorName] setText:@"Steve Jobs"];
        [[cell articleName] setText:@"Why iPhone will rule the world"];
        [[cell date] setText:@"May 5th, 2010"];
        [[cell imageView] setImage:[UIImage imageNamed:@"2.png"]];
    }
    
    else if(indexPath.row % 4 == 2)
    {
        [[cell authorName] setText:@"The Woz"];
        [[cell articleName] setText:@"Why I’m coming back to Apple"];
        [[cell date] setText:@"May 5th, 2012"];
        [[cell imageView] setImage:[UIImage imageNamed:@"3.png"]];
    }
    else if(indexPath.row % 4 == 3)
    {
        [[cell authorName] setText:@"Aaron Hillegass"];
        [[cell articleName] setText:@"Cocoa: A Brief Introduction"];
        [[cell date] setText:@"May 5th, 2004"];
        [[cell imageView] setImage:[UIImage imageNamed:@"4.png"]];
        
    }
    
    // Configure the cell.
    //cell.textLabel.text = NSLocalizedString(@"Detail", @"Detail");
    
    //cell.textLabel.text = [NSString stringWithFormat:@"I am cell %d", indexPath.row];
    
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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
