#import "CollisionDetection.h"
#import "Engine.Core.h"
#import "Manifold.h"

@interface CollisionDetection ()

+ (Manifold *) collisionBetweenSphere:(SphereCollider *) sphere andAAB:(AABoxCollider *) aab;
+ (Manifold *) collisionBetweenSphere:(SphereCollider *) sphereA andSphere:(SphereCollider *)sphereB;

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
	
	if([a isKindOfClass:[SphereCollider class]] && [b isKindOfClass:[AABoxCollider class]]) {
		manifold = [CollisionDetection collisionBetweenSphere:a andAAB:(AABoxCollider *) b];
	} else if([b isKindOfClass:[SphereCollider class]] && [a isKindOfClass:[AABoxCollider class]]) {
		manifold = [CollisionDetection collisionBetweenSphere:b andAAB:(AABoxCollider *) a];
	} else if([a isKindOfClass:[SphereCollider class]] && [b isKindOfClass:[SphereCollider class]]) {
		manifold = [CollisionDetection collisionBetweenSphere:a andSphere:(SphereCollider *) b];
	}
	
	if(manifold != nil) {
		if(a.dynamic && !b.trigger) {
			if([Vector3 dotProductOf:[Vector3 subtract:b.node.transform.position
																 by:a.node.transform.position]
									  with:a.velocity] > 0.0f) {
			// reflect velocity
			// r = d - 2 * dot(d, n) * n
			Vector3 *d = a.velocity;
			Vector3 *n = [Vector3 negate:manifold.normal];
			Vector3 *r = [Vector3 subtract:d by:[Vector3 multiply:n by:2.0f * [Vector3 dotProductOf:d with:n]]];
				
			// game specific
			a.velocity = [Vector3 vectorWithX:r.x y:0.0f z:r.z];
			}
			
			[a.node.transform.localPosition subtract:[Vector3 multiply:manifold.normal
																							 by:manifold.penetration]];
		}
		if(b.dynamic && !a.trigger) {
			if([Vector3 dotProductOf:[Vector3 subtract:a.node.transform.position
																 by:b.node.transform.position]
									  with:b.velocity] > 0.0f) {
			// reflect velocity
			// r = d - 2 * dot(d, n) * n
			Vector3 *d = b.velocity;
			Vector3 *n = [Vector3 negate:manifold.normal];
			Vector3 *r = [Vector3 subtract:d by:[Vector3 multiply:n by:2.0f * [Vector3 dotProductOf:d with:n]]];
				
			// game specific
			b.velocity = [Vector3 vectorWithX:r.x y:0.0f z:r.z];
			}
			
			[b.node.transform.localPosition subtract:[Vector3 multiply:manifold.normal
																					  by:manifold.penetration]];
		}
		
		Collision *collision = [CollisionDetection findCollisionFor:a and:b];
		
		if(collision == nil) {
			// collision enter
			Collision *collision = [[Collision alloc] initWithNormal:[Vector3 negate:manifold.normal]
																	  thisCollider:manifold.colliderA
																	 otherCollider:manifold.colliderB];
			[collisions addObject:collision];

			if(a.collisionListener != nil) {
				if([a.collisionListener respondsToSelector:@selector(onCollisionEnter:normal:)]) {
					[a.collisionListener onCollisionEnter:b normal:[Vector3 negate:manifold.normal]];
				}
			}
			
			if(b.collisionListener != nil) {
				if([b.collisionListener respondsToSelector:@selector(onCollisionEnter:normal:)]) {
					[b.collisionListener onCollisionEnter:a normal:manifold.normal];
				}
			}
		} else {
			// collision stay
			if(a.collisionListener != nil) {
				if([a.collisionListener respondsToSelector:@selector(onCollisionStay:)]) {
					[a.collisionListener onCollisionStay:b];
				}
			}
			
			if(b.collisionListener != nil) {
				if([b.collisionListener respondsToSelector:@selector(onCollisionStay:)]) {
					[b.collisionListener onCollisionStay:a];
				}
			}
		}
	} else {
		Collision *collision = [CollisionDetection findCollisionFor:a and:b];
		
		if(collision != nil) {
			// collision exit
			if(a.collisionListener != nil) {
				if([a.collisionListener respondsToSelector:@selector(onCollisionExit:)]) {
					[a.collisionListener onCollisionExit:b];
				}
			}
			
			if(b.collisionListener != nil) {
				if([b.collisionListener respondsToSelector:@selector(onCollisionExit:)]) {
					[b.collisionListener onCollisionExit:a];
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

+ (Manifold *)collisionBetweenSphere:(SphereCollider *)sphereA andSphere:(SphereCollider *)sphereB {
	Vector3 *pa = sphereA.node.transform.position;
	Vector3 *pb = sphereB.node.transform.position;
	
	Vector3 *v = [Vector3 subtract:pa by:pb];
	float dst = [v lengthSquared];
	float r = sphereA.radius + sphereB.radius;
	
	if(dst <= r * r) {
		Manifold *manifold = [[Manifold alloc] init];
		
		manifold.normal = [v normalize];
		manifold.penetration = sqrtf(dst);
		
		manifold.colliderA = sphereA;
		manifold.colliderB = sphereB;
		
		return manifold;
	}
	
	return nil;
}

@end
