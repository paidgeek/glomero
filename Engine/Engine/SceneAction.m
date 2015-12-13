#import "SceneAction.h"
#import "Engine.Core.h"

@implementation SceneAction

+ (id<ISceneAction>) createNode:(Node *)node parent:(Node *) parent {
	CreateNodeAction *action = [[CreateNodeAction alloc] init];
	
	action.node = node;
	action.parent = parent;
	
	return action;
}

+ (id<ISceneAction>) destroyNode:(Node *)node {
	DestroyNodeAction *action = [[DestroyNodeAction alloc] init];
	
	action.node = node;
	
	return action;
}

+ (id<ISceneAction>) addComponent:(id<INodeComponent>)component node:(Node *)node {
	AddComponentAction *action = [[AddComponentAction alloc] init];
	
	action.node = node;
	action.component = component;
	
	return action;
}

+ (id<ISceneAction>) removeComponent:(id<INodeComponent>)component node:(Node *)node {
	RemoveComponentAction *action = [[RemoveComponentAction alloc] init];
	
	action.node = node;
	action.component = component;
	
	return action;
}

@end
