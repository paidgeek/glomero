#import "Engine.UI.classes.h"
#import "Sprite.h"

@interface GUISlider : NSObject<IUIComponent>

@property (nonatomic, strong) Sprite *background;
@property (nonatomic, strong) Sprite *thumb;
@property (nonatomic) float value;
@property (nonatomic) BOOL wasChanged;

@end
