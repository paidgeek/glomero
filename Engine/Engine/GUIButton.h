#import "Engine.UI.classes.h"
#import "Sprite.h"

@interface GUIButton : NSObject<IUIComponent>

@property (nonatomic, strong) Sprite *normalSprite;
@property (nonatomic, strong) Sprite *pressedSprite;
@property (nonatomic) BOOL isDown;
@property (nonatomic) BOOL wasPressed;
@property (nonatomic) BOOL wasReleased;

@end
