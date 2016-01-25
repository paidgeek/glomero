#import "MainScene.h"
#import "TINR.Glomero.h"
#import "Retronator.Xni.Framework.Graphics.h"

#import "Random.h"
#import "Rotate.h"

@implementation MainScene {
	BasicEffect *effect;
}

- (void) loadContent {
	self.mainCamera.projection = [Matrix createPerspectiveFieldOfView:TO_RAD(60.0f)
																			aspectRatio:self.graphicsDevice.viewport.aspectRatio
																	nearPlaneDistance:0.01f
																	 farPlaneDistance:100.0f];
	self.mainCamera.node.transform.position = [Vector3 vectorWithX:0.0f y:2.0f z:0.0f];
	self.mainCamera.node.transform.rotation = [Quaternion axis:[Vector3 left] angle:TO_RAD(-25.0f)];

	Glomero *glomero = [Glomero getInstance];

	// Effect
	effect = [[BasicEffect alloc] initWithGraphicsDevice:self.graphicsDevice];
	effect.tag = @"Platform";

	// Material
	effect.textureEnabled = YES;
	effect.vertexColorEnabled = NO;
	effect.texture = glomero.platformTexture;
	effect.diffuseColor = [Vector3 vectorWithX:1 y:1 z:1];
	
	effect.emissiveColor = [Vector3 vectorWithX:1 y:0 z:0];
	
	// Lighting
	effect.lightingEnabled = YES;
	effect.ambientColor = [Vector3 vectorWithX:0.2 y:0.2 z:0.2];
	effect.ambientLightColor = [Vector3 vectorWithX:1 y:1 z:1];
	
	effect.directionalLight0.enabled = YES;
	effect.directionalLight0.direction = [[Vector3 vectorWithX:-1 y:-1 z:0] normalize];
	effect.directionalLight0.diffuseColor = [Vector3 vectorWithX:0.3 y:0.3 z:0.3];
	
	effect.fogEnabled = YES;
	effect.fogColor = [Vector3 vectorWithX:self.mainCamera.clearColor.r y:self.mainCamera.clearColor.g z:self.mainCamera.clearColor.b];
	effect.fogStart = 13.0f;
	effect.fogEnd = 15.0f;
	
	{
		Node *cube = [self createNode];
		cube.transform.position = [Vector3 vectorWithX:0 y:0 z:-5];
		
		MeshRenderer *mr = [cube addComponentOfClass:[MeshRenderer class]];
		
		mr.effect = effect;
		mr.mesh = [MeshFactory createCubeWithGraphicsDevice:self.game.graphicsDevice
																	 width:4
																	height:1
																	 depth:20];
		
	}
	
	/*
	{
		Node *node = [self createNode];
		ModelRenderer *mr = [node addComponentOfClass:[ModelRenderer class]];
		
		mr.model = [self.game.content load:@"Sphere" fromFile:@"Sphere.x"];
		
		node.transform.position = [Vector3 vectorWithX:0 y:1 z:-3.0f];
		node.transform.scale = [Vector3 vectorWithX:0.5f y:0.5f z:0.5f];
		
		[node addComponentOfClass:[PlayerPhysics class]];
	}
	 */
}

@end
