#import "PlayerInput.h"
#import "TINR.Glomero.h"

#define JUMP_FORCE 5.0f

@implementation PlayerInput {
	PlayerPhysics *physics;
	SphereCollider *collider;
	
	float startY;
	float flickTime;
	
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
	physics = [node getComponentOfClass:[PlayerPhysics class]];
	collider = [node getComponentOfClass:[SphereCollider class]];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	TouchCollection *touches = [TouchPanel getState];
	
	float third = [Scene getInstance].game.gameWindow.clientBounds.width / 3.0f;
	
	if(touches.count == 1) {
		TouchLocation *touch = [touches objectAtIndex:0];
		
		if(touch.state == TouchLocationStatePressed) {
			startY = touch.position.y;
			flickTime = gameTime.totalGameTime;
		}
		
		if(physics.onGround) {
			if(touch.state == TouchLocationStateReleased) {
				if(gameTime.totalGameTime - flickTime < 0.7f && startY - touch.position.y > 20.0f) {
					collider.velocity.y = JUMP_FORCE;
					[[Glomero getInstance].jumpSound play];
				}
			}
		} else {
			if(touch.state == TouchLocationStateReleased) {
				if(gameTime.totalGameTime - flickTime < 0.7f && startY - touch.position.y < -20.0f) {
					collider.velocity.y = -JUMP_FORCE;
				}
			}
		}
		
		if(touch.position.x < third) {
			vx -= gameTime.elapsedGameTime * 30.0f;
		} else if(touch.position.x > third * 2.0f) {
			vx += gameTime.elapsedGameTime * 30.0f;
		}
	}
	
	collider.velocity.x = vx;
	vx = lerpf(vx, 0.0f, gameTime.elapsedGameTime * 10.0f);
}

@end
