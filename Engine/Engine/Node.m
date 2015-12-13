#import "Node.h"
#import "Engine.Core.h"

@implementation Node

@synthesize components, parent, children, transform;

- (id) init {
	self = [super init];
	
	if(self) {
		components = [NSMutableArray array];
		children = [NSMutableArray array];
	}
	
	return self;
}

- (id) addComponentOfClass:(Class)componentClass {
	if(componentClass == [Transform class]) {
		return nil;
	}
	
	id<INodeComponent> component = [[componentClass alloc] initWithNode:self];
	
	[[Scene getInstance] addAction:[SceneAction addComponent:component node:self]];

	return component;
}

- (void) removeComponentOfClass:(Class) componentClass {
	[self removeComponent:[self getComponentOfClass:componentClass]];
}

- (void) removeComponent:(id<INodeComponent>) component {
	[[Scene getInstance] addAction:[SceneAction removeComponent:component node:self]];
}

- (id) getComponentOfClass:(Class)componentClass {
	if(componentClass == [Transform class]) {
		return self.transform;
	}
	
	for(id<INodeComponent> component in self.components) {
		if([component class] == componentClass) {
			return component;
		}
	}
	
	return nil;
}

@end
