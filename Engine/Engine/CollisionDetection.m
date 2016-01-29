#import "CollisionDetection.h"
#import "Engine.Core.h"
#import "Manifold.h"

@interface CollisionDetection ()

+ (Manifold *) collisionBetweenSphere:(SphereCollider *) sphere andAAB:(AABoxCollider *) aab;
+ (Collision *) findCollisionFor:(id<IColliderComponent>) colliderA and:(id<IColliderComponent>) colliderB;

@end

@implementation CollisionDetection

static NSMutableArray *collisions;

+ (void)init {
	collisions = [NSMutableArray array];
}

+ (BOOL)detectCollisionBetween:(id<IColliderComponent>)a and:(id<IColliderComponent>)b {
	if([a isKindOfClass:[SphereCollider class]] && [b isKindOfClass:[AABoxCollider class]]) {
		return [CollisionDetection collisionBetweenSphere:(SphereCollider *) a andAAB:(AABoxCollider *) b] != nil;
	}
	
	if([b isKindOfClass:[SphereCollider class]] && [a isKindOfClass:[AABoxCollider class]]) {
		return [CollisionDetection collisionBetweenSphere:(SphereCollider *) b andAAB:(AABoxCollider *) a] != nil;
	}
	
	return NO;
}

+ (void)resolveCollisionBetween:(id<IColliderComponent>)a and:(id<IColliderComponent>)b {
	Manifold *manifold = nil;
	SphereCollider *sphere;
	
	if([a isKindOfClass:[SphereCollider class]] && [b isKindOfClass:[AABoxCollider class]]) {
		sphere = (SphereCollider *) a;
		manifold = [CollisionDetection collisionBetweenSphere:sphere andAAB:(AABoxCollider *) b];
	} else if([b isKindOfClass:[SphereCollider class]] && [a isKindOfClass:[AABoxCollider class]]) {
		sphere = (SphereCollider *) b;
		manifold = [CollisionDetection collisionBetweenSphere:sphere andAAB:(AABoxCollider *) a];
	}
	
	if(manifold != nil) {
		if([Vector3 dotProductOf:[Vector3 subtract:b.node.transform.position by:a.node.transform.position] with:a.velocity] > 0.0f) {
			// reflect velocity
			// r = d - 2 * dot(d, n) * n
			Vector3 *d = sphere.velocity;
			Vector3 *n = [Vector3 negate:manifold.normal];
			Vector3 *r = [Vector3 subtract:d by:[Vector3 multiply:n by:2.0f * [Vector3 dotProductOf:d with:n]]];
		
			// game specific
			sphere.velocity = [Vector3 vectorWithX:r.x y:0.0f z:r.z];
		}
		
		[sphere.node.transform.localPosition subtract:[Vector3 multiply:manifold.normal
																						 by:manifold.penetration]];
		
		Collision *collision = [CollisionDetection findCollisionFor:a and:b];
		
		if(collision == nil) {
			// collision enter
			Collision *collision = [[Collision alloc] initWithNormal:manifold.normal
																	  thisCollider:manifold.colliderA
																	 otherCollider:manifold.colliderB];
			[collisions addObject:collision];

			if(a.collisionListener != nil) {
				if([a.collisionListener respondsToSelector:@selector(onCollisionEnter:)]) {
					[a.collisionListener onCollisionEnter:collision];
				}
			}
			
			if(b.collisionListener != nil) {
				if([b.collisionListener respondsToSelector:@selector(onCollisionEnter:)]) {
					[b.collisionListener onCollisionEnter:collision];
				}
			}
		} else {
			// collision stay
			if(a.collisionListener != nil) {
				if([a.collisionListener respondsToSelector:@selector(onCollisionStay)]) {
					[a.collisionListener onCollisionStay];
				}
			}
			
			if(b.collisionListener != nil) {
				if([b.collisionListener respondsToSelector:@selector(onCollisionStay)]) {
					[b.collisionListener onCollisionStay];
				}
			}
		}
	} else {
		Collision *collision = [CollisionDetection findCollisionFor:a and:b];
		
		if(collision != nil) {
			// collision exit
			if(a.collisionListener != nil) {
				if([a.collisionListener respondsToSelector:@selector(onCollisionExit:)]) {
					[a.collisionListener onCollisionExit:collision];
				}
			}
			
			if(b.collisionListener != nil) {
				if([b.collisionListener respondsToSelector:@selector(onCollisionExit:)]) {
					[b.collisionListener onCollisionExit:collision];
				}
			}
			
			[collisions removeObject:collision];
		}
	}
}

+ (Collision *)findCollisionFor:(id<IColliderComponent>)colliderA and:(id<IColliderComponent>)colliderB {
	for(Collision *collision in collisions) {
		if(collision.thisCollider == colliderA && collision.otherCollider == colliderB) {
			return collision;
		} else if(collision.otherCollider == colliderA && collision.thisCollider == colliderB) {
			return collision;
		}
	}
	
	return nil;
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
		
		manifold.colliderA = sphere;
		manifold.colliderB = aab;
		
		return manifold;
	}
	
	return nil;
}

@end
