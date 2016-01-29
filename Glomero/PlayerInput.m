#import "PlayerInput.h"
#import "TINR.Glomero.h"

#define JUMP_FORCE 4.0f

@implementation PlayerInput {
	PlayerPhysics *physics;
	SphereCollider *collider;
	
	float startY;
	float flickTime;
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
	physics = [node getComponentOfClass:[PlayerPhysics class]];
	collider = [node getComponentOfClass:[SphereCollider class]];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	TouchCollection *touches = [TouchPanel getState];
	
	float third = [Scene getInstance].game.gameWindow.clientBounds.width / 3.0f;
	
	if(touches.count == 1) {
		TouchLocation *touch = [touches objectAtIndex:0];
		
		if(physics.onGround) {
			if(touch.state == TouchLocationStatePressed) {
				startY = touch.position.y;
				flickTime = gameTime.totalGameTime;
			} else if(touch.state == TouchLocationStateReleased) {
				if(gameTime.totalGameTime - flickTime < 0.5f && startY - touch.position.y > 50.0f) {
					collider.velocity.y = JUMP_FORCE;
				}
			}
		}
		
		if(touch.position.x < third) {
			collider.velocity.x -= gameTime.elapsedGameTime * 10.0f;
		} else if(touch.position.x > third * 2.0f) {
			collider.velocity.x += gameTime.elapsedGameTime * 10.0f;
		}
	}
}

@end
