#import <Foundation/Foundation.h>

@interface SceneObject : NSObject {
    NSMutableArray *sceneComponents;
}

- (id) addSceneComponent: (Class) componentClass;

@end
