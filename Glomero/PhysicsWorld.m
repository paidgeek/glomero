#import "PhysicsWorld.h"
#import "Artificial.Everywhere.h"
#import "Express.Physics.h"
#import "Express.Scene.Objects.h"
#import "TINR.Glomero.h"

#import "Express.Math.h"
#import "AALimit.h"
#import "Ball.h"
#import "PrimitiveBatch.h"
#import "QuadTree.h"
#import "FpsComponent.h"

@implementation PhysicsWorld {
	NSMutableArray *items;
	PrimitiveBatch *primitiveBatch;
	BOOL useQuadTree;
	QuadTree *quadTree;
	AALimit *limits[4];
}

- (id) init {
	self = [super init];
	
	if (self) {
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
		graphics.isFullScreen = YES;
		self.isFixedTimeStep = NO;
		
		items = [NSMutableArray array];
		
		useQuadTree = NO;
		quadTree = [[QuadTree alloc] initWithLevel:0 bounds:[Rectangle rectangleWithX:40 y:40 width:600-40 height:900-40]];
	}
	
	return self;
}

- (void) initialize {
	primitiveBatch = [[PrimitiveBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
	
	limits[0] = [[AALimit alloc] initWithLimit:[AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionNegativeY distance:-900]];
	limits[1] = [[AALimit alloc] initWithLimit:[AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionPositiveX distance:40]];
	limits[2] = [[AALimit alloc] initWithLimit:[AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionNegativeX distance:-600]];
	limits[3] = [[AALimit alloc] initWithLimit:[AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionPositiveY distance:40]];
	
	[self.components addComponent:[[FpsComponent alloc] initWithGame:self]];
	
	for(int i = 0; i < 100; i++) {
		Ball *ball = [[Ball alloc] init] ;
		ball.radius = 10 + [Random float] * 10;
		ball.mass = ball.radius * ball.radius * 0.1f;
		ball.coefficientOfRestitution = 1.0;
		[ball.position set:[Vector2 vectorWithX:[Random float] * 600 + 40
														  y:[Random float] * 900 + 40]];
		
		ball.velocity = [[Vector2 vectorWithX:[Random float]-0.5f y:[Random float]-0.5f]
							  multiplyBy:400.0f];
		[items addObject:ball];
	}
	
	[super initialize];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	// Input
	TouchCollection *touches = [TouchPanel getState];
	
	for (TouchLocation *touch in touches) {
		if (touch.state == TouchLocationStatePressed) {
			useQuadTree = !useQuadTree;
		}
	}
	
	// Physics
	if(useQuadTree) {
		[quadTree clear];
		
		for (id item in items) {
			[MovementPhysics simulateMovementOn:item withElapsed:gameTime.elapsedGameTime];
			
			[quadTree insertNode:(id<IParticle>) item];
		}
		
		for (id item in items) {
			id others = [quadTree retrieveForNode:item];
			
			for(id other in others) {
				if(item != other) {
					[Collision collisionBetween:item and:other];
				}
			}
			
			for(int i = 0; i < 4; i++) {
				[Collision collisionBetween:item and:limits[i]];
			}
		}
	} else {
		for (id item in items) {
			[MovementPhysics simulateMovementOn:item withElapsed:gameTime.elapsedGameTime];
		}
		
		for (id item1 in items) {
			for (id item2 in items) {
				if (item1 != item2) {
					[Collision collisionBetween:item1 and:item2];
				}
			}
			
			for(int i = 0; i < 4; i++) {
				[Collision collisionBetween:item1 and:limits[i]];
			}
		}
	}
	
	[super updateWithGameTime:gameTime];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	[self.graphicsDevice clearWithColor:[Color black]];
	
	[primitiveBatch begin];
	
	for(id item in items) {
		Ball *ball = (Ball *) item;
		
		[primitiveBatch drawCircleAt:ball.position radius:ball.radius divisions:100 color:[Color red]];
	}
	
	for(int i = 0; i < 4; i++) {
		HalfPlane *halfPlane = ((AALimit *) limits[i]).aaHalfPlane;
		
		Vector2 *p = [Vector2 multiply:halfPlane.normal by:halfPlane.distance];
		
		Matrix *m = [Matrix createRotationZ:M_PI/2.0f];
		
		Vector2 *p1 = [Vector2 add:p to:[Vector2 multiply:[Vector2 normalize:[Vector2 transform:p with:m]] by:1000.0f]];
		Vector2 *p2 = [Vector2 add:p to:[Vector2 multiply:[Vector2 normalize:[Vector2 transform:p with:m]] by:-1000.0f]];
		
		[primitiveBatch drawLineFrom:p1 to:p2 color:[Color white]];
	}
	
	if(useQuadTree) {
		[quadTree drawWithPrimitiveBatch:primitiveBatch];
	}
	
	[primitiveBatch end];
	
	[super drawWithGameTime:gameTime];
}

@end