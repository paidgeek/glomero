#import "RenderSystem.h"
#import "Engine.Core.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Engine.Graphics.h"

@implementation RenderSystem {
	Scene *scene;
	NSMutableDictionary *meshRenderers;
	NSMutableArray *modelRenderers;
	NSMutableDictionary *effects;
}

- (id) initWithGame:(Game *)theGame scene:(Scene *)theScene{
	self = [super initWithGame:theGame];
	
	if(self) {
		scene = theScene;
		
		meshRenderers = [NSMutableDictionary dictionary];
		effects = [NSMutableDictionary dictionary];
		modelRenderers = [NSMutableArray array];
		[scene.sceneListeners addObject:self];
	}
	
	return self;
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	GraphicsDevice *graphicsDevice = self.game.graphicsDevice;
	
	[graphicsDevice clearWithColor:scene.mainCamera.clearColor];
	
	graphicsDevice.rasterizerState = [RasterizerState cullNone];
	graphicsDevice.depthStencilState = [DepthStencilState defaultDepth];

	id view = scene.mainCamera.view;
	id projection = scene.mainCamera.projection;
	
	for(id tag in meshRenderers) {
		BasicEffect *effect = [effects objectForKey:tag];

		effect.view = view;
		effect.projection = projection;
		
		for(MeshRenderer *meshRenderer in [meshRenderers objectForKey:tag]) {
			effect.world = meshRenderer.node.transform.localToWorld;
			
			for(EffectPass *pass in effect.currentTechnique.passes) {
				[pass apply];
				
				[meshRenderer.mesh drawWithGraphicsDevice:graphicsDevice];
			}
		}
	}
	
	for(ModelRenderer *modelRenderer in modelRenderers) {
		id world = modelRenderer.node.transform.localToWorld;
		[modelRenderer.model drawWithWorld:world view:scene.mainCamera.view projection:scene.mainCamera.projection];
	}
}

- (void)onAddComponent:(id<INodeComponent>)component to:(Node *)node {
	if([component isKindOfClass:[MeshRenderer class]]) {
		MeshRenderer *mr = (MeshRenderer *) component;
		BasicEffect *effect = mr.effect;
		
		
		NSMutableArray *renderersForEffect = [meshRenderers objectForKey:effect.tag];
		
		if(renderersForEffect == nil) {
			[effects setObject:effect forKey:effect.tag];
			
			renderersForEffect = [NSMutableArray array];
			[meshRenderers setObject:renderersForEffect forKey:effect.tag];
		}
		
		[renderersForEffect addObject:mr];

	} else if([component isKindOfClass:[ModelRenderer class]]) {
		[modelRenderers addObject:(ModelRenderer *) component];
	}
}

- (void)onRemoveComponent:(id<INodeComponent>)component from:(Node *)node {
	if([component isKindOfClass:[MeshRenderer class]]) {
		MeshRenderer *mr = (MeshRenderer *) component;
		BasicEffect *effect = mr.effect;

		NSMutableArray *renderersForEffect = [meshRenderers objectForKey:effect.tag];

		[renderersForEffect removeObject:mr];
		
		if(renderersForEffect.count == 0) {
			[effects removeObjectForKey:effect.tag];
			[meshRenderers removeObjectForKey:effect.tag];
		}
	} else if([component isKindOfClass:[ModelRenderer class]]) {
		[modelRenderers removeObject:(ModelRenderer *) component];
	}
}

@end
