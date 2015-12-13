#import "Scene.h"
#import "Engine.Core.h"
#import "Retronator.Xni.Framework.Graphics.h"

@implementation Scene {
	LogicSystem *logicSystem;
	RenderSystem *renderSystem;
	PhysicsSystem *physicsSystem;
	NSMutableArray *actions;
}

static Scene *instance;
@synthesize root, sceneListeners, collisionMatrix, mainCamera;

- (id) initWithGame:(Game *)theGame {
	self = [super initWithGame:theGame];

	if(self) {
		instance = self;
		
		actions = [NSMutableArray array];
		sceneListeners = [NSMutableArray array];
		root = [[Node alloc] init];
		collisionMatrix = [[CollisionMatrix alloc] init];
		
		logicSystem = [[LogicSystem alloc] initWithGame:self.game
																scene:self];
		renderSystem = [[RenderSystem alloc] initWithGame:self.game
																  scene:self];
		physicsSystem = [[PhysicsSystem alloc] initWithGame:self.game
																	 scene:self];
		
		[[self.game components] addComponent:self];
	}
	
	return self;
}

- (void) initialize {
	[[self.game components] addComponent:logicSystem];
	[[self.game components] addComponent:renderSystem];
	[[self.game components] addComponent:physicsSystem];

	self.updateOrder = 0;
	logicSystem.updateOrder = 1;
	physicsSystem.updateOrder = 2;
	renderSystem.updateOrder = 3;
	
	Node *cameraNode = [self createNode];
	mainCamera = [cameraNode addComponentOfClass:[Camera class]];
	
	[super initialize];
}

- (Node *) createNode {
	return [self createNodeWithParent:root];
}

- (Node *) createNodeWithParent:(Node *) parent {
	Node *node = [[Node alloc] init];
	
	node.parent = parent;
	node.transform = [[Transform alloc] initWithNode:node];
	
	[actions addObject:[SceneAction createNode:node parent:parent]];
	
	return node;
}

- (void) destroyNode:(Node *) node {
	if(node != root) {
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

+ (Scene *) getInstance {
	return instance;
}

@end
