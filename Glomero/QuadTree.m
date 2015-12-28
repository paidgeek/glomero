#import "QuadTree.h"
#import "Engine.Core.h"

#define MAX_OBJECTS 5
#define MAX_LEVELS  5

@implementation QuadTree {
	QuadTree *nodes[4];
}

@synthesize level, bounds, objects;

- (id)initWithLevel:(int)theLevel bounds:(Rectangle *)theBounds {
	self = [super init];
	
	if(self) {
		level = theLevel;
		bounds = theBounds;
		objects = [NSMutableArray array];
	}
	
	return self;
}

- (void) clear {
	[objects removeAllObjects];
	
	for (int i = 0; i < 4; i++) {
		if(nodes[i]) {
			[nodes[i] clear];
		}
		
		nodes[i] = nil;
	}
}

- (void) split {
	float sw = roundf(bounds.width / 2.0f);
	float sh = roundf(bounds.height / 2.0f);
	float x = roundf(bounds.x);
	float y = roundf(bounds.y);
	
	nodes[0] = [[QuadTree alloc] initWithLevel:level + 1
													bounds:[Rectangle rectangleWithX:x + sw
																							 y:y
																						width:sw
																					  height:sh]];
	nodes[1] = [[QuadTree alloc] initWithLevel:level + 1
													bounds:[Rectangle rectangleWithX:x
																							 y:y
																						width:sw
																					  height:sh]];
	nodes[2] = [[QuadTree alloc] initWithLevel:level + 1
													bounds:[Rectangle rectangleWithX:x
																							 y:y + sh
																						width:sw
																					  height:sh]];
	nodes[3] = [[QuadTree alloc] initWithLevel:level + 1
													bounds:[Rectangle rectangleWithX:x + sw
																							 y:y + sh
																						width:sw
																					  height:sh]];
}

- (int) findNode:(id<IParticle>) circle {
	float vm = bounds.x + bounds.width / 2.0f;
	float hm = bounds.y + bounds.height / 2.0f;
	BOOL top = circle.position.y + circle.radius < hm;
	BOOL bottom = circle.position.y - circle.radius > hm;
	
	if(circle.position.x + circle.radius < vm) {
		if(top) {
			return 1;
		} else if(bottom) {
			return 2;
		}
	} else if(circle.position.x - circle.radius > vm) {
		if(top) {
			return 0;
		} else if(bottom) {
			return 3;
		}
	}
	
	return -1;
}

- (void) insertNode:(id<IParticle>) circle {
	if(nodes[0]) {
		int index = [self findNode:circle];
		
		if(index != -1) {
			[nodes[index] insertNode:circle];
			
			return;
		}
	}
	
	[objects addObject:circle];
	
	if([objects count] > MAX_OBJECTS && level < MAX_LEVELS) {
		if(!nodes[0]) {
			[self split];
		}

		for(int i = 0; i < [objects count];) {
			int index = [self findNode:[objects objectAtIndex:i]];
			
			if(index != -1) {
				id obj = [objects objectAtIndex:i];
				[objects removeObjectAtIndex:i];				
				
				[nodes[index] insertNode:obj];
			} else {
				i++;
			}
		}
	}
}

- (NSMutableArray *) retrieveForNode:(id<IParticle>) circle {
	int index = [self findNode:circle];
	NSMutableArray *arr = [NSMutableArray array];
	
	if(nodes[0]) {
		if(index != -1) {
			[arr addObjectsFromArray:[nodes[index] retrieveForNode:circle]];
		} else {
			for (int i = 0; i < 4; i++) {
				[arr addObjectsFromArray:[nodes[i] retrieveForNode:circle]];
			}
		}
	}
	
	return arr;
}

- (void)drawWithPrimitiveBatch:(PrimitiveBatch *)primitiveBatch {
	if(!nodes[0]) {
		[primitiveBatch drawRectangle:bounds color:[Color lightGreen]];
	} else {
		for (int i = 0; i < 4; i++) {
			[nodes[i] drawWithPrimitiveBatch:primitiveBatch];
		}
	}
}

@end
