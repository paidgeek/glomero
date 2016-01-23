#import "Engine.Graphics.classes.h"

@interface MeshRenderer : NSObject<INodeComponent>

@property (nonatomic, strong) Mesh *mesh;
@property (nonatomic, strong) BasicEffect *effect;

@end
