#import "SettingsMenu.h"
#import "TINR.Glomero.h"

#import "ButtonText.h"

#define KEY_SOUND_ON   @"SOUND_ON"
#define KEY_MUSIC_ON   @"MUSIC_ON"
#define KEY_TEST_VALUE @"TEST_VALUE"

@implementation SettingsMenu {
	BOOL soundOn, musicOn;
	float testValue;
	
	GUICheckBox *soundCB;
	GUICheckBox *musicCB;
	GUIButton *backButton;
	GUIText *sliderLabel;
	GUISlider *slider;
}

- (void)loadContent {
	soundOn = [PlayerPrefs getIntByKey:KEY_SOUND_ON defaultValue:1];
	musicOn = [PlayerPrefs getIntByKey:KEY_MUSIC_ON defaultValue:1];
	testValue = [PlayerPrefs getFloatByKey:KEY_TEST_VALUE defaultValue:0.5f];
	
	Glomero *glomero = [Glomero getInstance];
	
	self.mainCamera.color = [[Color alloc] initWithRed:50 green:50 blue:50];
	
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
		soundCB = [cbNode addComponentOfClass:[GUICheckBox class]];
		
		soundCB.normalSprite = [glomero.uiAtlas getSpriteWithName:@"Box"];
		soundCB.checkedSprite = [glomero.uiAtlas getSpriteWithName:@"CheckedBox"];
		soundCB.isChecked = soundOn;
		
		soundCB.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		soundCB.node.transform.position = [Vector2 vectorWithX:450.0f y:300.0f];
		
		Node *lblNode = [self createNodeWithParent:cbNode];
		GUIText *text = [lblNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Sound";
		text.horizontalAlign = HorizontalAlignRight;
		text.scale = [Vector2 vectorWithX:1.5f y:1.5f];
		text.node.transform.position = [Vector2 vectorWithX:-soundCB.normalSprite.rectange.width + 4.0f y:-1.0f];
	}
	
	// Music toggle
	{
		Node *cbNode = [self createNode];
		musicCB = [cbNode addComponentOfClass:[GUICheckBox class]];
		
		musicCB.normalSprite = [glomero.uiAtlas getSpriteWithName:@"Box"];
		musicCB.checkedSprite = [glomero.uiAtlas getSpriteWithName:@"CheckedBox"];
		musicCB.isChecked = musicOn;
		
		musicCB.node.transform.scale = [Vector2 vectorWithX:8.0f y:8.0f];
		musicCB.node.transform.position = [Vector2 vectorWithX:450.0f y:450.0f];
		
		Node *lblNode = [self createNodeWithParent:cbNode];
		GUIText *text = [lblNode addComponentOfClass:[GUIText class]];
		
		text.font = glomero.font;
		text.text = @"Music";
		text.horizontalAlign = HorizontalAlignRight;
		text.scale = [Vector2 vectorWithX:1.5f y:1.5f];
		text.node.transform.position = [Vector2 vectorWithX:-musicCB.normalSprite.rectange.width + 4.0f y:-1.0f];
	}
	
	{
		Node *node = [self createNode];
		slider = [node addComponentOfClass:[GUISlider class]];
		
		slider.node.transform.scale = [Vector2 vectorWithX:6.0f y:6.0f];
		slider.node.transform.position = [Vector2 vectorWithX:cx y:650.0f];
		slider.background = [glomero.uiAtlas getSpriteWithName:@"SliderBackground"];
		slider.thumb = [glomero.uiAtlas getSpriteWithName:@"SliderThumb"];
		slider.value = testValue;
		
		sliderLabel = [[self createNodeWithParent:node] addComponentOfClass:[GUIText class]];
		
		sliderLabel.font = glomero.font;
		sliderLabel.text = @"0.5";
		sliderLabel.horizontalAlign = HorizontalAlignCenter;
		sliderLabel.verticalAlign = VerticalAlignTop;
		sliderLabel.scale = [Vector2 vectorWithX:1.5f y:1.5f];
		sliderLabel.node.transform.position = [Vector2 vectorWithX:slider.background.rectange.width / 2.0f y:10.0f];
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
	
	sliderLabel.text = [NSString stringWithFormat:@"%f", slider.value];
	
	testValue = slider.value;
	soundOn = soundCB.isChecked;
	musicOn = musicCB.isChecked;
	
	if(slider.wasChanged) {
		[PlayerPrefs setFloatForKey:KEY_TEST_VALUE value:testValue];
		[PlayerPrefs save];
	}
	
	if(soundCB.wasChanged) {
		[PlayerPrefs setIntForKey:KEY_SOUND_ON value:soundOn];
		[PlayerPrefs save];
	}
	
	if(musicCB.wasChanged) {
		[PlayerPrefs setIntForKey:KEY_MUSIC_ON value:musicOn];
		[PlayerPrefs save];
	}
}

@end
