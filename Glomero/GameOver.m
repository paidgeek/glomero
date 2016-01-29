#import "GameOver.h"
#import "TINR.Glomero.h"
#import "ButtonText.h"

@implementation GameOver {
	GUIButton *backButton;
	GUIButton *retryButton;
}

- (void)loadContent {
	Glomero *glomero = [Glomero getInstance];
	
	self.mainCamera.clearColor = [[Color alloc] initWithRed:20 green:20 blue:20];
	
	float cx = (self.game.gameWindow.clientBounds.width / 2.0f);
	
	// Title
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Game Over";
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector3 vectorWithX:cx y:100.0f z:0.0f];
		text.scale = [Vector2 vectorWithX:3.0f y:3.0f];
	}
	
	// Score label
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Score";
		text.color = [Color gray];
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector3 vectorWithX:cx y:250.0f z:0.0f];
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
	
	// Score
	{
		Node *labelNode = [self createNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = [NSString stringWithFormat:@"%d", [GamePlay getInstance].score];
		text.horizontalAlign = HorizontalAlignCenter;
		text.node.transform.position = [Vector3 vectorWithX:cx y:350.0f z:0.0f];
		text.scale = [Vector2 vectorWithX:3.0f y:3.0f];
	}
	
	// Back button
	{
		Node *btnNode = [self createNode];
		backButton = [btnNode addComponentOfClass:[GUIButton class]];
		
		backButton.normalSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonNormal"];
		backButton.pressedSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonPressed"];
		backButton.pressedSprite.pivot.y -= 1;
		
		backButton.node.transform.scale = [Vector3 vectorWithX:8.0f y:8.0f z:0.0f];
		backButton.node.transform.position = [Vector3 vectorWithX:cx
																				  y:self.game.gameWindow.clientBounds.height - 100.0f
																				  z:0.0f];
		
		Node *labelNode = [self createNodeWithParent:btnNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		[labelNode addComponentOfClass:[ButtonText class]];
		
		text.font = glomero.font;
		text.text = @"Back";
		text.horizontalAlign = HorizontalAlignCenter;
		text.scale = [Vector2 vectorWithX:2.0f
												  y:2.0f];
	}
	
	// Retry button
	{
		Node *btnNode = [self createNode];
		retryButton = [btnNode addComponentOfClass:[GUIButton class]];
		
		retryButton.normalSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonNormal"];
		retryButton.pressedSprite = [glomero.uiAtlas getSpriteWithName:@"ButtonPressed"];
		retryButton.pressedSprite.pivot.y -= 1;
		
		retryButton.node.transform.scale = [Vector3 vectorWithX:8.0f y:8.0f z:0.0f];
		retryButton.node.transform.position = [Vector3 vectorWithX:cx
																					y:self.game.gameWindow.clientBounds.height - 250.0f
																					z:0.0f];
		
		Node *labelNode = [self createNodeWithParent:btnNode];
		GUIText *text = [labelNode addComponentOfClass:[GUIText class]];
		[labelNode addComponentOfClass:[ButtonText class]];
		
		text.font = glomero.font;
		text.text = @"Retry";
		text.horizontalAlign = HorizontalAlignCenter;
		text.scale = [Vector2 vectorWithX:2.0f y:2.0f];
	}
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	
	if(backButton.wasReleased) {
		[[Glomero getInstance] enterScene:[MainMenu class]];
	}
	
	if(retryButton.wasReleased) {
		[[Glomero getInstance] enterScene:[MainScene class]];
	}
}

@end
