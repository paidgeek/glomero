#import "Glomero.h"
#import "TINR.Glomero.h"
#import "Retronator.Xni.Framework.Input.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@implementation Glomero

- (id) init {
	self = [super init];
	
	if(self) {
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
		
		scene = [[Scene alloc] initWithGame:self];
		[self.components addComponent:scene];
		
		player = [[Player alloc] init];
	}
	
	return self;
}

- (void) initialize {
	spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
	
	[super initialize];
}

- (void) loadContent {
	NSString *atlasData = [[NSBundle mainBundle] pathForResource:@"world_data"
																			ofType:@"json"];
	worldAtlas = [[TextureAtlas alloc] initWithTexture:[self.content load:@"world_atlas"
																					 fromFile:@"world_atlas.png"]
																 data:atlasData];
	
	grass = [worldAtlas getSpriteWithName:@"grass"];
	
	NSString *entityData = [[NSBundle mainBundle] pathForResource:@"entity_data" ofType:@"json"];
	
	entityAtlas = [[TextureAtlas alloc] initWithTexture:[self.content load:@"entity_atlas"
																					  fromFile:@"entity_atlas.png"] data:entityData];
	
	yellowAlien = [entityAtlas getSpriteWithName:@"YellowAlien"];
	pinkAlien = [entityAtlas getSpriteWithName:@"PinkAlien"];
	
	yellowPos = [[Vector2 alloc] initWithX:0.0f y:0.0f];
	pinkPos = [[Vector2 alloc] initWithX:0.0f y:0.0f];
	pinkVel = [[[Vector2 alloc] initWithX:1.0f y:1.0f] normalize];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	[self.graphicsDevice clearWithColor:[Color cornflowerBlue]];
	
	[spriteBatch begin];
	
	for(int x = 0; x < 16; x++) {
		for (int y = 0; y < 16; y++) {
			float tx = x * 128.0f;
			float ty = y * 128.0f;
			
			[self drawTileWithSprite:grass x:tx y:ty];
		}
	}
	
	[spriteBatch end];
	
	[spriteBatch begin];
	
	[spriteBatch draw:yellowAlien.texture
						to:yellowPos
		 fromRectangle:yellowAlien.rectangle
		 tintWithColor:[Color white]
			 rotation:0
			   origin:[Vector2 zero]
		  scaleUniform:1.0f
			  effects:SpriteEffectsNone
			 layerDepth:1];
	
	[spriteBatch draw:pinkAlien.texture
						to:pinkPos
		 fromRectangle:pinkAlien.rectangle
		 tintWithColor:[Color white]
			 rotation:0
			   origin:[Vector2 zero]
		  scaleUniform:1.0f
			  effects:SpriteEffectsNone
			 layerDepth:1];
	
	[spriteBatch end];
	
	[super drawWithGameTime:gameTime];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	TouchCollection *touches = [[TouchPanel getInstance] getState];
	
	for(TouchLocation *touch in touches) {
		yellowPos = touch.position.copy;
		[yellowPos subtract:[Vector2 vectorWithX:32 y:32]];
	}
	
	[pinkPos add:[Vector2 multiply:pinkVel by:gameTime.elapsedGameTime*900.0f]];
	
	float xmin = 0.0f;
	float ymin = 0.0f;
	float xmax = 640.0f - 64.0f;
	float ymax = 960.0f - 64.0f;
	
	if(pinkPos.y < ymin) {
		[pinkVel setY:-pinkVel.y];
		[pinkPos setY:ymin];
	}
	
	if(pinkPos.y > ymax) {
		[pinkVel setY:-pinkVel.y];
		[pinkPos setY:ymax];
	}
	
	if(pinkPos.x < xmin) {
		[pinkVel setX:-pinkVel.x];
		[pinkPos setX:xmin];
	}
	
	if(pinkPos.x > xmax) {
		[pinkVel setX:-pinkVel.x];
		[pinkPos setX:xmax];
	}
}

- (void) drawTileWithSprite:(Sprite *)tileSprite x:(float)x y:(float)y {
	[spriteBatch draw:tileSprite.texture
						to:[Vector2 vectorWithX:x y:y ]
		 fromRectangle:tileSprite.rectangle
		 tintWithColor:[Color white]
			 rotation:0
			   origin:[Vector2 zero]
		  scaleUniform:1.0f
			  effects:SpriteEffectsNone
			 layerDepth:0];
}

- (void) dealloc {
	[graphics release];
	[scene release];
	
	[super dealloc];
}

@end
