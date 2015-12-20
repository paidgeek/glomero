#import "UISystem.h"
#import "Engine.Core.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@interface UISystem ()

- (void) updateNode:(Node *) node gameTime:(GameTime *) gameTime;
- (void) drawNode:(Node *) node gameTime:(GameTime *) gameTime;

@end

@implementation UISystem {
	Scene *scene;
	SpriteBatch *spriteBatch;
	Matrix *camera;
	Matrix *inverseView;
	TouchCollection *touches;
}

- (id) initWithGame:(Game *)theGame scene:(Scene *)theScene {
	self = [super initWithGame:theGame];
	
	if(self) {
		scene = theScene;
	}
	
	return self;
}

- (void) initialize {
	[super initialize];
	
	spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.game.graphicsDevice];
	
	float sx = 1.0f / self.game.gameWindow.clientBounds.width;
	float sy = 1.0f / self.game.gameWindow.clientBounds.height;
	
	sx = 1.0f;
	sy = 1.0f;
	
	camera = [Matrix createScaleX:sx y:sy z:1.0f];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	inverseView = [Matrix invert:camera];
	touches = [[TouchPanel getInstance] getState];
	
	[self updateNode:scene.root gameTime:gameTime];
}

- (void)updateNode:(Node *)node gameTime:(GameTime *)gameTime {
	for(id<INodeComponent> component in node.components) {
		if([component conformsToProtocol:@protocol(IUIComponent)]) {
			id<IUIComponent> uiComponent = (id<IUIComponent>) component;
			
			if([uiComponent respondsToSelector:@selector(updateWithGameTime:inverseView:touches:)]) {
				[uiComponent updateWithGameTime:gameTime inverseView:inverseView touches:touches];
			}
		}
	}
	
	for(Node *child in node.children) {
		[self updateNode:child gameTime:gameTime];
	}
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	[spriteBatch beginWithSortMode:SpriteSortModeDeffered
							  BlendState:nil
							SamplerState:[SamplerState pointClamp]
					 DepthStencilState:nil
						RasterizerState:nil
									Effect:nil
						TransformMatrix:camera];
	
	[self drawNode:scene.root gameTime:gameTime];
	
	[spriteBatch end];
}

- (void) drawNode:(Node *) node gameTime:(GameTime *) gameTime {
	for(id<INodeComponent> component in node.components) {
		if([component conformsToProtocol:@protocol(IUIComponent) ]) {
			id<IUIComponent> uiComponent = (id<IUIComponent>)component;
			
			if ([uiComponent respondsToSelector:@selector(drawWithGameTime:spriteBatch:)]) {
				[uiComponent drawWithGameTime:gameTime spriteBatch:spriteBatch];
			}
		}
	}
	
	for(Node *child in node.children) {
		[self drawNode:child gameTime:gameTime];
	}
}

@end
