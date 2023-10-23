#import "CCPowerMenuViewController.h"

@interface NSUserDefaults (CCPowerMenu)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

@interface CCPowerMenu : NSObject <CCUIContentModule>
@property (nonatomic, readonly) CCPowerMenuViewController *contentViewController;
@property (readonly, nonatomic) UIViewController *backgroundViewController;
@property (nonatomic, retain) NSString *settingsIdentifier;
@end