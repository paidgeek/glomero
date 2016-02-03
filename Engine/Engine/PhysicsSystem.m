#import "PhysicsSystem.h"
#import "Engine.Core.h"

@implementation PhysicsSystem {
	Scene *scene;
	NSMutableArray *colliders;
}

- (id)initWithGame:(Game *)theGame scene:(Scene *)theScene {
	self = [super initWithGame:theGame];
	
	if(self) {
		scene = theScene;
		colliders = [NSMutableArray array];
		[scene.sceneListeners addObject:self];
		
		[CollisionDetection init];
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	for (id<IColliderComponent> collider in colliders) {
		[collider.node.transform translate:[Vector3 multiply:collider.velocity
																		  by:gameTime.elapsedGameTime]
										relativeTo:SpaceWorld];
	}
	
	/*
	for(id a in colliders) {
		for(id b in colliders) {
			if (a != b) {
				[CollisionDetection resolveCollisionBetween:a and:b];
			}
		}
	}
	*/
	for(int i = 0; i < colliders.count; i++) {
		for(int j = 0; j < i; j++) {
			if(i != j) {
				[CollisionDetection resolveCollisionBetween:[colliders objectAtIndex:i]
																	 and:[colliders objectAtIndex:j]];
			}
		}
	}
}

- (void)onAddComponent:(id<INodeComponent>)component to:(Node *)node {
	if([component conformsToProtocol:@protocol(IColliderComponent)]) {
		[colliders addObject:(id<IColliderComponent>) component];
	}
}

- (void)onRemoveComponent:(id<INodeComponent>)component from:(Node *)node {
	if([component conformsToProtocol:@protocol(IColliderComponent)]) {
		[colliders removeObject:(id<IColliderComponent>) component];
	}
}

@end
