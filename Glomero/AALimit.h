//
//  AALimit.h
//  Physics World 1
//
//  Created by Matej Jan on 10.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Express.Math.classes.h"
#import "Express.Scene.Objects.classes.h"

@interface AALimit : NSObject <IAAHalfPlaneCollider> {
	AAHalfPlane *limit;
}

- (id) initWithLimit:(AAHalfPlane*)theLimit;

@end