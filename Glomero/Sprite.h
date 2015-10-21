#import "Retronator.Xni.Framework.Graphics.h"

@interface Sprite : NSObject {
	Texture2D *texture;
	Rectangle *rectange;
}

@property (nonatomic, retain) Texture2D *texture;
@property (nonatomic, retain) Rectangle *rectange;

@end
