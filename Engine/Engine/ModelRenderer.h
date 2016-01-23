#import "Game.h"
#import "Engine.Graphics.classes.h"

@interface ModelRenderer : NSObject<INodeComponent>

@property (nonatomic, strong) Model *model;

@end
