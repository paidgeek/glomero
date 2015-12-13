#import "CollisionMatrix.h"
#import "Engine.Core.h"

@implementation CollisionMatrix {
	BOOL matrix[32][32];
}

- (BOOL) enabledBetweenA:(int)a b:(int)b {
	return matrix[a][b] || matrix[b][a];
}

- (void) enableBetweenA:(int)a b:(int)b {
	matrix[a][b] = YES;
	matrix[b][a] = YES;
}

- (void) disableBetweenA:(int)a b:(int)b {
	matrix[a][b] = NO;
	matrix[b][a] = NO;
}

@end
