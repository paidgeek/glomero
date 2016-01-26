#import "Camera.h"
#import "Engine.Core.h"

@implementation Camera

@synthesize node, projection, clearColor;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		clearColor = [Color black];
		projection = [Matrix identity];
	}
	
	return self;
}

- (Matrix *) view {
	Matrix *r = [Matrix createFromQuaternion:[Quaternion inverse:node.transform.rotation]];
	Matrix *t = [Matrix createTranslation:[Vector3 negate:node.transform.position]];
	
	return [r multiplyBy:t];
}

- (Matrix *) viewProjection {
	return [Matrix multiply:projection by:self.view];
}

- (Vector3 *)viewportPointFromWorld:(Vector3 *)worldPosition {
	Vector3 *vp = [worldPosition transformWith:self.viewProjection];
	
	vp.x /= vp.z;
	vp.y /= vp.z;
	
	return vp;
}

@end
