#import "PlayerInput.h"
#import "TINR.Glomero.h"

@implementation PlayerInput {
	SphereCollider *collider;
	float vx;
}

@synthesize node;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if (self) {
		node = theNode;
	}
	
	return self;
}

- (void)onAdd {
	collider = [node getComponentOfClass:[SphereCollider class]];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	TouchCollection *touches = [TouchPanel getState];
	
	if(touches.count == 1) {
		TouchLocation *touch = [touches objectAtIndex:0];
		
		float dx = [Scene getInstance].game.gameWindow.clientBounds.width / 2.0f - touch.position.x;
		
		if(dx < 0.0f) {
			vx = 2;
		} else {
			vx = -2;
		}
	}
	
	collider.velocity.x = vx;
	vx = lerpf(vx, 0.0f, gameTime.elapsedGameTime * 5.0f);
}

@end
