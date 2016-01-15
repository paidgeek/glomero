#import "Camera.h"
#import "Engine.Core.h"

@interface Camera ()

- (void) resize;

@end

@implementation Camera

@synthesize node, projection, color;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		projection = [Matrix identity];
		color = [Color black];
		[self resize];
	}
	
	return self;
}

- (Matrix *)getViewProjection {
	float width = [Scene getInstance].game.gameWindow.clientBounds.width;
	float height = [Scene getInstance].game.gameWindow.clientBounds.height;
	
	return [Matrix multiply:projection
								by:[Matrix createTranslationX:width / 2.0f -node.transform.position.x
																	 y:height / 2.0f -node.transform.position.y
																	 z:0.0f]];
}

- (void) resize {
	float width = [Scene getInstance].game.gameWindow.clientBounds.width / 320.0f;
	float height = [Scene getInstance].game.gameWindow.clientBounds.height / 480.0f;
	
	[projection set:[Matrix createOrthographicOffCenterWithLeft:0 right:width bottom:0 top:height zNearPlane:-10 zFarPlane:10]];
}

@end
