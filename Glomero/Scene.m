#import "Scene.h"

@implementation Scene

- (id) init {
    self = [super init];
    
    if(self) {
        sceneObjects = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (SceneObject*) createSceneObject {
    SceneObject* sceneObject = [[SceneObject alloc] init];
    
    [sceneObjects addObject:sceneObject];
    
    return sceneObject;
}

- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *)state
                                   objects:(id *)stackbuf
                                     count:(NSUInteger)len {
    return [sceneObjects countByEnumeratingWithState:state objects:stackbuf count:len];
}

- (void) dealloc {
    [sceneObjects release];
    [super dealloc];
}

@end
