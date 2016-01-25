#import "Engine.Graphics.classes.h"

@interface Mesh : NSObject

- (id) initWithGraphicsDevice:(GraphicsDevice *) graphicsDevice vertexArray:(VertexArray *) vertexArray indexArray:(IndexArray *) indexArray;

- (void) drawWithGraphicsDevice:(GraphicsDevice *) graphicsDevice;

@end