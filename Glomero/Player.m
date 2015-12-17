#import "Player.h"
#import "TINR.Glomero.h"

@implementation Player {
	int pathIndex;
}

static Player *instance;

@synthesize node, path;

- (id) initWithNode:(Node *) theNode {
	self = [super init];
	
	if(self) {
		instance = self;
		
		node = theNode;
	}
	
	return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	if(path != nil) {
		Vector2 *wp = [path objectAtIndex:pathIndex];
		
		wp = [Vector2 multiply:wp by:128.0f];
		
		Vector2 *d = [Vector2 subtract:wp by:node.transform.position];
		
		if([d length] < 30) {
			pathIndex++;
			
			if(pathIndex == [path count]) {
				pathIndex = 0;
				path = nil;
			}
			
			return;
		}
		
		[node.transform.position add:[Vector2 multiply:[Vector2 normalize:d] by:gameTime.elapsedGameTime * 1500]];
		
		if( [d length] < 30) {
			pathIndex++;
		}
		
		if(pathIndex == [path count]) {
			pathIndex = 0;
			path = nil;
		}
	}
}

+ (Player *)getInstance {
	return instance;
}

@end
