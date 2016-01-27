#import "Engine.Core.classes.h"

@interface AABoxCollider : NSObject<IColliderComponent>

- (Vector3 *) closestPointTo:(Vector3 *) point;

@property (nonatomic, strong) Vector3 *min;
@property (nonatomic, strong) Vector3 *max;

@end
