#import "MainScene.h"
#import "TINR.Glomero.h"
#import "Retronator.Xni.Framework.Graphics.h"

#import "Random.h"
#import "Rotate.h"

@implementation MainScene

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

	{
		Node *node = [self createNode];
		
		ModelRenderer *mr = [node addComponentOfClass:[ModelRenderer class]];
		mr.model = [self.game.content load:@"Sphere" fromFile:@"Sphere.x"];
		
		node.transform.position = [Vector3 vectorWithX:0 y:1 z:-3.0f];
		node.transform.scale = [Vector3 vectorWithX:0.5f y:0.5f z:0.5f];
		
		[node addComponentOfClass:[PlayerPhysics class]];
		[node addComponentOfClass:[PlayerInput class]];
		
		CameraFollow *cf = [self.mainCamera.node addComponentOfClass:[CameraFollow class]];
		cf.target = node.transform;
	}
	
	{
		Node *node = [self createNode];
		GUIText *text = [node addComponentOfClass:[GUIText class]];
		PlayerScore *score = [node addComponentOfClass:[PlayerScore class]];
	
		text.font = glomero.font;
		text.text = @"0";
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
		text.node.transform.position = [Vector3 vectorWithX:10.0f y:10.0f z:0.0f];
		
		score.scoreLabel = text;
	}
}

@end
