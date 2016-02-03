#import "PlayerPhysics.h"
#import "TINR.Glomero.h"

@implementation PlayerPhysics {
	SphereCollider *collider;
	GamePlay *gamePlay;
}

@synthesize node, onGround;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		gamePlay = [GamePlay getInstance];
	}
	
	return self;
}

- (void)onAdd {
	collider = [node getComponentOfClass:[SphereCollider class]];
	collider.dynamic = YES;
	collider.radius = 0.45f;
	collider.collisionListener = self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[node.transform rotateAround:[Vector3 vectorWithX:-collider.velocity.z y:0 z:collider.velocity.x]
									  by:2.0f * M_PI * collider.radius * gameTime.elapsedGameTime
							relativeTo:SpaceSelf];
	
	if(node.transform.position.y < -1.0f) {
		[gamePlay endGame];
		
		return;
	}
	
	collider.velocity.z = -gamePlay.speed;
	
	if(!onGround) {
		collider.velocity.y -= gameTime.elapsedGameTime * 12.0f;
	}
}

- (void)onCollisionStay:(id<IColliderComponent>) otherCollider {
	if(![otherCollider.node.tag isEqualToString:@"Coin"]) {
		onGround = YES;
	}
}

- (void)onCollisionEnter:(id<IColliderComponent>) otherCollider normal:(Vector3 *)normal {
	if([otherCollider.node.tag isEqualToString:@"Coin"]) {
		gamePlay.score += 10;
		
		[[Scene getInstance] destroyNode:otherCollider.node];
		[[Glomero getInstance].coinSound play];
	} else {
		onGround = YES;
		
		if(normal.z > 0.5f || normal.z < -0.5f) {
			[[Glomero getInstance].explosionSound play];
			[gamePlay endGame];
		}
	}
}

- (void)onCollisionExit:(id<IColliderComponent>) otherCollider {
	if(![otherCollider.node.tag isEqualToString:@"Coin"]) {
		onGround = NO;
	}
}

@end
