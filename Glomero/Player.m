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
		float dx = (touch.position.x - [Scene getInstance].game.gameWindow.clientBounds.width / 2.0f) * 0.1f;
		
		[rigidBody.velocity add:[Vector2 vectorWithX:dx y:0.0f]];
	}

	rigidBody.velocity.y = -150;
	[Scene getInstance].mainCamera.node.transform.position = node.transform.position;
}

- (void) onTriggerEnter:(RigidBody2D *)otherRigidBody {
	if(otherRigidBody.node.layer == OBSTACLE_LAYER) {
		[[Glomero getInstance].explosionSound play];
		[[Glomero getInstance] enterScene:[MainMenu class]];
	} else {
		[[Glomero getInstance].coinSound play];
		[[Scene getInstance] destroyNode:otherRigidBody.node];
	}
}

+ (Player *)getInstance {
	return instance;
}

@end
