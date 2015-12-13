#import "CreateNodeAction.h"
#import "Engine.Core.h"

@implementation CreateNodeAction

@synthesize node, parent;

- (void) performOnScene:(Scene *)scene {
	[[parent children] addObject:node];
	
	for(id<INodeComponent> component in node.components) {
		if([component performSelector:@selector(onAdd)]) {
			[component onAdd];
		}
	}
	
	for(id<ISceneListener> sceneListener in scene.sceneListeners) {
		if([sceneListener respondsToSelector:@selector(onCreateNode:)]) {
			[sceneListener onCreateNode:node];
		}
	}
}

@end
