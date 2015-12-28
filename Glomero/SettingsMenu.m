#import "SettingsMenu.h"
#import "TINR.Glomero.h"

#import "ButtonText.h"

@implementation SettingsMenu {
	GUIButton *backButton;
}

- (void)loadContent {
	Glomero *glomero = [Glomero getInstance];
	
	self.mainCamera.color = [[Color alloc] initWithRed:50 green:50 blue:50];;
	
	float cx = (self.game.gameWindow.clientBounds.width / 2.0f);
	
	// Title
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Settings";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:cx y:80.0f];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
	
	// Sound toggle
	{
		Node *cbNode = [self createNode];
		GUICheckBox *cb = [cbNode addComponentOfClass:[GUICheckBox class]];
		
		cb.normalSprite = [glomero.uiAtlas getSpriteWithName:@"Box"];
		cb.checkedSprite = [glomero.uiAtlas getSpriteWithName:@"CheckedBox"];
		
		cb.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		cb.node.transform.position = [Vector2 vectorWithX:450.0f y:350.0f];
		
		Node *lblNode = [self createNodeWithParent:cbNode];
		GUIText *text = [lblNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Sound";
		text.horizontalAlign = HorizontalAlignRight;
		text.scale = [Vector2 vectorWithX:1.5f y:1.5f];
		text.node.transform.position = [Vector2 vectorWithX:-cb.normalSprite.rectange.width + 4.0f y:-1.0f];
	}
	
	// Music toggle
	{
		Node *cbNode = [self createNode];
		GUICheckBox *cb = [cbNode addComponentOfClass:[GUICheckBox class]];
		
		cb.normalSprite = [glomero.uiAtlas getSpriteWithName:@"Box"];
		cb.checkedSprite = [glomero.uiAtlas getSpriteWithName:@"CheckedBox"];
		
		cb.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		cb.node.transform.position = [Vector2 vectorWithX:450.0f y:500.0f];
		
		Node *lblNode = [self createNodeWithParent:cbNode];
		GUIText *text = [lblNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Music";
		text.horizontalAlign = HorizontalAlignRight;
		text.scale = [Vector2 vectorWithX:1.5f y:1.5f];
		text.node.transform.position = [Vector2 vectorWithX:-cb.normalSprite.rectange.width + 4.0f y:-1.0f];
	}
	
	// Back button
	{
		Node *btnNode = [self createNode];
		backButton = [btnNode addComponentOfClass:[GUIButton class]];
		
		backButton.normalSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonNormal"];
		backButton.pressedSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonPressed"];
		backButton.pressedSprite.pivot.y -= 1;
		
		backButton.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		backButton.node.transform.position = [Vector2 vectorWithX:cx y:self.game.gameWindow.clientBounds.height - 100.0f];
		
		Node *labelNode = [self createNodeWithParent:btnNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		[labelNode addComponentOfClass:[ButtonText class]];
		
		text.font = glomero.font;
		text.text = @"Back";
		text.horizontalAlign = HorizontalAlignCenter;
		text.color = [Color gray];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	
	if(backButton.wasReleased) {
		[[Glomero getInstance] enterScene:[MainMenu class]];
	}
}

@end
