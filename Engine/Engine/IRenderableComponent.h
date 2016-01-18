#import "Engine.Core.classes.h"

@protocol IRenderableComponent <INodeComponent>

- (void) drawWithGameTime:(GameTime *) gameTime graphicsDevice:(GraphicsDevice*) graphicsDevice;

@property (nonatomic, strong) BasicEffect *effect;

@end
