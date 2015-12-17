#import "Engine.Core.classes.h"

@interface Transform : NSObject<INodeComponent, IPosition, IRotation>

- (void) translate:(Vector2 *) translation;
- (void) translateX:(float) x y:(float) y;
- (void) rotateZ:(float) z;

- (Vector2 *) getWorldPosition;

@property (nonatomic, strong) Vector2 *position;
@property (nonatomic, strong) Quaternion *rotation;

@end
