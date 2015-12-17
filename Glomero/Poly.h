#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.h"
#import "Express.Scene.Objects.h"
#import "IConvexCollider.h"
#import "ConvexPolygon.h"

@interface Poly : NSObject<IRectangleCollider, IMass, IMovable, ICoefficientOfRestitution>

@end
