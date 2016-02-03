#import "MainScene.h"
#import "TINR.Glomero.h"
#import "Retronator.Xni.Framework.Graphics.h"

#import "Random.h"
#import "Rotate.h"

@implementation MainScene {
	GUIText *scoreLabel;
	GamePlay *gamePlay;
}

- (void) loadContent {
	self.mainCamera.projection = [Matrix createPerspectiveFieldOfView:TO_RAD(60.0f)
																			aspectRatio:self.graphicsDevice.viewport.aspectRatio
																	nearPlaneDistance:0.01f
																	 farPlaneDistance:100.0f];
	Glomero *glomero = [Glomero getInstance];
	
	LevelGenerator *levelGenerator = [[self createNode] addComponentOfClass:[LevelGenerator class]];
	levelGenerator.far = 16.0f;

	glomero.platformEffect0.fogEnabled = YES;
	glomero.platformEffect0.fogColor = [Vector3 vectorWithX:self.mainCamera.clearColor.r y:self.mainCamera.clearColor.g z:self.mainCamera.clearColor.b];
	glomero.platformEffect0.fogEnd = levelGenerator.far;
	glomero.platformEffect0.fogStart = levelGenerator.far - 4.0f;
	glomero.platformEffect1.fogEnabled = YES;
	glomero.platformEffect1.fogColor = [Vector3 vectorWithX:self.mainCamera.clearColor.r y:self.mainCamera.clearColor.g z:self.mainCamera.clearColor.b];
	glomero.platformEffect1.fogEnd = levelGenerator.far;
	glomero.platformEffect1.fogStart = levelGenerator.far - 4.0f;
	glomero.platformEffect2.fogEnabled = YES;
	glomero.platformEffect2.fogColor = [Vector3 vectorWithX:self.mainCamera.clearColor.r y:self.mainCamera.clearColor.g z:self.mainCamera.clearColor.b];
	glomero.platformEffect2.fogEnd = levelGenerator.far;
	glomero.platformEffect2.fogStart = levelGenerator.far - 4.0f;
	glomero.coinEffect.fogEnabled = YES;
	glomero.coinEffect.fogColor = [Vector3 vectorWithX:self.mainCamera.clearColor.r y:self.mainCamera.clearColor.g z:self.mainCamera.clearColor.b];
	glomero.coinEffect.fogEnd = levelGenerator.far;
	glomero.coinEffect.fogStart = levelGenerator.far - 4.0f;

	// Create gameplay
	{
		Node *node = [self createNode];
		scoreLabel = [node addComponentOfClass:[GUIText class]];
		
		scoreLabel.font = glomero.font;
		scoreLabel.text = @"0";
		scoreLabel.scale = [Vector2 vectorWithX:2.0f y:2.0f];
		scoreLabel.node.transform.position = [Vector3 vectorWithX:10.0f y:10.0f z:0.0f];
		
		gamePlay = [node addComponentOfClass:[GamePlay class]];
	}
	
	// Create player
	{
		Node *node = [self createNode];
		
		MeshRenderer *mr = [node addComponentOfClass:[MeshRenderer class]];
		mr.mesh = [Mesh loadFromFile:@"Sphere" graphicsDevice:self.graphicsDevice];
		mr.effect = glomero.playerEffect;
		
		node.transform.position = [Vector3 vectorWithX:0.0f y:3.0f z:-3.0f];
		
		[node addComponentOfClass:[SphereCollider class]];
		[node addComponentOfClass:[PlayerPhysics class]];
		[node addComponentOfClass:[PlayerInput class]];
		
		CameraFollow *cf = [self.mainCamera.node addComponentOfClass:[CameraFollow class]];
		cf.target = node.transform;
	}
	
	[MediaPlayer playSong:glomero.soundtrack];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	
	scoreLabel.text = [NSString stringWithFormat:@"%d", gamePlay.score];
}

@end
