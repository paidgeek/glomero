#import "Glomero.h"
#import "TINR.Glomero.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"

@implementation Glomero {
	GraphicsDeviceManager *graphics;
}

static Glomero *instance;
@synthesize currentScene, worldAtlas, entitiesAtlas, uiAtlas, font;

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
