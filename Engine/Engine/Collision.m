#import "Collision.h"
#import "Engine.Core.h"
#import "Manifold.h"

@interface Collision ()

+ (Manifold *) collisionBetweenSphere:(SphereCollider *) sphere andAAB:(AABoxCollider *) aab;

@end

@implementation Collision

+ (BOOL)detectCollisionBetween:(id)a and:(id)b {
	if([a isKindOfClass:[SphereCollider class]] && [b isKindOfClass:[AABoxCollider class]]) {
		return [Collision collisionBetweenSphere:(SphereCollider *) a andAAB:(AABoxCollider *) b] != nil;
	}
	
	if([b isKindOfClass:[SphereCollider class]] && [a isKindOfClass:[AABoxCollider class]]) {
		return [Collision collisionBetweenSphere:(SphereCollider *) b andAAB:(AABoxCollider *) a] != nil;
	}
	
	return NO;
}

+ (void)resolveCollisionBetween:(id)a and:(id)b {
	Manifold *manifold = nil;
	SphereCollider *sphere;
	
	if([a isKindOfClass:[SphereCollider class]] && [b isKindOfClass:[AABoxCollider class]]) {
		sphere = (SphereCollider *) a;
		manifold = [Collision collisionBetweenSphere:sphere andAAB:(AABoxCollider *) b];
	} else if([b isKindOfClass:[SphereCollider class]] && [a isKindOfClass:[AABoxCollider class]]) {
		sphere = (SphereCollider *) b;
		manifold = [Collision collisionBetweenSphere:sphere andAAB:(AABoxCollider *) a];
	}
	
	if(manifold != nil) {
		[sphere.node.transform.localPosition add:[Vector3 multiply:manifold.normal by:-manifold.penetration]];
		
		// reflect velocity
		// r = d - 2 * dot(d, n) * n
		Vector3 *d = [Vector3 negate:sphere.velocity];
		Vector3 *n = [Vector3 negate:manifold.normal];
		Vector3 *r = [Vector3 subtract:d by:[Vector3 multiply:n by:2.0f * [Vector3 dotProductOf:d with:n]]];
		
		sphere.velocity = [Vector3 vectorWithX:r.x * (1.0f - fabsf(n.x)) y:r.y * (1.0f - fabsf(n.y)) z:r.z * (1.0f - fabsf(n.z))];
	}
}

+ (Manifold *) collisionBetweenSphere:(SphereCollider *) sphere andAAB:(AABoxCollider *) aab {
	Vector3 *center = sphere.node.transform.position;
	Vector3 *p = [aab closestPointTo:center];
	
	Vector3 *v = [Vector3 subtract:p by:center];
	float dst = [v lengthSquared];
	
	if(dst <= sphere.radius * sphere.radius) {
		Manifold *manifold = [[Manifold alloc] init];
		
		manifold.normal = [v normalize];
		manifold.penetration = sphere.radius - sqrtf(dst);
		
		return manifold;
	}
	
	return nil;
}

@end
