#import "Engine.Core.classes.h"

@interface CollisionMatrix : NSObject

- (BOOL) enabledBetweenA:(int) a b:(int) b;
- (void) enableBetweenA:(int) a b:(int) b;
- (void) disableBetweenA:(int) a b:(int) b;

@end
