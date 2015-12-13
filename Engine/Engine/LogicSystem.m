#import "LogicSystem.h"
#import "Engine.Core.h"

@implementation LogicSystem {
	Scene *scene;
}

- (id) initWithGame:(Game *) theGame scene:(Scene *) theScene{
	self = [super initWithGame:theGame];
	
	if(self) {
		scene = theScene;
	}
	
	return self;
}

- (void) updateWithGameTime:(GameTime *) gameTime {
	[self updateNode:scene.root gameTime:gameTime];
}

- (void) updateNode:(Node *) node gameTime:(GameTime *) gameTime {
	for(id<INodeComponent> component in node.components) {
		if([component respondsToSelector:@selector(updateWithGameTime:)]) {
			[component updateWithGameTime:gameTime];
		}
	}
	
	for(Node *child in node.children) {
		[self updateNode:child gameTime:gameTime];
	}
}

@end
