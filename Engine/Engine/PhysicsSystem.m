#import "PhysicsSystem.h"
#import "Engine.Core.h"
#import "Express.Physics.h"

@implementation PhysicsSystem {
	Scene *scene;
	NSMutableArray *bodies;
	NSMutableDictionary *trigerStates;
}

- (id) initWithGame:(Game *) theGame scene:(Scene *) theScene{
	self = [super initWithGame:theGame];
	
	if(self) {
		scene = theScene;
		[scene.sceneListeners addObject:self];
		bodies = [NSMutableArray array];
		trigerStates = [NSMutableDictionary dictionary];
	}
	
	return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	for(RigidBody2D *body in bodies) {
		[body.node.transform.position add:[Vector2 multiply:body.velocity by:gameTime.elapsedGameTime]];
		
		id<IMovable> movable = (id<IMovable>) body.collider;
		
		movable.velocity = body.velocity;
		movable.position = body.node.transform.position;
	}
	
	for(RigidBody2D *body1 in bodies) {
		for(RigidBody2D *body2 in bodies) {
			if(body1 != body2 && !body1.node.willBeDestroyed && !body2.node.willBeDestroyed) {
				if([scene.collisionMatrix enabledBetweenA:body1.node.layer b:body2.node.layer]) {
					/*
					((id<IMovable>) body1.collider).velocity = body1.velocity;
					((id<IMovable>) body2.collider).velocity = body2.velocity;
					[((id<IPosition>) body1.collider) setPosition:body1.node.transform.position];
					[((id<IPosition>) body2.collider) setPosition:body2.node.transform.position];
					*/
					
					if(body1.collider.isTrigger || body2.collider.isTrigger) {
						if([Collision detectCollisionBetween:body1.collider and:body2.collider]) {
							if(body1.collider.isTrigger) {
								for(id<ICollisionListener> collisionListener in body2.collisionListeners) {
									if([collisionListener respondsToSelector:@selector(onTriggerEnter:)]) {
										[collisionListener onTriggerEnter:body1];
									}
								}
							}
							
							if(body2.collider.isTrigger) {
								for(id<ICollisionListener> collisionListener in body1.collisionListeners) {
									if([collisionListener respondsToSelector:@selector(onTriggerEnter:)]) {
										[collisionListener onTriggerEnter:body2];
									}
								}
							}
						}
					} else {
						[Collision collisionBetween:body1.collider and:body2.collider];
					}
					
					/*
					body1.velocity = ((id<IMovable>) body1.collider).velocity;
					body1.node.transform.position = ((id<IMovable>) body1.collider).position;
					
					body2.velocity = ((id<IMovable>) body2.collider).velocity;
					body2.node.transform.position = ((id<IMovable>) body2.collider).position;
					 */
				}
			}
		}
	}
	
	for(RigidBody2D *body in bodies) {
		[body.node.transform.position add:[Vector2 multiply:body.velocity by:gameTime.elapsedGameTime]];
		
		id<IMovable> movable = (id<IMovable>) body.collider;
		
		body.velocity = movable.velocity;
		body.node.transform.position = movable.position;
	}
}

- (void) onAddComponent:(id<INodeComponent>)component to:(Node *)node {
	if([component class] == [RigidBody2D class]) {
		[bodies addObject:(RigidBody2D *) component];
	}
}

@end
