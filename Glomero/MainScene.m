#import "MainScene.h"
#import "TINR.Glomero.h"
#include <stdlib.h>

@implementation MainScene {
	TextureAtlas *worldAtlas;
}

- (void) loadContent {
	TextureAtlas *worldAtlas = [TextureAtlas loadWithContentManager:self.game.content
																			atlasName:@"World"];
	TextureAtlas *entitiesAtlas = [TextureAtlas loadWithContentManager:self.game.content
																				atlasName:@"Entities"];
	
	for(int y = 0; y < 30; y++) {
		for (int x = 0; x < 6; x++) {
			Node *tileNode = [self createNode];
			SpriteRenderer *tileSr = [tileNode addComponentOfClass:[SpriteRenderer class]];
			tileNode.transform.position = [Vector2 vectorWithX:x*128.0f	y:(2048-y*128.0f)];
			
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

		player.node.transform.position = [Vector2 vectorWithX:320.0f y:700.0f];
		sr.sprite = [entitiesAtlas getSpriteWithName:@"PinkAlien"];
	}
	
	[self.collisionMatrix enableBetweenA:COIN_LAYER b:PLAYER_LAYER];
}

@end
