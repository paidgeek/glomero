#import "Engine.Core.classes.h"

@protocol ICollisionListener <NSObject>

@optional
- (void) onCollisionEnter:(Collision *) collision;
- (void) onCollisionStay;
- (void) onCollisionExit:(Collision *) collision;

@end
