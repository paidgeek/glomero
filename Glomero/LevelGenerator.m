#import "LevelGenerator.h"
#import "TINR.Glomero.h"

@implementation LevelGenerator {
	SectionFactory *sectionFactory;
	Transform *camera;
	float lastZ;
	NSMutableArray *sections;
}

static LevelGenerator *instance;

@synthesize node, far;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		instance = self;
		
		node = theNode;
		camera = [Scene getInstance].mainCamera.node.transform;
		sections = [NSMutableArray array];
		sectionFactory = [[SectionFactory alloc] init];
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	if(camera.position.z - lastZ <= far + SECTION_LENGTH) {
		Node *section = [sectionFactory create];
		lastZ = section.transform.position.z;
		
		[sections addObject:section];
	}
	
	if(sections.count > 0) {
		Node *first = [sections objectAtIndex:0];
		
		if(camera.position.z < first.transform.position.z - SECTION_LENGTH) {
			[[Scene getInstance] destroyNode:first];
			[sections removeObjectAtIndex:0];
		}
	}
}

+ (LevelGenerator *)getInstance {
	return instance;
}

@end
