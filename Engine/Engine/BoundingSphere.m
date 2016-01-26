#import "BoundingSphere.h"
#import "Engine.Core.h"

@implementation BoundingSphere

@synthesize center, radius;

- (BOOL)intersectsPlane:(Plane *)plane {
	float distance = [Vector3 dotProductOf:plane.normal with:center] + plane.d;
	
	if(distance < -radius || distance > radius) {
		return NO;
	}
	
	return YES;
}

+ (BoundingSphere *)sphereWithRadius:(float)radius {
	return [BoundingSphere sphereWithRadius:radius center:[Vector3 zero]];
}

+ (BoundingSphere *)sphereWithRadius:(float)radius center:(Vector3 *)center {
	BoundingSphere *bs = [[BoundingSphere alloc] init];
	
	bs.center = center;
	bs.radius = radius;
	
	return bs;
}

@end
