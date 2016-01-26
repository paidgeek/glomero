#import "LevelGenerator.h"
#import "TINR.Glomero.h"

@implementation LevelGenerator {
	SectionFactory *sectionFactory;
	Transform *camera;
	float lastZ;
}

static LevelGenerator *instance;

@synthesize node, far;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		instance = self;
		
		node = theNode;
		camera = [Scene getInstance].mainCamera.node.transform;
	
		sectionFactory = [[SectionFactory alloc] init];
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	if(camera.position.z - lastZ <= far) {
		lastZ = [sectionFactory create].transform.position.z;
	}
}

+ (LevelGenerator *)getInstance {
	return instance;
}

@end
