#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

#import "TextureAtlas.h"

typedef enum {
	TileDirt,
	TileGrass
} Tile;

@interface Glomero : Game {
	GraphicsDeviceManager *graphics;
    SpriteBatch *spriteBatch;
	
	TextureAtlas *worldAtlas;
	Sprite *dirt, *grass;
	
	Sprite *coin;
	
	Tile map[16][16];
}

- (void) drawTileWithSprite:(Sprite*) tileSprite
						  x:(float) x
						  y:(float) y;

@end
