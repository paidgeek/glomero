#import "Turret.h"
#import "TINR.Glomero.h"
#import "Bullet.h"

@interface Turret ()

- (void) fireAt:(Vector2 *) dir;

@end

@implementation Turret {
	Node *barrel;
	float cooldown, burst;
	int burstCount;
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
	barrel = [node.children objectAtIndex:0];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	Vector2 *dir = [Vector2 subtract:[Player getInstance].node.transform.position by:node.transform.position];
	float d = [dir length];
	dir = [dir normalize];
	
	barrel.transform.rotation = [Quaternion axis:[Vector3 backward] angle:atan2f(dir.y, dir.x)-M_PI/2.0f];
	cooldown -= gameTime.elapsedGameTime;
	burst -= gameTime.elapsedGameTime;
	
	if(d < 500.0f && cooldown <= 0.0f) {
		if(burst <= 0.0f) {
			[self fireAt:dir];
			
			burst = 0.08f;
			burstCount++;
			
			if(burstCount == 3) {
				burstCount = 0;
				cooldown = 1.0f;
			}
		}
	}
}

- (void)fireAt:(Vector2 *)dir {
	Node *bulletNode = [[Scene getInstance] createNode];
	bulletNode.layer = BULLET_LAYER;
	SpriteRenderer *sr = [bulletNode addComponentOfClass:[SpriteRenderer class]];
	RigidBody2D *body = [bulletNode addComponentOfClass:[RigidBody2D class]];
	body.collider = [[CircleCollider2D alloc] initWithRigidBody:body];
	CircleCollider2D *cc = (CircleCollider2D *) body.collider;
	//cc.isTrigger = YES;
	
	cc.radius = 8.0f;
	
	sr.sprite = [[Glomero getInstance].entitiesAtlas getSpriteWithName:@"Bullet"];

	Bullet *bullet = [bulletNode addComponentOfClass:[Bullet class]];
	[body addCollisionListener:bullet];
	bullet.direction = dir;
	[bulletNode.transform.position set:node.transform.position];
	[bulletNode.transform.rotation set:[Quaternion axis:[Vector3 backward] angle:atan2f(dir.y, dir.x)+M_PI/2.0f]];
	
	[[Glomero getInstance].shootSound play];
}

@end
