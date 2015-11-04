#import <Foundation/Foundation.h>
#import "SceneObject.h"

@interface Scene : NSObject<NSFastEnumeration> {
    NSMutableArray *sceneObjects;
}

- (SceneObject*) createSceneObject;

@end
