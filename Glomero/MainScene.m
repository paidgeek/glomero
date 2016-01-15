#import "MainScene.h"
#import "TINR.Glomero.h"

#import "Random.h"
#import "Turret.h"

@implementation MainScene

- (void) loadContent {
	Glomero *glomero = [Glomero getInstance];
	
	const int w = 10;
	const int h = 20;
	BOOL map[w][h];
	
	for(int y = 0; y < h; y++) {
		for (int x = 0; x < w; x++) {
			Node *tileNode = [self createNode];
			SpriteRenderer *tileSr = [tileNode addComponentOfClass:[SpriteRenderer class]];
			tileNode.transform.position = [Vector2 vectorWithX:x*128.0f-64.0f*w	y:-y*128.0f+5*128.0f];
			
			if((x % 4 == 0 && [Random float] < 0.4f) || (y % 3 == 0 && [Random float] < 0.3f) || x == 0 || x == w - 1) {
				tileNode.layer = OBSTACLE_LAYER;
				tileSr.sprite = [glomero.worldAtlas getSpriteWithName:@"stone"];

				RigidBody2D *body = [tileNode addComponentOfClass:[RigidBody2D class]];
				body.collider = [[BoxCollider2D alloc] initWithRigidBody:body];
				body.collider.isTrigger = YES;
				BoxCollider2D *box = (BoxCollider2D *)body.collider;
				
				box.width = 128.0f;
				box.height = 128.0f;
				map[x][y] = YES;
			} else {
				map[x][y] = NO;
				tileSr.sprite = [glomero.worldAtlas getSpriteWithName:@"grass"];
			}
		}
	}
	
	for(int i = 0; i < 30; i++) {
		int x, y;
		do {
			x = [Random intLessThan:w];
			y = [Random intLessThan:h];
		} while(map[x][y]);
		map[x][y] = YES;
		
		Node *coinNode = [self createNode];
		coinNode.layer = COIN_LAYER;
		AnimatedSpriteRenderer *sr = [coinNode addComponentOfClass:[AnimatedSpriteRenderer class]];
		RigidBody2D *body = [coinNode addComponentOfClass:[RigidBody2D class]];
		body.collider = [[CircleCollider2D alloc] initWithRigidBody:body];
		body.collider.isTrigger = YES;
		CircleCollider2D *cc = (CircleCollider2D *) body.collider;
		
		cc.radius = 32.0f;
		
		coinNode.transform.position = [Vector2 vectorWithX:x*128-64.0f*w y:-y*128+5*128.0f];
		
		float duration = 0.25f;
		[sr addFrame:[glomero.worldAtlas getSpriteWithName:@"gold1"] duration:duration];
		[sr addFrame:[glomero.worldAtlas getSpriteWithName:@"gold2"] duration:duration];
		[sr addFrame:[glomero.worldAtlas getSpriteWithName:@"gold3"] duration:duration];
		[sr addFrame:[glomero.worldAtlas getSpriteWithName:@"gold4"] duration:duration];
		
		Sprite *g2 =[glomero.worldAtlas getSpriteWithName:@"gold2"];
		Sprite *g3 = [glomero.worldAtlas getSpriteWithName:@"gold3"];
		
		g2.effects = SpriteEffectsFlipHorizontally;
		g3.effects = SpriteEffectsFlipHorizontally;
		
		[sr addFrame:g3 duration:duration];
		[sr addFrame:g2 duration:duration];
	}
	
	{
		Node *playerNode = [self createNode];
		playerNode.layer = PLAYER_LAYER;
		SpriteRenderer *sr = [playerNode addComponentOfClass:[SpriteRenderer class]];
		Player *player = [playerNode addComponentOfClass:[Player class]];
		player.rigidBody = [playerNode addComponentOfClass:[RigidBody2D class]];
		CircleCollider2D *cc = player.rigidBody.collider = [[CircleCollider2D alloc] initWithRigidBody:player.rigidBody];
		
		cc.radius = 32.0f;
		[player.rigidBody addCollisionListener:player];
		
		player.node.transform.position = [Vector2 vectorWithX:0 y:0];
		sr.sprite = [glomero.entitiesAtlas getSpriteWithName:@"PinkAlien"];
	}
	
	for(int i = 0; i < 4; i++){
		int x, y;
		do {
			x = [Random intLessThan:w];
			y = [Random intGreaterThanOrEqual:10 lessThan:h];
		} while(map[x][y]);
		
		Node *turretNode = [self createNode];
		Node *barrel = [self createNodeWithParent:turretNode];
		SpriteRenderer *sr = [turretNode addComponentOfClass:[SpriteRenderer class]];
		SpriteRenderer *sr2 = [barrel addComponentOfClass:[SpriteRenderer class]];
		
		sr.sprite = [glomero.entitiesAtlas getSpriteWithName:@"Turret"];
		
		sr2.sprite = [glomero.entitiesAtlas getSpriteWithName:@"Barrel"];
		sr2.sprite.pivot = [Vector2 vectorWithX:8.0f y:0.0f];
		
		[turretNode addComponentOfClass:[Turret class]];
		turretNode.transform.position = [Vector2 vectorWithX:x*128-64.0f*w y:-y*128+5*128.0f];
	}
	
	[self.collisionMatrix enableBetweenA:COIN_LAYER b:PLAYER_LAYER];
	[self.collisionMatrix enableBetweenA:PLAYER_LAYER b:OBSTACLE_LAYER];
	[self.collisionMatrix enableBetweenA:BULLET_LAYER b:OBSTACLE_LAYER];
}

@end
