#import "SectionFactory.h"
#import "TINR.Glomero.h"

@implementation SectionFactory {
	float z;
}

- (id) init {
	self = [super init];
	
	if(self) {
		z = 0.0f;
	}
	
	return self;
}

- (Node *) create {
	Scene *scene = [Scene getInstance];
	Glomero *glomero = [Glomero getInstance];
	
	Node *node = [scene createNode];
	node.transform.position = [Vector3 vectorWithX:0.0f y:-0.5f z:z - SECTION_LENGTH / 2.0f];
	
	MeshRenderer *mr = [node addComponentOfClass:[MeshRenderer class]];
	mr.effect = glomero.platformEffect0;
	mr.mesh = [MeshFactory createCubeWithGraphicsDevice:scene.game.graphicsDevice
																 width:4
																height:1
																 depth:SECTION_LENGTH];
	
	/*
	for(int i = 0; i < 5; i++) {
		float x = [Random intGreaterThanOrEqual:-2 lessThan:2] + 0.5f;
		float z = [Random intLessThan:SECTION_LENGTH] + 0.5f;
		
		Node *cube = [scene createNodeWithParent:node];
		cube.transform.localPosition = [Vector3 vectorWithX:x y:1.0f z:z];
		
		MeshRenderer *mr = [cube addComponentOfClass:[MeshRenderer class]];
		mr.effect = glomero.platformEffect1;
		mr.mesh = [MeshFactory createCubeWithGraphicsDevice:scene.game.graphicsDevice width:1 height:1 depth:1];
	}
	*/
	
	z -= SECTION_LENGTH;
	
	return node;
}

@end
