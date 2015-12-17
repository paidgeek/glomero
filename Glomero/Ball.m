//
//  Ball.m
//  Physics World 1
//
//  Created by Matej Jan on 9.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Ball.h"


@implementation Ball

- (id) init
{
	self = [super init];
	if (self != nil) {
		position = [[Vector2 alloc] init];
		velocity = [[Vector2 alloc] init];
		coefficientOfRestitution = 0.85;
	}
	return self;
}

@synthesize position, velocity, mass, radius, coefficientOfRestitution;

@end
