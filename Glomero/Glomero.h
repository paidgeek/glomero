#import "TINR.Glomero.classes.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"

@interface Glomero : Game {
	GraphicsDeviceManager *graphics;
	Scene *scene;
	
	Sprite *grass, *yellowAlien, *pinkAlien;
	TextureAtlas *worldAtlas;
	TextureAtlas *entityAtlas;
	SpriteBatch *spriteBatch;
	
	Vector2 *yellowPos, *pinkPos, *pinkVel;
}


- (void) drawTileWithSprite:(Sprite*) tileSprite
								  x:(float) x
								  y:(float) y;

@end
