#import "Retronator.Xni.Framework.Graphics.h"

@interface Sprite : NSObject {
	Texture2D *texture;
	Rectangle *rectange;
}

- (id) initWithRectange: (Rectangle*) rect texture : (Texture2D*) tex;

@property (nonatomic, retain) Texture2D *texture;
@property (nonatomic, retain) Rectangle *rectange;

@end
