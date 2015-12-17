#import "RenderSystem.h"
#import "Engine.Core.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"

@implementation RenderSystem {
	Scene *scene;
	SpriteBatch *spriteBatch;
}

- (id) initWithGame:(Game *)theGame scene:(Scene *)theScene{
	self = [super initWithGame:theGame];
	
	if(self) {
		scene = theScene;
	}
	
	return self;
}

- (void) loadContent {
	spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.game.graphicsDevice];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	[self.game.graphicsDevice clearWithColor:[Color cornflowerBlue]];
	
	Matrix *viewProjection = [scene.mainCamera getViewProjection];
	
	[spriteBatch beginWithSortMode:SpriteSortModeDeffered
							  BlendState:nil
							SamplerState:nil
					 DepthStencilState:nil
						RasterizerState:nil
									Effect:nil
						TransformMatrix:viewProjection];
	
	[self drawNode:scene.root gameTime:gameTime];
	
	[spriteBatch end];
}

- (void) drawNode:(Node *) node gameTime:(GameTime *) gameTime {
	for(id<INodeComponent> component in node.components) {
		if([component conformsToProtocol:@protocol(IDrawableComponent) ]) {
			id<IDrawableComponent> drawableComponent = (id<IDrawableComponent>)component;
			
			[drawableComponent drawWithGameTime:gameTime spriteBatch:spriteBatch];
		}
	}
	
	for(Node *child in node.children) {
		[self drawNode:child gameTime:gameTime];
	}
}

@end
