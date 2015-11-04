#import "TextureAtlas.h"
#import "TINR.Glomero.h"

@implementation TextureAtlas

@synthesize texture;

- (id) initWithTexture:(Texture2D*) atlasTexture
			 data:(NSString*) atlasData {
	self = [super init];
	
	if(self) {
		self.texture = atlasTexture;
		
		@try {
			atlas = [NSJSONSerialization
					 JSONObjectWithData:[NSData dataWithContentsOfFile:atlasData]
					 options:0 error:nil];
		}
		@catch (NSException *exception) {
			NSLog(@"%@", exception);
		}
	}
	
	return self;
}

- (Sprite*) getSpriteWithName:(NSString*) name {
	if([atlas isKindOfClass:[NSDictionary class]]) {
		NSArray *sprites = [atlas objectForKey:@"sprites"];
		
		for (NSDictionary *spriteObj in sprites) {
			if([name isEqualToString:[spriteObj valueForKey:@"name"]]) {
				NSArray *rect = [spriteObj objectForKey:@"rectange"];
				
				int x = (int)[[rect objectAtIndex:0] integerValue];
				int y = (int)[[rect objectAtIndex:1] integerValue];
				int w = (int)[[rect objectAtIndex:2] integerValue];
				int h = (int)[[rect objectAtIndex:3] integerValue];
				
				Sprite *sprite = [[Sprite alloc] initWithRectange:[Rectangle rectangleWithX:x
																						  y:y
																					  width:w
																					 height:h]
														  texture:self.texture];
				
				return sprite;
			}
		}
	}
	
	return nil;
}

@end
