#import "Engine.Core.classes.h"

@protocol ICollisionListener <NSObject>

@optional
- (void) onCollisionEnter:(Collision *) collision;
- (void) onCollisionStay:(Collision *) collision;
- (void) onCollisionExit:(Collision *) collision;

@end
