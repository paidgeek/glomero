#import "PlayerPhysics.h"
#import "TINR.Glomero.h"

@implementation PlayerPhysics {
	SphereCollider *collider;
}

@synthesize node;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

- (void)onAdd {
	collider = [node getComponentOfClass:[SphereCollider class]];
	collider.radius = 0.5f;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[node.transform translate:[Vector3 multiply:collider.velocity
														  by:gameTime.elapsedGameTime]
						relativeTo:SpaceWorld];
	[node.transform rotateAround:[Vector3 vectorWithX:-collider.velocity.z y:0 z:collider.velocity.x]
									  by:2.0f * M_PI * collider.radius * gameTime.elapsedGameTime
							relativeTo:SpaceSelf];
	
	collider.velocity.z = -4.0f;
	collider.velocity.y -= gameTime.elapsedGameTime * 9.81f;
}

@end
