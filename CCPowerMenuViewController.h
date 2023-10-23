#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <objc/runtime.h>
#import <substrate.h>
#import "spawn.h"
#include <rootless.h>
#include <sys/sysctl.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.width
#define preferences [[NSUserDefaults standardUserDefaults] initWithSuiteName:@"com.mtac.ccpowermenu"]

static NSString *domain = @"com.mtac.ccpowermenu";

typedef struct CCUILayoutSize {
	unsigned long long width;
	unsigned long long height;
} CCUILayoutSize;

@interface NSUserDefaults (CCPowerMenu)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

@interface UIActivityIndicatorView (CCPowerMenu)
@property (retain, nonatomic) UIColor *color;
@end

@interface CCUIButtonModuleView : UIControl
@property (retain, nonatomic) UIImage *glyphImage;
@end

@interface CCUIButtonModuleViewController : UIViewController
@property (retain, nonatomic) UIImage *glyphImage;
@property (retain, nonatomic) UIColor *glyphColor;
@property (retain, nonatomic) UIImage *selectedGlyphImage;
@property (readonly, nonatomic) CCUIButtonModuleView *buttonView;
@end

@interface CCUIMenuModuleViewController : CCUIButtonModuleViewController {
    NSMutableArray *_menuItems;
}
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *title;
@property (readonly, nonatomic) BOOL hasFooterButton;
@property (readonly, nonatomic) BOOL hasGlyph;
- (void)addActionWithTitle:(id)arg0 glyph:(id)arg1 handler:(id)arg2;
- (void)addActionWithTitle:(id)arg0 subtitle:(id)arg1 glyph:(id)arg2 handler:(id)arg3;
- (void)setMenuItems:(id)arg0;
- (void)removeAllActions;
@end

@interface CCUIMenuModuleItem : NSObject
@property (copy, nonatomic) NSString *identifier;
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *title;
- (id)initWithTitle:(id)arg0 identifier:(id)arg1 handler:(id)arg2;
- (BOOL)performAction;
@end

@protocol CCUIContentModuleContentViewController <NSObject>
@end

@protocol CCUIContentModule <NSObject>
@end

@interface CCPowerMenuButtonController: UIViewController
- (void)setModuleSize:(UISegmentedControl *)control;
@end

@interface CCPowerMenuViewController : CCUIMenuModuleViewController
@property (nonatomic, readonly) CGFloat preferredExpandedContentHeight;
@property (nonatomic, readonly) CGFloat preferredExpandedContentWidth;
@property (nonatomic, readonly) BOOL expanded;
@property (nonatomic, strong) UIActivityIndicatorView *spinnerIndicatorView;
@end

@interface FBSystemService : NSObject
+ (id)sharedInstance;
- (void)shutdownAndReboot:(BOOL)arg0;
@end