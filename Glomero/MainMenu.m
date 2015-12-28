#import "MainMenu.h"
#import "TINR.Glomero.h"
#import "ButtonText.h"

@implementation MainMenu {
	GUIButton *startButton;
	GUIButton *settingsButton;
	GUIButton *creditsButton;
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
		text.text = @"Glomero";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:cx y:80.0f];
		text.scale = [Vector2 vectorWithX:3.5f y:3.5f];
	}
	
	// Start button
	{
		Node *btnNode = [self createNode];
		startButton = [btnNode addComponentOfClass:[GUIButton class]];
		
		startButton.normalSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonNormal"];
		startButton.pressedSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonPressed"];
		startButton.pressedSprite.pivot.y -= 1;
		
		startButton.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		startButton.node.transform.position = [Vector2 vectorWithX:cx y:400.0f];
		
		Node *labelNode = [self createNodeWithParent:btnNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		[labelNode addComponentOfClass:[ButtonText class]];
		
		text.font = glomero.font;
		text.text = @"Start";
		text.horizontalAlign = HorizontalAlignCenter;
		text.color = [Color gray];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
	
	// Settings button
	{
		Node *btnNode = [self createNode];
		settingsButton = [btnNode addComponentOfClass:[GUIButton class]];
		
		settingsButton.normalSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonNormal"];
		settingsButton.pressedSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonPressed"];
		settingsButton.pressedSprite.pivot.y -= 1;
		
		settingsButton.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		settingsButton.node.transform.position = [Vector2 vectorWithX:cx y:550.0f];
		
		Node *labelNode = [self createNodeWithParent:btnNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		[labelNode addComponentOfClass:[ButtonText class]];
		
		text.font = glomero.font;
		text.text = @"Settings";
		text.horizontalAlign = HorizontalAlignCenter;
		text.color = [Color gray];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
	
	// Credits button
	{
		Node *btnNode = [self createNode];
		creditsButton = [btnNode addComponentOfClass:[GUIButton class]];
		
		creditsButton.normalSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonNormal"];
		creditsButton.pressedSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonPressed"];
		creditsButton.pressedSprite.pivot.y -= 1;
		
		creditsButton.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		creditsButton.node.transform.position = [Vector2 vectorWithX:cx y:700.0f];
		
		Node *labelNode = [self createNodeWithParent:btnNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		[labelNode addComponentOfClass:[ButtonText class]];
		
		text.font = glomero.font;
		text.text = @"Credits";
		text.horizontalAlign = HorizontalAlignCenter;
		text.color = [Color gray];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
	
	// Copyright
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Copyright 2015 GameTeam";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector2 vectorWithX:cx y:self.game.gameWindow.clientBounds.height - 50.0f];
		text.scale = [Vector2 vectorWithX:0.8f y:0.8f];
	}
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	
	if(startButton.wasReleased) {
		[[Glomero getInstance] enterScene:[MainScene class]];
	} else if(settingsButton.wasReleased) {
		[[Glomero getInstance] enterScene:[SettingsMenu class]];
	} else if(creditsButton.wasReleased) {
		[[Glomero getInstance] enterScene:[CreditsMenu class]];
	}
}

@end
