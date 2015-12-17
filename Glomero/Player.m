#import "Player.h"
#import "TINR.Glomero.h"

@implementation Player

static Player *instance;

@synthesize node, rigidBody;

- (id) initWithNode:(Node *) theNode {
	self = [super init];
	
	if(self) {
		instance = self;
		
		node = theNode;
	}
	
	return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	TouchCollection *touches = [[TouchPanel getInstance] getState];
	
	for(TouchLocation *touch in touches) {
		float dx = (touch.position.x - 320.0f) * 0.05f;
		
		[rigidBody.velocity add:[Vector2 vectorWithX:dx y:0.0f]];
	}
	
	rigidBody.velocity.y = -150.0f;
	
	Transform *camera = [Scene getInstance].mainCamera.node.transform;
	[camera.position set:[Vector2 lerp:camera.position
											  to:[Vector2 vectorWithX:node.transform.position.x
																			y:node.transform.position.y - 200.0f]
											  by:gameTime.elapsedGameTime * 5.0f]];
}

- (void) onTriggerEnter:(RigidBody2D *)otherRigidBody {
	[[Scene getInstance] destroyNode:otherRigidBody.node];
}

+ (Player *)getInstance {
	return instance;
}

@end
