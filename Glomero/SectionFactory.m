#import "SectionFactory.h"
#import "TINR.Glomero.h"

#define NUM_STATES 2

typedef enum {
	StateEmpty,
	StateTiled
} State;

@interface SectionFactory ()
- (void) createEmpty:(Node *) node;
- (void) createTiled:(Node *) node;
@end

@implementation SectionFactory {
	Glomero *glomero;
	Scene *scene;
	
	float z;
	float chain[NUM_STATES][NUM_STATES];
	State state;
}

- (id) init {
	self = [super init];
	
	if(self) {
		glomero = [Glomero getInstance];
		scene = [Scene getInstance];
		
		z = 0.0f;
		
		chain[StateEmpty][StateEmpty] = 0.5f;
		chain[StateEmpty][StateTiled] = 0.5f;
		
		chain[StateTiled][StateEmpty] = 0.4f;
		chain[StateTiled][StateTiled] = 0.6f;
		
		state = StateEmpty;
	}
	
	return self;
}

- (Node *) create {
	Node *node = [scene createNode];
	node.transform.position = [Vector3 vectorWithX:0.0f y:-0.5f z:z - SECTION_LENGTH / 2.0f];
	
	switch (state) {
		case StateEmpty:
			[self createEmpty:node];
			break;
		case StateTiled:
			[self createTiled:node];
			break;
	}
	
	z -= SECTION_LENGTH;
	
	float r = [Random float];
	float sum = 0.0f;
	
	for(int i = 0; i < NUM_STATES; i++) {
		sum += chain[state][i];
		
		if(r <= sum) {
			state = i;
			
			break;
		}
	}
	
	return node;
}

-(void)createEmpty:(Node *)node {
	MeshRenderer *mr = [node addComponentOfClass:[MeshRenderer class]];
	mr.effect = glomero.platformEffect0;
	mr.mesh = [MeshFactory createCubeWithGraphicsDevice:scene.game.graphicsDevice
																 width:3
																height:1
																 depth:SECTION_LENGTH];
	AABoxCollider *collider = [node addComponentOfClass:[AABoxCollider class]];
	collider.min = [Vector3 vectorWithX:-1.5f y:-0.5f z:-SECTION_LENGTH / 2.0f];
	collider.max = [Vector3 vectorWithX:1.5f y:0.5f z:SECTION_LENGTH / 2.0f];
}

-(void)createTiled:(Node *)node {
	MeshRenderer *mr = [node addComponentOfClass:[MeshRenderer class]];
	mr.effect = glomero.platformEffect0;
	mr.mesh = [MeshFactory createCubeWithGraphicsDevice:scene.game.graphicsDevice
																 width:3
																height:1
																 depth:SECTION_LENGTH];
	AABoxCollider *collider = [node addComponentOfClass:[AABoxCollider class]];
	collider.min = [Vector3 vectorWithX:-1.5f y:-0.5f z:-SECTION_LENGTH / 2.0f];
	collider.max = [Vector3 vectorWithX:1.5f y:0.5f z:SECTION_LENGTH / 2.0f];
	
	for(int i = 0; i < 5; i++) {
		float x = [Random intGreaterThanOrEqual:-2 lessThan:2] + 0.5f;
		float z = [Random intLessThan:SECTION_LENGTH] + 0.5f;
		
		Node *cube = [scene createNodeWithParent:node];
		cube.transform.localPosition = [Vector3 vectorWithX:x y:1.0f z:z];
		
		MeshRenderer *mr = [cube addComponentOfClass:[MeshRenderer class]];
		mr.effect = glomero.platformEffect1;
		mr.mesh = [MeshFactory createCubeWithGraphicsDevice:scene.game.graphicsDevice width:1 height:1 depth:1];
	}
}

@end
