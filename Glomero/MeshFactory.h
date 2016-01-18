#import "TINR.Glomero.classes.h"

@interface MeshFactory : NSObject

+ (Mesh *) createCubeWithGraphicsDevice:(GraphicsDevice *) graphicsDevice width:(float) width height:(float) height depth:(float) depth;

@end
