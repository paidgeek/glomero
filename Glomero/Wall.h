#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.h"
#import "Express.Scene.Objects.h"
#import "ConvexPolygon.h"

@interface Wall : NSObject<IConvexCollider, IPosition>

- (id) initWithBounds:(ConvexPolygon *) theBounds;

@end
