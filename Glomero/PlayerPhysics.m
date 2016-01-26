#import "PlayerPhysics.h"
#import "TINR.Glomero.h"

@implementation PlayerPhysics

@synthesize node, velocity;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		velocity = [Vector3 vectorWithX:0 y:0 z:-4.0f];
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[node.transform translate:[Vector3 multiply:velocity by:gameTime.elapsedGameTime]];
	//[node.transform rotateAround:[Vector3 left] by:velocity.z * gameTime.elapsedGameTime relativeTo:SpaceWorld];
}

@end
