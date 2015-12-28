#import "MainScene.h"
#import "TINR.Glomero.h"

@implementation MainScene

- (void) loadContent {
	Glomero *glomero = [Glomero getInstance];
	
	for (int x = 0; x < 15; x++) {
		for(int y = 0; y < 30; y++) {
			Node *tileNode = [self createNode];
			SpriteRenderer *tileSr = [tileNode addComponentOfClass:[SpriteRenderer class]];
			tileNode.transform.position = [Vector2 vectorWithX:x*128.0f y:-y*128.0f + 8 * 128.0f];

			switch (arc4random_uniform(2)) {
				case 0:
					tileSr.sprite = [glomero.worldAtlas getSpriteWithName:@"grass"];
					break;
				case 1:
					tileSr.sprite = [glomero.worldAtlas getSpriteWithName:@"brick"];
					break;
			}
		}
	}
	
	[self.mainCamera.node.transform.position set:[Vector2 vectorWithX:320.0f y:480.0f]];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	
	[self.mainCamera.node.transform translateX:0.0f y:gameTime.elapsedGameTime * -50.0f];
}

@end
