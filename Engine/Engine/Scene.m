#import "Scene.h"
#import "Engine.Core.h"
#import "Retronator.Xni.Framework.Graphics.h"

@implementation Scene {
	LogicSystem *logicSystem;
	RenderSystem *renderSystem;
	UISystem *uiSystem;
	NSMutableArray *actions;
}

static Scene *instance;
@synthesize root, sceneListeners, mainCamera;

- (id) initWithGame:(Game *)theGame {
	self = [super initWithGame:theGame];

	if(self) {
		instance = self;
		
		actions = [NSMutableArray array];
		sceneListeners = [NSMutableArray array];
		
		root = [[Node alloc] init];
		root.transform = [[Transform alloc] initWithNode:root];
		
		logicSystem = [[LogicSystem alloc] initWithGame:self.game
																scene:self];
		renderSystem = [[RenderSystem alloc] initWithGame:self.game
																  scene:self];
		uiSystem = [[UISystem alloc] initWithGame:self.game
														scene:self];
		
		for (id comp in self.game.components) {
			if([comp class] == [Scene class] ||
				[comp class] == [LogicSystem class] ||
				[comp class] == [RenderSystem class] ||
				[comp class] == [UISystem class])
			{
				[comp setEnabled:NO];
			}
		}
		
		[[self.game components] addComponent:self];
	}
	
	return self;
}

- (void) initialize {
	[self.game.components addComponent:logicSystem];
	[self.game.components addComponent:renderSystem];
	[self.game.components addComponent:uiSystem];

	self.updateOrder = 0;
	logicSystem.updateOrder = 1;
	renderSystem.updateOrder = 2;
	uiSystem.updateOrder = 3;
	
	Node *cameraNode = [self createNode];
	self.mainCamera = [cameraNode addComponentOfClass:[Camera class]];
	
	[super initialize];
}

- (void)onExit {}

- (Node *) createNode {
	return [self createNodeWithParent:root];
}

- (Node *) createNodeWithParent:(Node *) parent {
	Node *node = [[Node alloc] init];
	
	node.parent = parent;
	node.transform = [[Transform alloc] initWithNode:node];
	[node.transform setParent:parent.transform];
	
	[actions addObject:[SceneAction createNode:node parent:parent]];
	
	return node;
}

- (void) destroyNode:(Node *) node {
	if(node != root) {
		node.willBeDestroyed = YES;
		[actions addObject:[SceneAction destroyNode:node]];
	}
}

- (void) addAction:(id<ISceneAction>) action {
	[actions addObject:action];
}

- (void) updateWithGameTime:(GameTime *) gameTime {
	for(id<ISceneAction> action in actions) {
		[action performOnScene:self];
	}
	
	[actions removeAllObjects];
}

- (int)drawCount {
	return renderSystem.drawCount;
}

+ (Scene *) getInstance {
	return instance;
}

@end
