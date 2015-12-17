#import "MathUtil.h"
#import "Retronator.Xni.Framework.h"
#import "Express.Physics.h"
#import "Express.Scene.Objects.h"

@class Transform;
@class Node;
@class Scene;
@class Camera;
@class RigidBody2D;
@class CircleCollider2D;
@class CollisionMatrix;

#import "INodeComponent.h"
#import "ISceneListener.h"
#import "IDrawableComponent.h"
#import "ICollider.h"
#import "ICollisionListener.h"

// Systems
@class LogicSystem;
@class PhysicsSystem;
@class RenderSystem;

// Actions
@class SceneAction;
@class RemoveComponentAction;
@class AddComponentAction;
@class CreateNodeAction;
@class DestroyNodeAction;

#import "ISceneAction.h"
