#import "Player.h"
#import "TINR.Glomero.h"

@implementation Player

@synthesize node, rigidBody;

- (id) initWithNode:(Node *) theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	TouchCollection *touches = [[TouchPanel getInstance] getState];
	
	for(TouchLocation *touch in touches) {
		float dx = (touch.position.x - node.transform.position.x) * 0.2f;
		float dy = (touch.position.y - node.transform.position.y) * 0.2f;
		
		[rigidBody.velocity add:[Vector2 vectorWithX:dx y:dy]];
		
		[Scene getInstance].mainCamera.node.transform.position = touch.position;
	}
}

- (void) onTriggerEnter:(RigidBody2D *)otherRigidBody {
	[[Scene getInstance] destroyNode:otherRigidBody.node];
}

@end
