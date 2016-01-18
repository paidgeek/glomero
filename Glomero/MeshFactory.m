#import "TINR.Glomero.h"
#import "MeshFactory.h"

@implementation MeshFactory

+ (Mesh *) createCubeWithGraphicsDevice:(GraphicsDevice *) graphicsDevice width:(float) width height:(float) height depth:(float) depth {
	VertexPositionNormalTextureArray *texturedVertexArray = [[VertexPositionNormalTextureArray alloc] initWithInitialCapacity:24];
	VertexPositionNormalTextureStruct vertex;
	
	{
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = -1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = -1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = -1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = -1.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = -1.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = -1.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 1.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 1.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 1.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = -1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = -1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = -1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = -1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = -1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = -1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = -1.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = -1.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = -1.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 1.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 1.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 1.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 0.0;
		vertex.normal.z = 1.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = -1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = -0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = -1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = -0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = -1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = 0.5;
		vertex.position.y = 0.5;
		vertex.position.z = -0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 1.0;
		vertex.texture.y = 1.0;
		[texturedVertexArray addVertex:&vertex];
		
		vertex.position.x = -0.5;
		vertex.position.y = 0.5;
		vertex.position.z = 0.5;
		vertex.normal.x = 0.0;
		vertex.normal.y = 1.0;
		vertex.normal.z = 0.0;
		vertex.texture.x = 0.0;
		vertex.texture.y = 0.0;
		[texturedVertexArray addVertex:&vertex];
	}
	
	// Index array
	IndexArray *indexArray = [[ShortIndexArray alloc] initWithInitialCapacity:36];
	int indices[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35};
	
	for (int i = 0; i < 36; i++) {
		[indexArray addIndex:(void*)indices[i]];
	}
	
	return [[Mesh alloc] initWithGraphicsDevice:graphicsDevice
											  vertexArray:texturedVertexArray
												indexArray:indexArray];
}

@end
