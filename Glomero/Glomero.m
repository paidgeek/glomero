#import "Glomero.h"
#import "TINR.Glomero.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"

@implementation Glomero {
	GraphicsDeviceManager *graphics;
}

static Glomero *instance;
@synthesize currentScene, worldAtlas, entitiesAtlas, uiAtlas, font,
blibSound, coinSound, jumpSound, hitSound,
platformTexture, platformEffect0, platformEffect1, platformEffect2,
playerTexture, playerEffect, soundtrack, coinEffect, explosionSound;

- (id) init {
	self = [super init];
	
	if(self) {
		instance = self;
		
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
	}
	
	return self;
}

- (void)loadContent {
	[PlayerPrefs load];
	
	worldAtlas = [TextureAtlas loadWithContentManager:self.content
														 atlasName:@"World"];
	entitiesAtlas = [TextureAtlas loadWithContentManager:self.content
															 atlasName:@"Entities"];
	uiAtlas = [TextureAtlas loadWithContentManager:self.content
													 atlasName:@"UI"];
	FontTextureProcessor *fontProcessor = [[FontTextureProcessor alloc] init];
	font = [self.content load:@"BitBold" processor:fontProcessor];
	
	blibSound = [self.content load:@"Blip"];
	coinSound = [self.content load:@"Pickup"];
	jumpSound = [self.content load:@"Jump"];
	hitSound = [self.content load:@"Hit"];
	explosionSound = [self.content load:@"Explosion"];
	soundtrack = [self.content load:@"Soundtrack" processor:[[SongProcessor alloc] init]];
	
	platformTexture = [self.content load:@"Platform"];
	playerTexture = [self.content load:@"Sphere" fromFile:@"Sphere.png"];
	
	{
		playerEffect = [[BasicEffect alloc] initWithGraphicsDevice:self.graphicsDevice];
		playerEffect.tag = @"Player";
		
		playerEffect.textureEnabled = YES;
		playerEffect.vertexColorEnabled = NO;
		playerEffect.texture = playerTexture;
		playerEffect.diffuseColor = [Vector3 vectorWithX:1 y:1 z:1];
		//playerEffect.emissiveColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		playerEffect.lightingEnabled = YES;
		playerEffect.ambientColor = [Vector3 vectorWithX:0.4 y:0.4 z:0.4];
		playerEffect.ambientLightColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		//playerEffect.directionalLight0.enabled = YES;
		//playerEffect.directionalLight0.direction = [[Vector3 vectorWithX:-1 y:-1 z:0] normalize];
		//playerEffect.directionalLight0.diffuseColor = [Vector3 vectorWithX:0.3 y:0.3 z:0.3];
	}
	
	{
		coinEffect = [[BasicEffect alloc] initWithGraphicsDevice:self.graphicsDevice];
		coinEffect.tag = @"Coin";
		
		coinEffect.textureEnabled = NO;
		coinEffect.vertexColorEnabled = NO;
		//coinEffect.diffuseColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		coinEffect.lightingEnabled = NO;
		//coinEffect.ambientColor = [Vector3 vectorWithX:0.4 y:0.4 z:0.4];
		//coinEffect.ambientLightColor = [Vector3 vectorWithX:1 y:1 z:1];
	}
	
	{
		// 0
		platformEffect0 = [[BasicEffect alloc] initWithGraphicsDevice:self.graphicsDevice];
		platformEffect0.tag = @"Platform0";
		
		platformEffect0.textureEnabled = YES;
		platformEffect0.vertexColorEnabled = NO;
		platformEffect0.texture = platformTexture;
		platformEffect0.diffuseColor = [Vector3 vectorWithX:1 y:1 z:1];
		platformEffect0.emissiveColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		platformEffect0.lightingEnabled = YES;
		platformEffect0.ambientColor = [Vector3 vectorWithX:0.2 y:0.2 z:0.2];
		platformEffect0.ambientLightColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		platformEffect0.directionalLight0.enabled = YES;
		platformEffect0.directionalLight0.direction = [[Vector3 vectorWithX:-1 y:-1 z:0] normalize];
		platformEffect0.directionalLight0.diffuseColor = [Vector3 vectorWithX:0.3 y:0.3 z:0.3];
	
		// 1
		platformEffect1 = [[BasicEffect alloc] initWithGraphicsDevice:self.graphicsDevice];
		platformEffect1.tag = @"Platform1";
		
		platformEffect1.textureEnabled = YES;
		platformEffect1.vertexColorEnabled = NO;
		platformEffect1.texture = platformTexture;
		platformEffect1.diffuseColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		platformEffect1.emissiveColor = [Vector3 vectorWithX:1 y:0 z:0];
		
		platformEffect1.lightingEnabled = YES;
		platformEffect1.ambientColor = [Vector3 vectorWithX:0.2 y:0.2 z:0.2];
		platformEffect1.ambientLightColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		platformEffect1.directionalLight0.enabled = YES;
		platformEffect1.directionalLight0.direction = [[Vector3 vectorWithX:-1 y:-1 z:0] normalize];
		platformEffect1.directionalLight0.diffuseColor = [Vector3 vectorWithX:0.3 y:0.3 z:0.3];
		
		// 2
		platformEffect2 = [[BasicEffect alloc] initWithGraphicsDevice:self.graphicsDevice];
		platformEffect2.tag = @"Platform2";
		
		platformEffect2.textureEnabled = YES;
		platformEffect2.vertexColorEnabled = NO;
		platformEffect2.texture = platformTexture;
		platformEffect2.diffuseColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		platformEffect2.emissiveColor = [Vector3 vectorWithX:0 y:1 z:0];
		
		platformEffect2.lightingEnabled = YES;
		platformEffect2.ambientColor = [Vector3 vectorWithX:0.2 y:0.2 z:0.2];
		platformEffect2.ambientLightColor = [Vector3 vectorWithX:1 y:1 z:1];
		
		platformEffect2.directionalLight0.enabled = YES;
		platformEffect2.directionalLight0.direction = [[Vector3 vectorWithX:-1 y:-1 z:0] normalize];
		platformEffect2.directionalLight0.diffuseColor = [Vector3 vectorWithX:0.3 y:0.3 z:0.3];
	}
	
	[super loadContent];
	
	[self enterScene:[MainMenu class]];
}

- (void)enterScene:(Class)sceneClass {
	if(currentScene) {
		[currentScene onExit];
	}
	
	currentScene = [[sceneClass alloc] initWithGame:self];
}

+ (Glomero *)getInstance {
	return instance;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	for(int i = [self.components count] - 1; i >= 0; i--) {
		GameComponent *comp = (GameComponent *)[self.components itemAt:i];
		
		if(!comp.enabled) {
			[self.components removeComponent:comp];
		}
	}
	
	[super updateWithGameTime:gameTime];
}

@end
