#import "RemoveComponentAction.h"
#import "Engine.Core.h"

@implementation RemoveComponentAction

@synthesize node, component;

- (void) performOnScene:(Scene *)scene {
	for(id<ISceneListener> sceneListener in scene.sceneListeners) {
		if([sceneListener respondsToSelector:@selector(onRemoveComponent:from:)]) {
			[sceneListener onRemoveComponent:component from:node];
		}
	}
	
	[component onRemove];

	[node.components removeObject:component];
}

@end
