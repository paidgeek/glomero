#import "Space.h"
#import "MathUtil.h"
#import "Retronator.Xni.Framework.h"

@class PlayerPrefs;
@class Transform;
@class Node;
@class Scene;
@class Camera;

// Systems
@class LogicSystem;
@class RenderSystem;

// Actions
@class SceneAction;
@class RemoveComponentAction;
@class AddComponentAction;
@class CreateNodeAction;
@class DestroyNodeAction;

#import "ISceneAction.h"

@class SphereCollider;
@class AABoxCollider;
@class CollisionDetection;
@class Collision;

#import "INodeComponent.h"
#import "ISceneListener.h"
#import "IDrawableComponent.h"
#import "ICollisionListener.h"
#import "IColliderComponent.h"
#import "IUIComponent.h"

#import "Engine.UI.classes.h"