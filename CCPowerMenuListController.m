#include "CCPowerMenuListController.h"

static NSString *domain = @"com.mtac.ccpowermenu";
NSUserDefaults *preferences;

@implementation CCPowerMenuListController
- (id)init {
	self = [super init];
	if (self) {
		preferences = [NSUserDefaults standardUserDefaults];
	}
	return self;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView = [[UITableView alloc] initWithFrame:self.viewIfLoaded.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
	self.tableView.separatorColor = nil;
    [self.view addSubview:self.tableView];

	[self.tableView setEditing:YES];
}
- (void)loadView {
	[super loadView];
	[self updateList];
	self.title = @"CCPowerMenu";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2 {
	return 60.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger rows = 0;
	if (section == 0) {
		rows = 5;
	} else if (section == 1) {
		rows = 0;
	}
	return rows;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	NSString *itemIdentifier = self.items[sourceIndexPath.row];
	[self.items removeObjectAtIndex:sourceIndexPath.row];
	[self.items insertObject:itemIdentifier atIndex:destinationIndexPath.row];
	[preferences setObject:self.items forKey:@"itemOrder" inDomain:domain];
	[self.tableView reloadData];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"com.mtac.ccpowermenu/ReloadItems", nil, nil, true);
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
- (void)updateList {
	if (![preferences objectForKey:@"itemOrder" inDomain:domain]) {
		self.items = [[NSArray arrayWithObjects:@"respring", @"safemode", @"userspace", @"reboot", @"shutdown", nil] mutableCopy];
	} else {
		self.items = [[preferences objectForKey:@"itemOrder" inDomain:domain] mutableCopy];
	}

	if (![preferences objectForKey:@"itemStates" inDomain:domain]) {
		self.itemStates = [[NSMutableDictionary alloc] init];
		[self.itemStates setObject:@YES forKey:@"respring"];
		[self.itemStates setObject:@YES forKey:@"safemode"];
		[self.itemStates setObject:@YES forKey:@"userspace"];
		[self.itemStates setObject:@YES forKey:@"reboot"];
		[self.itemStates setObject:@YES forKey:@"shutdown"];
	} else {
		self.itemStates = [[preferences objectForKey:@"itemStates" inDomain:domain] mutableCopy];
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}

	NSString *title;

	UIListContentConfiguration *content = [cell defaultContentConfiguration];
	[content.textProperties setAdjustsFontSizeToFitWidth:YES];

	NSString *itemType = self.items[indexPath.row];
	if ([itemType isEqualToString:@"respring"]) {
		title = @"Respring";
	} else if ([itemType isEqualToString:@"safemode"]) {
		title = @"Safe Mode";
	} else if ([itemType isEqualToString:@"userspace"]) {
		title = @"Reboot Userspace";
	} else if ([itemType isEqualToString:@"reboot"]) {
		title = @"Restart";
	} else if ([itemType isEqualToString:@"shutdown"]) {
		title = @"Shut Down";
	} 
	
	[content setText:title];
	[cell setContentConfiguration:content];

	UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
	switchView.onTintColor = [UIColor systemBlueColor];
	switchView.tag = indexPath.row;
	[switchView addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
	[switchView setOn:[[self.itemStates objectForKey:[self.items objectAtIndex:indexPath.row]] boolValue] animated:NO];
	
	cell.editingAccessoryView = switchView;
	return cell;
}
- (void)updateSwitchAtIndexPath:(UISwitch *)switchView {
	int cellIndex = switchView.tag;
	NSString *item = [self.items objectAtIndex:cellIndex];
	[self.itemStates setObject:@(switchView.isOn) forKey:item];
	[preferences setObject:self.itemStates forKey:@"itemStates" inDomain:domain];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"com.mtac.ccpowermenu/ReloadItems", nil, nil, true);
}
- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
		return 50;
	}
	return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	if (section == 1) {
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2) - 100, 0, 200, 100)];
		titleLabel.numberOfLines = 2;
		titleLabel.textColor = [UIColor secondaryLabelColor];
		titleLabel.textAlignment = NSTextAlignmentCenter;
		
		NSString *primary = @"CCPowerMenu";
		NSString *secondary = @"v1.0.1 © MTAC";

		NSMutableAttributedString *final = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", primary, secondary]];
		[final addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold] range:[final.string rangeOfString:primary]];
		[final addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] range:[final.string rangeOfString:secondary]];

		titleLabel.attributedText = final;
		return titleLabel;
	}
	return nil;
}
@end