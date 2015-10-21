#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

#import "TextureAtlas.h"

@interface Glomero : Game {
	GraphicsDeviceManager *graphics;
    SpriteBatch *spriteBatch;
	
	TextureAtlas *worldAtlas;
	Sprite *buttonNormal;
}

@end
