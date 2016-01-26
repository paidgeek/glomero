#import "PlayerPhysics.h"
#import "TINR.Glomero.h"

@implementation PlayerPhysics

@synthesize node, velocity, sphere;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		velocity = [Vector3 vectorWithX:0 y:0 z:-6.0f];
		sphere = [BoundingSphere sphereWithRadius:0.5f];
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[node.transform translate:[Vector3 multiply:velocity
														  by:gameTime.elapsedGameTime]
						relativeTo:SpaceWorld];
	[node.transform rotateAround:[Vector3 vectorWithX:-velocity.z y:0 z:velocity.x]
									  by:2.0f * M_PI * sphere.radius * gameTime.elapsedGameTime
							relativeTo:SpaceSelf];
}

@end
