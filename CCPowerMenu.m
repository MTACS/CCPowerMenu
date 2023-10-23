#import "CCPowerMenu.h"
#import "CCPowerMenuViewController.h"

@implementation CCPowerMenu
- (instancetype)init {
    self = [super init];
    if (self) {
        _contentViewController = [[CCPowerMenuViewController alloc] init];
	}
    return self;
}
- (CCUILayoutSize)moduleSizeForOrientation:(int)orientation {
    return (CCUILayoutSize){1, 1};
}
@end

void reloadItems(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ccpowermenu/ReloadItems" object:nil];
}

__attribute__((constructor))
static void init(void) {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, reloadItems, CFSTR("com.mtac.ccpowermenu/ReloadItems"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}