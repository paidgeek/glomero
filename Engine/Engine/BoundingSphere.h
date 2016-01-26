#import "Engine.Core.classes.h"

@interface BoundingSphere : NSObject

- (BOOL) intersectsPlane:(Plane *) plane;

@property (nonatomic, strong) Vector3 *center;
@property (nonatomic) float radius;

+ (BoundingSphere *) sphereWithRadius:(float) radius;
+ (BoundingSphere *) sphereWithRadius:(float) radius center:(Vector3 *) center;

@end
