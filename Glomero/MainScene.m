#import "MainScene.h"
#import "TINR.Glomero.h"

#import "Random.h"
#import "Rotate.h"

@implementation MainScene {
	
}

- (void) loadContent {
	self.mainCamera.projection = [Matrix createPerspectiveFieldOfView:M_PI_2
																			aspectRatio:self.graphicsDevice.viewport.aspectRatio
																	nearPlaneDistance:0.01f
																	 farPlaneDistance:100.0f];
	
	Glomero *glomero = [Glomero getInstance];

	// Effect
	BasicEffect *effect = [[BasicEffect alloc] initWithGraphicsDevice:self.graphicsDevice];
	effect.tag = @"Dirt";
	effect.view = self.mainCamera.view;
	effect.projection = self.mainCamera.projection;
	effect.textureEnabled = YES;
	effect.vertexColorEnabled = NO;
	effect.lightingEnabled = YES;
	
	// Material
	effect.texture = [self.game.content load:@"Dirt"];
	effect.diffuseColor.x = 1;
	effect.diffuseColor.y = 1;
	effect.diffuseColor.z = 1;
	
	// Lighting
	effect.ambientColor = [Vector3 vectorWithX:0.2 y:0.5 z:0.2];
	effect.ambientLightColor = [Vector3 vectorWithX:1 y:1 z:1];
	
	effect.directionalLight0.enabled = YES;
	effect.directionalLight0.direction = [Vector3 down];
	effect.directionalLight0.diffuseColor.x = 1;
	effect.directionalLight0.diffuseColor.y = 1;
	effect.directionalLight0.diffuseColor.z = 1;
	
	for (int i = 0; i < 4; i++) {
		Node *cube = [self createNode];
		cube.transform.position = [Vector3 vectorWithX:[Random float]*6.0f-3.0f
																	y:[Random float]*6.0f-3.0f
																	z:-[Random float]*10.0f - 5];
		MeshRenderer *mr = [cube addComponentOfClass:[MeshRenderer class]];
		[cube addComponentOfClass:[Rotate class]];
		
		mr.effect = effect;
		mr.mesh = [MeshFactory createCubeWithGraphicsDevice:self.game.graphicsDevice width:1 height:1 depth:1];
	}
	
	{
		Node *node = [self createNode];
		ModelRenderer *mr = [node addComponentOfClass:[ModelRenderer class]];
		
		mr.model = [self.game.content load:@"Sphere" fromFile:@"Sphere.x"];
		
		node.transform.position = [Vector3 vectorWithX:0 y:0 z:-5.0f];
	}
}

@end
