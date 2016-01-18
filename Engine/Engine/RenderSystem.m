#import "RenderSystem.h"
#import "Engine.Core.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"

@implementation RenderSystem {
	Scene *scene;
	NSMutableDictionary *renderers;
	NSMutableDictionary *effects;
}

- (id) initWithGame:(Game *)theGame scene:(Scene *)theScene{
	self = [super initWithGame:theGame];
	
	if(self) {
		scene = theScene;
		
		renderers = [NSMutableDictionary dictionary];
		effects = [NSMutableDictionary dictionary];
		[scene.sceneListeners addObject:self];
	}
	
	return self;
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	GraphicsDevice *graphicsDevice = self.game.graphicsDevice;
	
	[graphicsDevice clearWithColor:scene.mainCamera.clearColor];
	
	graphicsDevice.rasterizerState = [RasterizerState cullClockwise];

	for(id tag in renderers) {
		BasicEffect *effect = [effects objectForKey:tag];

		effect.view = scene.mainCamera.view;
		effect.projection = scene.mainCamera.projection;
		
		for(id<IRenderableComponent> renderable in [renderers objectForKey:tag]) {
			effect.world = renderable.node.transform.localToWorld;
			
			[[effect.currentTechnique.passes objectAtIndex:0] apply];
			
			[renderable drawWithGameTime:gameTime graphicsDevice:graphicsDevice];
		}
	}
}

- (void)onAddComponent:(id<INodeComponent>)component to:(Node *)node {
	if([component conformsToProtocol:@protocol(IRenderableComponent) ]) {
		id<IRenderableComponent> renderable = (id<IRenderableComponent>) component;
		BasicEffect *effect = renderable.effect;

		NSMutableArray *renderersForEffect = [renderers objectForKey:effect.tag];
		
		if(renderersForEffect == nil) {
			[effects setObject:effect forKey:effect.tag];
			
			renderersForEffect = [NSMutableArray array];
			[renderers setObject:renderersForEffect forKey:effect.tag];
		}
		
		[renderersForEffect addObject:renderable];
	}
}

- (void)onRemoveComponent:(id<INodeComponent>)component from:(Node *)node {
	if([component conformsToProtocol:@protocol(IRenderableComponent)]) {
		id<IRenderableComponent> renderer = (id<IRenderableComponent>) component;
		BasicEffect *effect = renderer.effect;
		
		NSMutableArray *renderersForEffect = [renderers objectForKey:effect.tag];

		[renderersForEffect removeObject:renderer];
		
		if(renderersForEffect.count == 0) {
			[effects removeObjectForKey:effect.tag];
			[renderers removeObjectForKey:effect.tag];
		}
	}
}

@end
