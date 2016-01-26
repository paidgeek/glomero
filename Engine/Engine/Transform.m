#import "Transform.h"
#import "Engine.Core.h"

@interface Transform ()

- (Matrix *) getParentMatrix;

@end

@implementation Transform {
	Transform *parent;
}

@synthesize node, localPosition, localRotation, localScale;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		localPosition = [Vector3 zero];
		localRotation = [Quaternion identity];
		localScale = [Vector3 one];
	}
	
	return self;
}

- (void)translateX:(float)x y:(float)y z:(float)z {
	[self translate:[Vector3 vectorWithX:x y:y z:z] relativeTo:SpaceSelf];
}

- (void)translateX:(float)x y:(float)y z:(float)z relativeTo:(Space)relativeTo {
	[self translate:[Vector3 vectorWithX:x y:y z:z] relativeTo:relativeTo];
}

- (void)translate:(Vector3 *)translation {
	[self translate:translation relativeTo:SpaceSelf];
}

- (void)translate:(Vector3 *)translation relativeTo:(Space)relativeTo {
	if(relativeTo == SpaceWorld) {
		[localPosition add:translation];
	} else {
		float x = localRotation.x;
		float y = localRotation.y;
		float z = localRotation.z;
		float w = localRotation.w;
		float vx = translation.x;
		float vy = translation.y;
		float vz = translation.z;
		
		float nw = -x * vx - y * vy - z * vz;
		float nx = w * vx + y * vz - z * vy;
		float ny = w * vy + z * vx - x * vz;
		float nz = w * vz + x * vy - y * vx;
		
		Quaternion *q = [Quaternion multiply:[Quaternion quaternionWithX:nx y:ny z:nz w:nw] by:[Quaternion inverse:localRotation]];
		
		localPosition.x += q.x;
		localPosition.y += q.y;
		localPosition.z += q.z;
	}
}

- (void)rotateAround:(Vector3 *)axis by:(float)angle {
	[self rotateWithQuaternion:[Quaternion axis:axis angle:angle] relativeTo:SpaceWorld];
}

- (void)rotateAround:(Vector3 *)axis by:(float)angle relativeTo:(Space)relativeTo {
	[self rotateWithQuaternion:[Quaternion axis:axis angle:angle] relativeTo:relativeTo];
}

- (void)rotateWithQuaternion:(Quaternion *)theRotation relativeTo:(Space)relativeTo {
	switch (relativeTo) {
		case SpaceSelf:
			[localRotation set:[Quaternion normalize:[Quaternion multiply:localRotation by:theRotation]]];
			break;
		case SpaceWorld:
			[localRotation set:[Quaternion normalize:[Quaternion multiply:theRotation by:localRotation]]];
			break;
	}
}

- (void)lookAt:(Vector3 *)point {
	[self lookAt:point up:[Vector3 unitY]];
}

- (void)lookAt:(Vector3 *)point up:(Vector3 *)up {
	self.localRotation = [Quaternion rotationMatrix:[Matrix createLookAtFrom:self.position to:point up:up]];
}

- (void)setParent:(Transform *)theParent {
	[self setParent:theParent worldPositionStays:NO];
}

- (void) setParent:(Transform *)theParent worldPositionStays:(BOOL)worldPositionStays {
	if(worldPositionStays) {
		[localPosition transformWith:[Matrix invert:theParent.localToWorld]];
		localRotation = [Quaternion multiply:[Quaternion inverse:theParent.rotation] by:localRotation];
		
		Vector3 *ps = theParent.scale;
		
		localScale = [Vector3 vectorWithX:localScale.x / ps.x y:localScale.y / ps.y z:localScale.z / ps.z];
	}
	
	parent = theParent;
}

- (void)setPosition:(Vector3 *)thePosition {
	//localPosition = [[Vector3 vectorWithVector:thePosition] transformWith:[Matrix invert:[self getParentMatrix]]];

	float x = localRotation.x;
	float y = localRotation.y;
	float z = localRotation.z;
	float w = localRotation.w;
	float vx = thePosition.x;
	float vy = thePosition.y;
	float vz = thePosition.z;
	
	float nw = -x * vx - y * vy - z * vz;
	float nx = w * vx + y * vz - z * vy;
	float ny = w * vy + z * vx - x * vz;
	float nz = w * vz + x * vy - y * vx;
	
	Quaternion *q = [Quaternion multiply:[Quaternion quaternionWithX:nx y:ny z:nz w:nw] by:[Quaternion inverse:localRotation]];
	
	localPosition.x = q.x;
	localPosition.y = q.y;
	localPosition.z = q.z;
}

- (Vector3 *) position {
	return [[Vector3 vectorWithVector:localPosition] transformWith:[self getParentMatrix]];
}

- (void)setRotation:(Quaternion *)theRotation {
	localRotation = [Quaternion multiply:[Quaternion inverse:parent.rotation] by:theRotation];
}

- (Quaternion *) rotation {
	if(parent != nil) {
		return [parent.rotation multiplyBy:localRotation];
	}
	
	return [localRotation copy];
}

- (void)setScale:(Vector3 *)theScale {
	Vector3 *ps = parent.scale;
	localScale = [Vector3 vectorWithX:theScale.x / ps.x y:theScale.y / ps.y z:theScale.z / ps.z];
}

- (Vector3 *) scale {
	if(parent != nil) {
		Vector3 *ps = parent.scale;
		
		return [Vector3 vectorWithX:localScale.x*ps.x y:localScale.y*ps.y z:localScale.z*ps.z];
	}
	
	return localScale;
}

- (Matrix *)getParentMatrix {
	if(parent != nil) {
		return parent.localToWorld;
	}
	
	return [Matrix identity];
}

- (Matrix *) localToWorld {
	Matrix *t = [Matrix createTranslation:localPosition];
	Matrix *r = [Matrix createFromQuaternion:localRotation];
	Matrix *s = [Matrix createScale:localScale];
	
	//return [[self getParentMatrix] multiplyBy:[t multiplyBy:[r multiplyBy:s]]];
	return [s multiplyBy:[r multiplyBy:[t multiplyBy:[self getParentMatrix]]]];
}

@end
