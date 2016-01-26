#import "BoundingBox.h"
#import "Engine.Core.h"

@implementation BoundingBox

@synthesize min, max;

- (id) init {
	self = [super init];
	
	if(self) {
		min = [Vector3 zero];
		max = [Vector3 zero];
	}
	
	return self;
}

float check(float pn, float bmin, float bmax) {
	float res = 0.0f;
	float v = pn;
	
	if(v < bmin) {
		float val = bmin - v;
		res += val * val;
	}
	
	if(v > bmax) {
		float val = v - bmax;
		res += val * val;
	}
	
	return res;
}

- (BOOL)intersectsSphere:(BoundingSphere *)sphere {
	float squaredDistance = 0.0f;
	
	squaredDistance += check(sphere.center.x, min.x, max.x);
	squaredDistance += check(sphere.center.y, min.y, max.y);
	squaredDistance += check(sphere.center.z, min.z, max.z);
	
	return squaredDistance <= sphere.radius * sphere.radius;
}

+ (BoundingBox *)boxWithSize:(Vector3 *)size {
	return [BoundingBox boxWithSize:size center:[Vector3 zero]];
}

+ (BoundingBox *)boxWithSize:(Vector3 *)size center:(Vector3 *)center {
	Vector3 *hs = [Vector3 multiply:size by:0.5f];
	
	return [BoundingBox boxWithMin:[Vector3 subtract:center by:hs] max:[Vector3 add:center to:hs]];
}

+ (BoundingBox *)boxWithMin:(Vector3 *)min max:(Vector3 *)max {
	BoundingBox *box = [[BoundingBox alloc] init];
	
	box.min = min;
	box.max = max;
	
	return box;
}

@end
