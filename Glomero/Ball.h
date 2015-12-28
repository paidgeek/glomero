//
//  Ball.h
//  Physics World 1
//
//  Created by Matej Jan on 9.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.h"
#import "Express.Scene.Objects.h"

@interface Ball : NSObject <IParticle, ICoefficientOfRestitution> {
	Vector2 *position;
	Vector2 *velocity;
	float radius;
	float mass;
	float coefficientOfRestitution;
}

@end