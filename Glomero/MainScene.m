#import "MainScene.h"
#import "TINR.Glomero.h"

@implementation MainScene

@synthesize worldAtlas, entitiesAtlas;

- (void) loadContent {
	worldAtlas = [TextureAtlas loadWithContentManager:self.game.content
														 atlasName:@"World"];
	entitiesAtlas = [TextureAtlas loadWithContentManager:self.game.content
															 atlasName:@"Entities"];
	
	for(int y = 0; y < 30; y++) {
		for (int x = 0; x < 12; x++) {
			Node *tileNode = [self createNode];
			SpriteRenderer *tileSr = [tileNode addComponentOfClass:[SpriteRenderer class]];
			tileNode.transform.position = [Vector2 vectorWithX:x*128.0f - 640.0f	y:-y*128.0f + 512.0f];
			
			tileSr.sprite = [worldAtlas getSpriteWithName:@"grass"];
		}
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

		sr.sprite = [entitiesAtlas getSpriteWithName:@"PinkAlien"];
	}
	
	[self.collisionMatrix enableBetweenA:COIN_LAYER b:PLAYER_LAYER];
}

@end
