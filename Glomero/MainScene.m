#import "MainScene.h"
#import "TINR.Glomero.h"

#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"
#import "ButtonText.h"

@implementation MainScene

@synthesize worldAtlas, entitiesAtlas, uiAtlas;

- (void) loadContent {
	worldAtlas = [TextureAtlas loadWithContentManager:self.game.content
														 atlasName:@"World"];
	entitiesAtlas = [TextureAtlas loadWithContentManager:self.game.content
															 atlasName:@"Entities"];
	uiAtlas = [TextureAtlas loadWithContentManager:self.game.content
													 atlasName:@"UI"];

	for (int x = 0; x < 15; x++) {
		for(int y = 0; y < 30; y++) {
			Node *tileNode = [self createNode];
			SpriteRenderer *tileSr = [tileNode addComponentOfClass:[SpriteRenderer class]];
			tileNode.transform.position = [Vector2 vectorWithX:x*128.0f y:-y*128.0f + 8 * 128.0f];

			switch (arc4random_uniform(2)) {
				case 0:
					tileSr.sprite = [worldAtlas getSpriteWithName:@"grass"];
					break;
				case 1:
					tileSr.sprite = [worldAtlas getSpriteWithName:@"brick"];
					break;
			}
		}
	}
	 
	[self.mainCamera.node.transform.position set:[Vector2 vectorWithX:320.0f y:480.0f]];

	FontTextureProcessor *fontProcessor = [[FontTextureProcessor alloc] init];
	SpriteFont *font = [self.game.content load:@"BitBold" processor:fontProcessor];
	
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = font;
		text.text = @"Hello, World!";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:320.0f y:50.0f];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
	
	{
		Node *imageNode = [self createNode];
		GUIImage *image = [imageNode addComponentOfClass:[GUIImage class]];
		
		image.sprite = [uiAtlas getSpriteWithName:@"Duck"];
		image.node.transform.position = [Vector2 vectorWithX:100.0f y:750.0f];
	}
	
	{
		Node *btnNode = [self createNode];
		GUIButton *btn = [btnNode addComponentOfClass:[GUIButton class]];
		
		btn.normalSprite = [uiAtlas getSpriteWithName:@"ButtonNormal"];
		btn.pressedSprite = [uiAtlas getSpriteWithName:@"ButtonPressed"];
		btn.pressedSprite.pivot.y -= 1;
		
		btn.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		btn.node.transform.position = [Vector2 vectorWithX:320.0f y:300.0f];
		
		Node *labelNode = [self createNodeWithParent:btnNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		[labelNode addComponentOfClass:[ButtonText class]];
		
		text.font = font;
		text.text = @"Button";
		text.horizontalAlign = HorizontalAlignCenter;
		text.color = [Color gray];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
	
	{
		Node *cbNode = [self createNode];
		GUICheckBox *cb = [cbNode addComponentOfClass:[GUICheckBox class]];
		
		cb.normalSprite = [uiAtlas getSpriteWithName:@"Box"];
		cb.checkedSprite = [uiAtlas getSpriteWithName:@"CheckedBox"];

		cb.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		cb.node.transform.position = [Vector2 vectorWithX:450.0f y:500.0f];
		
		Node *lblNode = [self createNodeWithParent:cbNode];
		GUIText *text = [lblNode addComponentOfClass:[GUIText class]];
		
		text.font = font;
		text.text = @"Checkbox";
		text.horizontalAlign = HorizontalAlignRight;
		text.scale = [Vector2 vectorWithX:1.5f y:1.5f];
		text.node.transform.position = [Vector2 vectorWithX:-cb.normalSprite.rectange.width + 4.0f y:-1.0f];
	}
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	
	[self.mainCamera.node.transform translateX:0.0f y:gameTime.elapsedGameTime * -50.0f];
}

@end
