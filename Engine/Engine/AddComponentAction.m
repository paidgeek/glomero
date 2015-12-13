#import "AddComponentAction.h"
#import "Engine.Core.h"

@implementation AddComponentAction

@synthesize node, component;

- (void) performOnScene:(Scene *)scene {
	[node.components addObject:component];

	if([component respondsToSelector:@selector(onAdd)]) {
		[component onAdd];
	}
	
	for(id<ISceneListener> sceneListener in scene.sceneListeners) {
		if([sceneListener respondsToSelector:@selector(onAddComponent:to:)]) {
			[sceneListener onAddComponent:component to:node];
		}
	}
}

@end
