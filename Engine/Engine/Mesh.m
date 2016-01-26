#import "Engine.Graphics.h"
#import "Mesh.h"

@implementation Mesh {
	VertexBuffer *vertexBuffer;
	IndexBuffer *indexBuffer;
	int numVertices, primitiveCount;
}

@synthesize boundingSphere;

- (id) initWithGraphicsDevice:(GraphicsDevice *) graphicsDevice vertexArray:(VertexArray *) vertexArray indexArray:(IndexArray *) indexArray {
	self = [super init];
	
	if(self) {
		numVertices = vertexArray.count;
		primitiveCount = indexArray.count / 3;
		
		vertexBuffer = [[VertexBuffer alloc] initWithGraphicsDevice:graphicsDevice
																vertexDeclaration:vertexArray.vertexDeclaration
																		vertexCount:numVertices
																				usage:BufferUsageWriteOnly];
		[vertexBuffer setData:vertexArray];
		
		indexBuffer = [[IndexBuffer alloc] initWithGraphicsDevice:graphicsDevice
															  indexElementSize:IndexElementSizeSixteenBits
																	  indexCount:primitiveCount * 3
																			 usage:BufferUsageWriteOnly];
		[indexBuffer setData:indexArray];
		
		float radius = 1.8f;
		
		boundingSphere = [BoundingSphere sphereWithRadius:radius];
	}
	
	return self;
}

- (void)drawWithGraphicsDevice:(GraphicsDevice *)graphicsDevice {
	[graphicsDevice setVertexBuffer:vertexBuffer];
	graphicsDevice.indices = indexBuffer;
	
	[graphicsDevice drawIndexedPrimitivesOfType:PrimitiveTypeTriangleList
												baseVertex:0
										  minVertexIndex:0
											  numVertices:numVertices
												startIndex:0
										  primitiveCount:primitiveCount];
}

@end