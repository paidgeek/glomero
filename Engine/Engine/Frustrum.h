#import "Engine.Core.classes.h"

@interface Frustrum : NSObject

- (BOOL) intersectsSphere:(BoundingSphere *) sphere;
- (BOOL) intersectsPoint:(Vector3 *) point;

@property (nonatomic, strong) Matrix *matrix;

@end
