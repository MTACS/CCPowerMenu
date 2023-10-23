#import <Preferences/PSListController.h>
#import <Preferences/PSViewController.h>

@interface NSUserDefaults (CCPowerMenu)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

@interface CCPowerMenuListController : PSViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *itemStates;
@property (nonatomic, strong) NSMutableArray *items;
@end