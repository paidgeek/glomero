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
	collider.radius = 0.5f;
	collider.collisionListener = self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[node.transform translate:[Vector3 multiply:collider.velocity
														  by:gameTime.elapsedGameTime]
						relativeTo:SpaceWorld];
	[node.transform rotateAround:[Vector3 vectorWithX:-collider.velocity.z y:0 z:collider.velocity.x]
									  by:2.0f * M_PI * collider.radius * gameTime.elapsedGameTime
							relativeTo:SpaceSelf];
	
	if(node.transform.position.y < -1.0f) {
		[[GamePlay getInstance] endGame];
		
		return;
	}
	
	collider.velocity.z = -gamePlay.speed;
	
	if(!onGround) {
		collider.velocity.y -= gameTime.elapsedGameTime * 7.0f;
	}
}

- (void)onCollisionStay {
	onGround = YES;
}

- (void)onCollisionEnter:(Collision *)collision {
	onGround = YES;
}

- (void)onCollisionExit:(Collision *)collision {
	onGround = NO;
}

@end
