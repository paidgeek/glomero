//
//  AALimit.m
//  Physics World 1
//
//  Created by Matej Jan on 10.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "AALimit.h"


@implementation AALimit

- (id) initWithLimit:(AAHalfPlane *)theLimit
{
	self = [super init];
	if (self != nil) {
		limit = theLimit;
	}
	return self;
}

- (AAHalfPlane *) aaHalfPlane {
	return limit;
}

- (HalfPlane *) halfPlane {
	return limit;
}

@end