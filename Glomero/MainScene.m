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
	self.mainCamera.node.transform.rotation = [Quaternion axis:[Vector3 left] angle:TO_RAD(-30.0f)];

	Glomero *glomero = [Glomero getInstance];

	// Effect
	effect = [[BasicEffect alloc] initWithGraphicsDevice:self.graphicsDevice];
	effect.tag = @"Dirt";
	effect.view = self.mainCamera.view;
	effect.projection = self.mainCamera.projection;
	effect.textureEnabled = NO;
	effect.vertexColorEnabled = YES;
	effect.lightingEnabled = NO;

	/*
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
	*/
	
	/*
	{
		Node *node = [self createNode];
		ModelRenderer *mr = [node addComponentOfClass:[ModelRenderer class]];
		
		mr.model = [self.game.content load:@"Sphere" fromFile:@"Sphere.x"];
		
		node.transform.position = [Vector3 vectorWithX:0 y:0 z:-5.0f];
	}
	*/
}

static int x = 0;
static int z = 0;

- (void)updateWithGameTime:(GameTime *)gameTime {
	if(z < 30) {
		Node *cube = [self createNode];
		cube.transform.position = [Vector3 vectorWithX:x-2 y:0 z:-z];
		
		MeshRenderer *mr = [cube addComponentOfClass:[MeshRenderer class]];
		
		mr.effect = effect;
		mr.mesh = [MeshFactory createColoredCubeWithGraphicsDevice:self.game.graphicsDevice
																			  width:1
																			 height:[Random intGreaterThanOrEqual:1 lessThan:3]
																			  depth:1
																			  color:[Color colorWithPercentageRed:[Random float]
																													  green:[Random float]
																														blue:[Random float]]];
		
		x = (x + 1) % 5;
		if(x == 4) {
			z++;
		}
	}
	
	[super updateWithGameTime:gameTime];
}

@end
