#import "Glomero.h"

@implementation Glomero

-(id)init {
	self = [super init];
	
	if(self) {
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
	}
	
	return self;
}

-(void)initialize {
    spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
	
    [super initialize];
}

-(void)loadContent {
	NSString *atlasData = [[NSBundle mainBundle] pathForResource:@"world_data"
														  ofType:@"json"
													 inDirectory:@"Images"];
	worldAtlas = [[TextureAtlas alloc] initWithTexture:[self.content load:@"world_atlas"
																 fromFile:@"Images/world_atlas.png"]
												  data:atlasData];
	dirt = [worldAtlas getSpriteWithName:@"dirt"];
	grass = [worldAtlas getSpriteWithName:@"grass"];
	coin = [worldAtlas getSpriteWithName:@"gold_1"];
	
	for (int x = 0; x < 16; x++) {
		for (int y = 0; y < 16; y++) {
			switch (arc4random_uniform(2)) {
				case 0:
					map[y][x] = TileDirt;
					break;
				case 1:
					map[y][x] = TileGrass;
					break;
			}
		}
	}
}

-(void)drawWithGameTime:(GameTime *)gameTime {
	[self.graphicsDevice clearWithColor:[Color cornflowerBlue]];
	
	[spriteBatch begin];
	
	for (int x = 0; x < 16; x++) {
		for (int y = 0; y < 16; y++) {
			float tx = x * 128.0f;
			float ty = y * 128.0f;
			
			switch (map[y][x]) {
				case TileDirt:
					[self drawTileWithSprite:dirt x: tx y: ty];
					break;
				case TileGrass:
					[self drawTileWithSprite:grass x: tx y: ty];
					break;
			}
		}
	}
	
	[spriteBatch draw:coin.texture to:[Vector2 vectorWithX:300 y:400 ]
		fromRectangle:coin.rectange
		tintWithColor:[Color white]];
	
	[spriteBatch end];
	
	[super drawWithGameTime:gameTime];
}

- (void) drawTileWithSprite:(Sprite*) tileSprite
						  x:(float) x
						  y:(float) y {
	[spriteBatch draw:tileSprite.texture
				   to:[Vector2 vectorWithX:x y:y ]
		fromRectangle:tileSprite.rectange
		tintWithColor:[Color white]
			 rotation:0
			   origin:[Vector2 zero]
		 scaleUniform:1.0f
			  effects:SpriteEffectsNone
		   layerDepth:0];
}

@end
