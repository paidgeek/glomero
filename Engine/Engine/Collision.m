#import "Collision.h"
#import "Engine.Core.h"
#import "Manifold.h"

@interface Collision ()

+ (Manifold *) collisionBetweenSphere:(SphereCollider *) sphere andAAB:(AABoxCollider *) aab;

@end

@implementation Collision

+ (BOOL)detectCollisionBetween:(id<IColliderComponent>)a and:(id<IColliderComponent>)b {
	if([a isKindOfClass:[SphereCollider class]] && [b isKindOfClass:[AABoxCollider class]]) {
		return [Collision collisionBetweenSphere:(SphereCollider *) a andAAB:(AABoxCollider *) b] != nil;
	}
	
	if([b isKindOfClass:[SphereCollider class]] && [a isKindOfClass:[AABoxCollider class]]) {
		return [Collision collisionBetweenSphere:(SphereCollider *) b andAAB:(AABoxCollider *) a] != nil;
	}
	
	return NO;
}

+ (void)resolveCollisionBetween:(id<IColliderComponent>)a and:(id<IColliderComponent>)b {
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
		if([Vector3 dotProductOf:[Vector3 subtract:b.node.transform.position by:a.node.transform.position] with:a.velocity] > 0.001f) {
			// reflect velocity
			// r = d - 2 * dot(d, n) * n
			Vector3 *d = sphere.velocity;
			Vector3 *n = [Vector3 negate:manifold.normal];
			Vector3 *r = [Vector3 subtract:d by:[Vector3 multiply:n by:2.0f * [Vector3 dotProductOf:d with:n]]];
		
			/*
			// temp coefficient of restitution
			const float e = 1.0f;
			
			sphere.velocity = [r multiplyBy:e];
			*/

			/*
			if(fabsf(n.x) > 0.5f) {
				r.x = 0.0f;
			}
			
			if(fabsf(n.y) > 0.5f) {
				r.y = 0.0f;
			}
			
			if(fabs(n.z) > 0.5f) {
				r.z = 0.0f;
			}
			*/
			
			sphere.velocity = [Vector3 vectorWithX:r.x y:0.0f z:r.z];
			
			// game specific!
			//sphere.velocity = [Vector3 vectorWithX:r.x * (1.0f - fabsf(n.x)) y:0.0f z:r.z * (1.0f - fabsf(n.z))];
		}
		
		[sphere.node.transform.localPosition subtract:[Vector3 multiply:manifold.normal by:manifold.penetration]];
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
