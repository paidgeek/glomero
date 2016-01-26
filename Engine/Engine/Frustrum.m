#import "Frustrum.h"
#import "Engine.Core.h"

@interface Frustrum ()

- (void) createPlanes;

@end

@implementation Frustrum {
	Matrix *matrix;
	Plane *planes[6];
}

- (id) init {
	self = [super init];
	
	if(self) {
		matrix = [Matrix identity];
		for(int i = 0; i < 6; i++) {
			planes[i] = [[Plane alloc] init];
		}
	}
	
	return self;
}

- (void)createPlanes {
	// BROKEN
	// near
	planes[0].normal.x = matrix.data->m14 + matrix.data->m11;
	planes[0].normal.y = matrix.data->m24 + matrix.data->m21;
	planes[0].normal.z = matrix.data->m34 + matrix.data->m31;
	planes[0].d        = matrix.data->m44 + matrix.data->m41;
	
	// far
	planes[1].normal.x = matrix.data->m14 - matrix.data->m11;
	planes[1].normal.y = matrix.data->m24 - matrix.data->m21;
	planes[1].normal.z = matrix.data->m34 - matrix.data->m31;
	planes[1].d        = matrix.data->m44 - matrix.data->m41;
	
	// left
	planes[2].normal.x = matrix.data->m14 + matrix.data->m12;
	planes[2].normal.y = matrix.data->m24 + matrix.data->m22;
	planes[2].normal.z = matrix.data->m34 + matrix.data->m32;
	planes[2].d        = matrix.data->m44 + matrix.data->m42;
	
	// right
	planes[3].normal.x = matrix.data->m14 - matrix.data->m12;
	planes[3].normal.y = matrix.data->m24 - matrix.data->m22;
	planes[3].normal.z = matrix.data->m34 - matrix.data->m32;
	planes[3].d        = matrix.data->m44 - matrix.data->m42;
	
	// top
	planes[4].normal.x = matrix.data->m14 + matrix.data->m13;
	planes[4].normal.y = matrix.data->m24 + matrix.data->m23;
	planes[4].normal.z = matrix.data->m34 + matrix.data->m33;
	planes[4].d        = matrix.data->m44 + matrix.data->m43;
	
	// bottom
	planes[5].normal.x = matrix.data->m14 - matrix.data->m13;
	planes[5].normal.y = matrix.data->m24 - matrix.data->m23;
	planes[5].normal.z = matrix.data->m34 - matrix.data->m33;
	planes[5].d        = matrix.data->m44 - matrix.data->m43;
	
	for(int i = 0; i < 6; i++) {
		[planes[i] normalize];
	}
}

- (BOOL)intersectsSphere:(BoundingSphere *)sphere {
	for(int i = 0; i < 6; i++) {
		Plane *plane = planes[i];
		
		if([sphere intersectsPlane:plane]) {
			return YES;
		}
	}
	
	return NO;
}

- (BOOL)intersectsPoint:(Vector3 *)point {
	return NO;
}

- (Matrix *)matrix {
	return matrix;
}

- (void)setMatrix:(Matrix *)theMatrix {
	matrix = theMatrix;
	
	[self createPlanes];
}

@end
