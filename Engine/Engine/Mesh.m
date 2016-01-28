#import "Engine.Graphics.h"
#import "Mesh.h"
#import "StringLineReader.h"

@interface Face : NSObject
@property (nonatomic) int v1, v2, v3, n1, n2, n3, t1, t2, t3;
@end
@implementation Face
@synthesize v1, v2, v3, n1, n2, n3, t1, t2, t3;
@end

@implementation Mesh {
	VertexBuffer *vertexBuffer;
	IndexBuffer *indexBuffer;
	int numVertices, primitiveCount;
}

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

+ (Mesh *)loadFromFile:(NSString *)fileName graphicsDevice:(GraphicsDevice *)graphicsDevice {
	NSString *path = [[NSBundle mainBundle] pathForResource:fileName
																			ofType:@"obj"];
	NSString *obj = [NSString stringWithContentsOfFile:path
															encoding:NSUTF8StringEncoding
																error:nil];
	if(obj == nil) {
		return nil;
	}
	
	NSMutableArray *vertices = [NSMutableArray array];
	NSMutableArray *textureCoords = [NSMutableArray array];
	NSMutableArray *normals = [NSMutableArray array];
	NSMutableArray *faces = [NSMutableArray array];
	
	StringLineReader *slr = [StringLineReader createWithString:obj];
	
	while ([slr hasNext]) {
		NSString *line = [[slr next] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
		if([line hasPrefix:@"v "]) {
			line = [line substringFromIndex:2];
			NSArray *coords = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			
			[vertices addObject:[Vector3 vectorWithX:[[coords objectAtIndex:0] floatValue]
																y:[[coords objectAtIndex:1] floatValue]
																z:[[coords objectAtIndex:2] floatValue]]];
		} else if([line hasPrefix:@"vt "]) {
			line = [line substringFromIndex:3];
			NSArray *st = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			
			[textureCoords addObject:[Vector2 vectorWithX:[[st objectAtIndex:0] floatValue]
																	  y:[[st objectAtIndex:1] floatValue]]];
		} else if([line hasPrefix:@"vn "]) {
			line = [line substringFromIndex:3];
			NSArray *normal = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			
			[normals addObject:[Vector3 vectorWithX:[[normal objectAtIndex:0] floatValue]
															  y:[[normal objectAtIndex:1] floatValue]
															  z:[[normal objectAtIndex:2] floatValue]]];
		} else if([line hasPrefix:@"f "]) {
			NSArray *faceIndices = [[line substringFromIndex:2]
											componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			Face *face = [[Face alloc] init];

			NSArray *parts = [[faceIndices objectAtIndex:0] componentsSeparatedByString:@"/"];
			face.v1 = [[parts objectAtIndex:0] intValue] - 1;
			face.t1 = [[parts objectAtIndex:1] intValue] - 1;
			face.n1 = [[parts objectAtIndex:2] intValue] - 1;
			
			parts = [[faceIndices objectAtIndex:1] componentsSeparatedByString:@"/"];
			face.v2 = [[parts objectAtIndex:0] intValue] - 1;
			face.t2 = [[parts objectAtIndex:1] intValue] - 1;
			face.n2 = [[parts objectAtIndex:2] intValue] - 1;
			
			parts = [[faceIndices objectAtIndex:2] componentsSeparatedByString:@"/"];
			face.v3 = [[parts objectAtIndex:0] intValue] - 1;
			face.t3 = [[parts objectAtIndex:1] intValue] - 1;
			face.n3 = [[parts objectAtIndex:2] intValue] - 1;
				
			[faces addObject:face];
		}
	}
	
	VertexPositionNormalTextureArray *vertexArray = [[VertexPositionNormalTextureArray alloc]
																	 initWithInitialCapacity:vertices.count];
	VertexPositionNormalTextureStruct vertex;
	ShortIndexArray *indexArray = [[ShortIndexArray alloc]
											 initWithInitialCapacity:faces.count * 3];
	
	int index = 0;
	for(Face *face in faces) {
		[indexArray addIndex:index++];
		[indexArray addIndex:index++];
		[indexArray addIndex:index++];
		
		Vector3 *position = [vertices objectAtIndex:face.v1];
		Vector3 *normal = [normals objectAtIndex:face.n1];
		Vector2 *texture = [textureCoords objectAtIndex:face.t1];

		vertex.position.x = position.x;
		vertex.position.y = position.y;
		vertex.position.z = position.z;
		vertex.normal.x = normal.x;
		vertex.normal.y = normal.y;
		vertex.normal.z = normal.z;
		vertex.texture.x = texture.x;
		vertex.texture.y = texture.y;
		[vertexArray addVertex:&vertex];
		
		position = [vertices objectAtIndex:face.v2];
		normal = [normals objectAtIndex:face.n2];
		texture = [textureCoords objectAtIndex:face.t2];
		
		vertex.position.x = position.x;
		vertex.position.y = position.y;
		vertex.position.z = position.z;
		vertex.normal.x = normal.x;
		vertex.normal.y = normal.y;
		vertex.normal.z = normal.z;
		vertex.texture.x = texture.x;
		vertex.texture.y = texture.y;
		[vertexArray addVertex:&vertex];
		
		position = [vertices objectAtIndex:face.v3];
		normal = [normals objectAtIndex:face.n3];
		texture = [textureCoords objectAtIndex:face.t3];
		
		vertex.position.x = position.x;
		vertex.position.y = position.y;
		vertex.position.z = position.z;
		vertex.normal.x = normal.x;
		vertex.normal.y = normal.y;
		vertex.normal.z = normal.z;
		vertex.texture.x = texture.x;
		vertex.texture.y = texture.y;
		[vertexArray addVertex:&vertex];
	}
	
	return [[Mesh alloc] initWithGraphicsDevice:graphicsDevice vertexArray:vertexArray indexArray:indexArray];
}

@end