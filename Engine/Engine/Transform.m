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
	switch (relativeTo) {
		case SpaceWorld:
			localPosition = [localPosition add:translation];
			break;
		case SpaceSelf:
			// TODO
			break;
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
	localPosition = [[Vector3 vectorWithVector:thePosition] transformWith:[Matrix invert:[self getParentMatrix]]];
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
