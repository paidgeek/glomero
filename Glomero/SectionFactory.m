#import "SectionFactory.h"
#import "TINR.Glomero.h"

#define NUM_STATES 3

typedef enum {
	StateEmpty,
	StateTiled,
	StateHole
} State;

@interface SectionFactory ()
- (void) createEmpty:(Node *) node;
- (void) createTiled:(Node *) node;
- (void) createHole:(Node *) node;

- (Node *) createCoinWithParent:(Node *) parent;
@end

@implementation SectionFactory {
	Glomero *glomero;
	Scene *scene;
	
	float z;
	float chain[NUM_STATES][NUM_STATES];
	State state;
	int lastY;
	
	// coins
	Mesh *coinMesh;
}

- (id) init {
	self = [super init];
	
	if(self) {
		glomero = [Glomero getInstance];
		scene = [Scene getInstance];
		
		z = 0.0f;

		chain[StateEmpty][StateTiled] = 0.8f;
		chain[StateEmpty][StateHole] = 0.2f;
		
		chain[StateTiled][StateTiled] = 0.7f;
		chain[StateTiled][StateHole] = 0.3f;
		
		chain[StateHole][StateHole] = 0.1f;
		chain[StateHole][StateTiled] = 0.9f;
		
		state = StateEmpty;
		
		coinMesh = [Mesh loadFromFile:@"Coin" graphicsDevice:scene.game.graphicsDevice];
	}
	
	return self;
}

- (Node *) create {
	Node *node = [scene createNode];
	
	int y = 0;

	if([Random intLessThan:4] == 0) {
		switch (lastY) {
			case 0:
				y = [Random intLessThan:2] == 0 ? -1 : 1;
				break;
			case -1:
				y = 0;
				break;
			case 1:
				y = 0;
				break;
		}
	} else {
		y = lastY;
	}
	
	lastY = y;
	node.transform.position = [Vector3 vectorWithX:0.0f y:y z:z - SECTION_LENGTH / 2.0f];
	
	switch (state) {
		case StateEmpty:
			[self createEmpty:node];
			break;
		case StateTiled:
			[self createTiled:node];
			break;
		case StateHole:
			[self createHole:node];
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
	
	for(int x = -1; x <= 1; x++) {
		for(int z = -SECTION_LENGTH / 2; z < SECTION_LENGTH / 2; z++) {
			float r = [Random float];
			
			if(r < 0.1f) {
				Node *coin = [self createCoinWithParent:node];
				
				coin.transform.localPosition = [Vector3 vectorWithX:x y:1.0f z:z + 0.5f];
			} else if (r < 0.3f) {
				Node *cube = [scene createNodeWithParent:node];
				cube.transform.localPosition = [Vector3 vectorWithX:x y:1.0f z:z + 0.5f];
				
				MeshRenderer *mr = [cube addComponentOfClass:[MeshRenderer class]];
				mr.effect = glomero.platformEffect1;
				mr.mesh = [MeshFactory createCubeWithGraphicsDevice:scene.game.graphicsDevice
																			 width:1
																			height:1
																			 depth:1];
				
				AABoxCollider *collider = [cube addComponentOfClass:[AABoxCollider class]];
				// BUG: 0.25 instead of 0.5 coz i don't know
				collider.min = [Vector3 vectorWithX:-0.25f y:-0.5f z:-0.5f];
				collider.max = [Vector3 vectorWithX:0.25f y:0.5f z:0.5f];
			}
		}
	}
}

- (void)createHole:(Node *)node {
	Node *cube = [scene createNodeWithParent:node];
	cube.transform.localPosition = [Vector3 vectorWithX:0.0f y:0.0f z:SECTION_LENGTH / 2.0f - 1.0f];
	
	MeshRenderer *mr = [cube addComponentOfClass:[MeshRenderer class]];
	mr.effect = glomero.platformEffect2;
	mr.mesh = [MeshFactory createCubeWithGraphicsDevice:scene.game.graphicsDevice width:3 height:1 depth:2];
	
	AABoxCollider *collider = [cube addComponentOfClass:[AABoxCollider class]];
	collider.min = [Vector3 vectorWithX:-1.5f y:-0.5f z:-1.0f];
	collider.max = [Vector3 vectorWithX:1.5f y:0.5f z:1.0f];
	
	cube = [scene createNodeWithParent:node];
	cube.transform.localPosition = [Vector3 vectorWithX:0.0f y:0.0f z:-SECTION_LENGTH / 2.0f + 1.0f];
	
	mr = [cube addComponentOfClass:[MeshRenderer class]];
	mr.effect = glomero.platformEffect2;
	mr.mesh = [MeshFactory createCubeWithGraphicsDevice:scene.game.graphicsDevice width:3 height:1 depth:2];
	
	collider = [cube addComponentOfClass:[AABoxCollider class]];
	collider.min = [Vector3 vectorWithX:-1.5f y:-0.5f z:-1.0f];
	collider.max = [Vector3 vectorWithX:1.5f y:0.5f z:1.0f];
}

- (Node *)createCoinWithParent:(Node *)parent {
	Node *node = [scene createNodeWithParent:parent];
	
	MeshRenderer *mr = [node addComponentOfClass:[MeshRenderer class]];
	SphereCollider *collider = [node addComponentOfClass:[SphereCollider class]];
	
	mr.mesh = coinMesh;
	mr.effect = glomero.coinEffect;
	
	collider.radius = 0.45f;
	collider.trigger = YES;
	
	[node addComponentOfClass:[Coin class]];
	
	return node;
}

@end
