#import "Engine.UI.classes.h"
#import "Sprite.h"

@interface GUICheckBox : NSObject<IUIComponent>

@property (nonatomic, strong) Sprite *normalSprite;
@property (nonatomic, strong) Sprite *checkedSprite;
@property (nonatomic) BOOL isChecked;
@property (nonatomic) BOOL wasChanged;

@end
