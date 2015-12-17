#import "MainScene.h"
#import "TINR.Glomero.h"

#define WIDTH 12
#define HEIGHT 16

#import "Step.h"

@interface MainScene ()
- (NSMutableArray *) findPath:(int) sx sy:(int) sy tx:(int) tx ty:(int) ty;
- (BOOL) isBlockedX:(int) x y:(int) y;
- (BOOL) isValidLocationSX:(int) sx sy:(int) sy x:(int) x y:(int) y;
- (float) getCostSX:(int) sx sy:(int) sy tx:(int) tx ty:(int) ty;
@end

@implementation MainScene {
	int map[WIDTH][HEIGHT];
	NSMutableArray *closed, *open;
	Step *nodes[WIDTH][HEIGHT];
	Player *player;
}

@synthesize worldAtlas, entitiesAtlas;

- (void) loadContent {
	worldAtlas = [TextureAtlas loadWithContentManager:self.game.content
														 atlasName:@"World"];
	entitiesAtlas = [TextureAtlas loadWithContentManager:self.game.content
															 atlasName:@"Entities"];
	
	for (int x = 0; x < WIDTH; x++) {
		for(int y = 0; y < HEIGHT; y++) {
			map[x][y] = 1;
		}
	}

	for(int i = 0; i < 6; i++) {
		int x = arc4random_uniform(WIDTH);
		int y = arc4random_uniform(HEIGHT);
		
		for(int j = 0; j < WIDTH; j++) {
			if(arc4random_uniform(5) > 0)
			map[j][y] = 0;
		}
		
		for(int j = 0; j < HEIGHT; j++) {
			if(arc4random_uniform(5) > 0)
			map[x][j] = 0;
		}
	}
	
	for (int x = 0; x < WIDTH; x++) {
		for(int y = 0; y < HEIGHT; y++) {
			Node *tileNode = [self createNode];
			SpriteRenderer *tileSr = [tileNode addComponentOfClass:[SpriteRenderer class]];
			tileNode.transform.position = [Vector2 vectorWithX:x*128.0f y:y*128.0f];

			switch (map[x][y]) {
				case 0:
					tileSr.sprite = [worldAtlas getSpriteWithName:@"grass"];
					break;
				case 1:
					tileSr.sprite = [worldAtlas getSpriteWithName:@"brick"];
					break;
			}
		}
	}
	
	{
		int x = 1;
		int y = 1;
		
		while(YES) {
			x = arc4random_uniform(WIDTH);
			y = arc4random_uniform(HEIGHT);
			
			if(map[x][y] == 0) {
				break;
			}
		}
		
		Node *playerNode = [self createNode];
		playerNode.layer = PLAYER_LAYER;
		SpriteRenderer *sr = [playerNode addComponentOfClass:[SpriteRenderer class]];
		player = [playerNode addComponentOfClass:[Player class]];
		
		sr.sprite = [entitiesAtlas getSpriteWithName:@"PinkAlien"];
		
		player.node.transform.position = [Vector2 vectorWithX:x*128 y:y*128];
	}
	
	[self.collisionMatrix enableBetweenA:COIN_LAYER b:PLAYER_LAYER];
	
	self.mainCamera.projection = [Matrix createScaleX:0.5f y:0.5f z:1.0f];
	[self.mainCamera.node.transform.position set:[Vector2 vectorWithX:320.0f y:480.0f]];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	
	TouchCollection *touches = [[TouchPanel getInstance] getState];
	
	for(TouchLocation *touch in touches) {
		if(touch.state == TouchLocationStatePressed) {
			Matrix *vp = [self.mainCamera getViewProjection];
			
			Vector2 *p = [Vector2 transform:touch.position with:[Matrix invert:vp]];
			
			int x = (int)((p.x + 64) / 128.0f);
			int y = (int)((p.y + 64) / 128.0f);

			Vector2 *sp = player.node.transform.position;
			
			int sx = (int) (sp.x / 128.0f);
			int sy = (int) (sp.y / 128.0f);

			player.path = [self findPath:sx sy:sy tx:x ty:y];
		}
	}
}

- (NSMutableArray *)findPath:(int) sx sy:(int) sy tx:(int) tx ty:(int) ty {
	for (int x = 0; x < WIDTH; x++) {
		for(int y = 0; y < HEIGHT; y++) {
			nodes[x][y] = [[Step alloc] initWithX:x y:y];
		}
	}
	
	nodes[sx][sy].cost = 0;
	nodes[sx][sy].depth = 0;

	closed = [NSMutableArray array];
	open = [NSMutableArray arrayWithObjects:nodes[sx][sy], nil];
	
	nodes[tx][ty].parent = nil;
	
	int maxDepth = 0;
	const int maxSearchDistance = 100;
	
	while((maxDepth < maxSearchDistance) && [open count] != 0) {
		Step *current = [open firstObject];
		
		if(current == nodes[tx][ty]) {
			break;
		}
		
		[open removeObject:current];
		[closed addObject:current];
		
		for (int x = -1; x < 2; x++) {
			for (int y = -1; y < 2; y++) {
				if ((x == 0) && (y == 0)) {
					continue;
				}
				
				if(x != 0 && y != 0) {
					continue;
				}
				
				int xp = x + (int)current.position.x;
				int yp = y + (int)current.position.y;
				
				if([self isValidLocationSX:sx sy:sy x:xp y:yp]) {
					float nextStepCost = current.cost + [self getCostSX:(int)current.position.x sy:(int)current.position.y tx:xp ty:yp];
					Step *neighbour = nodes[xp][yp];
					
					if(nextStepCost < neighbour.cost) {
						if([open containsObject:neighbour]) {
							[open removeObject:neighbour];
						}
						
						if([closed containsObject:neighbour]) {
							[closed removeObject:neighbour];
						}
					}
					
					if(![open containsObject:neighbour] && ![closed containsObject:neighbour]) {
						neighbour.cost = nextStepCost;
						neighbour.heuristic = [self getCostSX:xp sy:yp tx:tx ty:ty];
						maxDepth = MAX(maxDepth, [neighbour assignParent:current]);
						
						[open addObject:neighbour];
						[open sortUsingSelector:@selector(compare:)];
					}
				}
			}
		}
	}
	
	if(nodes[tx][ty].parent == nil) {
		return nil;
	}
	
	NSMutableArray *path = [NSMutableArray array];
	Step *target = nodes[tx][ty];

	while(target != nodes[sx][sy] ) {
		[path insertObject:[Vector2 vectorWithX:target.position.x y:target.position.y] atIndex:0];
		
		target = target.parent;
	}
	
	[path insertObject:[Vector2 vectorWithX:sx y:sy] atIndex:0];
	
	
	return path;
}

- (BOOL)isBlockedX:(int)x y:(int)y {
	return map[x][y] != 0;
}

- (float)getCostSX:(int)sx sy:(int)sy tx:(int)tx ty:(int)ty {
	float dx = tx - sx;
	float dy = ty - sy;
	
	return sqrtf(dx * dx + dy * dy);
}

- (BOOL)isValidLocationSX:(int)sx sy:(int)sy x:(int)x y:(int)y {
	BOOL invalid = x < 0 || y < 0 || x >= WIDTH || y >= HEIGHT;
	
	if(!invalid && (sx != x || sy != y)) {
		invalid = [self isBlockedX:x y:y];
	}
	
	return !invalid;
}

@end
