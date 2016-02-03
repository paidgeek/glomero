#import "DestroyNodeAction.h"
#import "Engine.Core.h"

@interface DestroyNodeAction ()
- (void) fireRemoveComponentFrom:(Node *) node with:(id<ISceneListener>) sceneListener;
@end

@implementation DestroyNodeAction

@synthesize node;

- (void) performOnScene:(Scene *)scene {
	for(id<ISceneListener> sceneListener in scene.sceneListeners) {
		[self fireRemoveComponentFrom:node with:sceneListener];
		
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

- (void)fireRemoveComponentFrom:(Node *)node with:(id<ISceneListener>)sceneListener {
	if([sceneListener respondsToSelector:@selector(onRemoveComponent:from:)]){
		for(id<INodeComponent> component in node.components) {
			[sceneListener onRemoveComponent:component from:node];
		}
	}
	
	for(Node *child in node.children) {
		[self fireRemoveComponentFrom:child with:sceneListener];
	}
}

@end
