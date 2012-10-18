/*
 This module is licenced under the BSD license.

 Copyright (C) 2011 by raw engineering <nikhil.jain (at) raweng (dot) com, reefaq.mohammed (at) raweng (dot) com>.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
//
//  MenuViewController.m
//  StackScrollView
//
//  Created by Reefaq on 2/24/11.
//  Copyright 2011 raw engineering . All rights reserved.
//

#import "MenuViewController.h"
#import "DataViewController.h"
#import "StackScrollViewAppDelegate.h"
#import "RootViewController.h"
#import "StackScrollViewController.h"
#import "MenuTableViewCell.h"
#import "MenuHeaderView.h"
#import "MenuWatermarkFooter.h"

#define kCellText @"CellText"
#define kCellImage @"CellImage"

@implementation MenuViewController
@synthesize tableView = _tableView;

#pragma mark -
#pragma mark View lifecycle

- (id)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
		[self.view setFrame:frame];

		_menuHeader = [[MenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
		_menuHeader.imageView.image = [UIImage imageNamed:@"avatar.png"];
		_menuHeader.textLabel.text = @"cocoacontrols";

		_cellContents = [[NSMutableArray alloc] init];
		[_cellContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"08-chat.png"], kCellImage, NSLocalizedString(@"Timeline",@""), kCellText, nil]];
		[_cellContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"22-skull-n-bones.png"], kCellImage, NSLocalizedString(@"Mentions",@""), kCellText, nil]];
		[_cellContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"22-skull-n-bones.png"], kCellImage, NSLocalizedString(@"Lists",@""), kCellText, nil]];
		[_cellContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"18-envelope.png"], kCellImage, NSLocalizedString(@"Messages",@""), kCellText, nil]];
		[_cellContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"111-user.png"], kCellImage, NSLocalizedString(@"Profile",@""), kCellText, nil]];
		[_cellContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"06-magnify.png"], kCellImage, NSLocalizedString(@"Search",@""), kCellText, nil]];

		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.backgroundColor = [UIColor clearColor];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.tableFooterView = [[[MenuWatermarkFooter alloc] initWithFrame:CGRectMake(0, 0, 200, 80)] autorelease];
		[self.view addSubview:_tableView];
	}
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_cellContents count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	cell.textLabel.text = [[_cellContents objectAtIndex:indexPath.row] objectForKey:kCellText];
	cell.imageView.image = [[_cellContents objectAtIndex:indexPath.row] objectForKey:kCellImage];

	cell.glowView.hidden = indexPath.row != 3;

    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return _menuHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataViewController *dataViewController = [[DataViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height) squareCorners:NO];
	[[StackScrollViewAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:dataViewController invokeByController:self isStackStartView:TRUE];
	[dataViewController release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {

	[_menuHeader release];
	[_cellContents release];
    [_tableView release];
    [super dealloc];
}


@end

