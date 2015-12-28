#import "CreditsMenu.h"
#import "TINR.Glomero.h"

#import "ButtonText.h"

@implementation CreditsMenu {
	GUIButton *backButton;
}

- (void) loadContent {
	Glomero *glomero = [Glomero getInstance];
	
	self.mainCamera.color = [[Color alloc] initWithRed:50 green:50 blue:50];;
	
	float cx = (self.game.gameWindow.clientBounds.width / 2.0f);
	
	// Title
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Credits";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:cx y:80.0f];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
	
	// Credit
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Graphic assets";
		text.color = [Color gray];
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:cx y:200.0f];
		text.scale = [Vector2 vectorWithX:1.0f y:1.0f];
		
		labelNode = [self createNode];
		text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"http://kenney.nl/";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:cx y:250.0f];
		text.scale = [Vector2 vectorWithX:1.25f y:1.25f];
	}
	
	// Credit
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Font";
		text.color = [Color gray];
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:cx y:320.0f];
		text.scale = [Vector2 vectorWithX:1.0f y:1.0f];
		
		labelNode = [self createNode];
		text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Martin Steiner";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:cx y:370.0f];
		text.scale = [Vector2 vectorWithX:1.25f y:1.25f];
		
		labelNode = [self createNodeWithParent:labelNode];
		text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"photo.design-studio.sk";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:0.0f y:50.0f];
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
