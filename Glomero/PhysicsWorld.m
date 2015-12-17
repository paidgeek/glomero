#import "PhysicsWorld.h"
#import "Artificial.Everywhere.h"
#import "Express.Physics.h"
#import "Express.Scene.Objects.h"
#import "TINR.Glomero.h"

#import "Express.Math.h"
#import "AALimit.h"
#import "Ball.h"
#import "Box.h"
#import "PrimitiveBatch.h"
#import "Poly.h"

@implementation PhysicsWorld {
	NSMutableArray *items;
	PrimitiveBatch *primitiveBatch;
}

- (id) init {
	self = [super init];
	
	if (self) {
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
		graphics.isFullScreen = YES;
		self.isFixedTimeStep = NO;
		
		items = [NSMutableArray array];
	}
	
	return self;
}

- (void) initialize {
	primitiveBatch = [[PrimitiveBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
	
	AALimit *floor = [[AALimit alloc] initWithLimit:[AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionNegativeY distance:-900]];
	[items addObject: floor];
	
	AALimit *leftWall = [[AALimit alloc] initWithLimit:[AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionPositiveX distance:40]];
	[items addObject: leftWall];
	
	AALimit *rightWall = [[AALimit alloc] initWithLimit:[AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionNegativeX distance:-600]] ;
	[items addObject: rightWall];
	
	AALimit *ceiling = [[AALimit alloc] initWithLimit:[AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionPositiveY distance:40]];
	[items addObject: ceiling];
	
	[super initialize];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	// Input
	TouchCollection *touches = [TouchPanel getState];
	
	for (TouchLocation *touch in touches) {
		if (touch.state == TouchLocationStatePressed) {
				Ball *ball = [[Ball alloc] init] ;
				ball.radius = 10 + [Random float] * 100;
				ball.mass = ball.radius * ball.radius * 0.1f;
				ball.coefficientOfRestitution = 0.9;
				[ball.position set:touch.position];
			
				ball.velocity = [[Vector2 vectorWithX:[Random float]-0.5f y:[Random float]-0.5f] multiplyBy:400.0f];
			
				[items addObject:ball];
		}
	}
	
	// Physics
	for (id item in items) {
		[MovementPhysics simulateMovementOn:item withElapsed:gameTime.elapsedGameTime];
	}
	
	for (id item1 in items) {
		for (id item2 in items) {
			if (item1 != item2) {
				[Collision collisionBetween:item1 and:item2];
			}
		}
	}
	
	[super updateWithGameTime:gameTime];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	[self.graphicsDevice clearWithColor:[Color black]];
	
	for(id item in items) {
		if([item class] == [Ball class]) {
			Ball *ball = (Ball *) item;
			
			[primitiveBatch begin];
			[primitiveBatch drawCircleAt:ball.position radius:ball.radius divisions:100 color:[Color red]];
			[primitiveBatch end];
		} else if([item class] == [AALimit class]) {
			HalfPlane *halfPlane = ((AALimit *) item).aaHalfPlane;

			Vector2 *p = [Vector2 multiply:halfPlane.normal by:halfPlane.distance];
			
			Matrix *m = [Matrix createRotationZ:M_PI/2.0f];

			Vector2 *p1 = [Vector2 add:p to:[Vector2 multiply:[Vector2 normalize:[Vector2 transform:p with:m]] by:1000.0f]];
			Vector2 *p2 = [Vector2 add:p to:[Vector2 multiply:[Vector2 normalize:[Vector2 transform:p with:m]] by:-1000.0f]];
			
			[primitiveBatch begin];
			[primitiveBatch drawLineFrom:p1 to:p2 color:[Color white]];
			[primitiveBatch end];
		} else if([item class] == [Box class]) {
			Box *box = (Box *) item;
			
			[primitiveBatch begin];
			[primitiveBatch drawRectangleAt:box.position width:box.width height:box.height color:[Color red]];
			[primitiveBatch end];
		} else if([item class] == [Poly class]) {
			Poly *poly = (Poly *) item;
			
			[primitiveBatch beginWithBlendState:[BlendState additive]
									DepthStencilState:nil
									  RasterizerState:nil
												  Effect:nil
									  TransformMatrix:[Matrix createRotationZ:poly.rotationAngle]];
			[primitiveBatch drawRectangleAt:poly.position width:poly.width height:poly.height color:[Color red]];
			[primitiveBatch end];
		}
	}
	
	[super drawWithGameTime:gameTime];
}

@end
