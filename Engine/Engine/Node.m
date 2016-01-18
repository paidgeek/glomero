#import "Node.h"
#import "Engine.Core.h"

@implementation Node {
	Node *parent;
}

@synthesize components, children, transform, willBeDestroyed, tag;

- (id) init {
	self = [super init];
	
	if(self) {
		components = [NSMutableArray array];
		children = [NSMutableArray array];
		willBeDestroyed = NO;
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

- (void)setParent:(Node *)theParent {
	parent = theParent;
	
	[transform setParent:theParent.transform];
}

- (void)setParent:(Node *)theParent worldPositionStays:(BOOL)worldPositionStays {
	parent = theParent;
	
	[transform setParent:theParent.transform worldPositionStays:worldPositionStays];
}

- (Node *)parent {
	return parent;
}

@end
