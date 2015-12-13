#import "DestroyNodeAction.h"
#import "Engine.Core.h"

@implementation DestroyNodeAction

@synthesize node;

- (void) performOnScene:(Scene *)scene {
	for(id<ISceneListener> sceneListener in scene.sceneListeners) {
		if([sceneListener respondsToSelector:@selector(onDestroyNode:)]) {
			[sceneListener onDestroyNode:node];
		}
	}
	
	for(id<INodeComponent> component in node.components) {
		if([component respondsToSelector:@selector(onRemove)]) {
			[component onRemove];
		}
	}

	[[node.parent children] removeObject:node];
}

@end
