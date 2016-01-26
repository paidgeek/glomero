#import "Plane.h"
#import "Engine.Core.h"

@implementation Plane

@synthesize normal, d;

- (id) init {
	self = [super init];
	
	if(self) {
		normal = [Vector3 zero];
		d = 0.0f;
	}
	
	return self;
}

- (id)initWithNormal:(Vector3 *)theNormal d:(float)theD {
	self = [super init];
	
	if(self) {
		d = theD;
		normal = theNormal;
	}
	
	return self;
}

- (Plane *)normalize {
	float f = 1.0f / [normal length];
	
	normal.x *= f;
	normal.y *= f;
	normal.z *= f;
	d *= f;
	
	return self;
}

+ (Plane *)planeWithNormalX:(float)x y:(float)y z:(float)z d:(float)d {
	return [[Plane alloc] initWithNormal:[Vector3 vectorWithX:x y:y z:z] d:d];
}

@end
