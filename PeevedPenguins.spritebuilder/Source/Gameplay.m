//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Bert on 02/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay{
    
    
    CCPhysicsNode *_physicsNode;                //Creating een physics object, like named in spritebuilder
    CCNode *_catapultArm;                       // Creating a node object, like named in spritebuilder
    CCNode *_levelNode;
    CCNode *_contentNode;
    CCNode *_pullbackNode;
}





// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
    _physicsNode.debugDraw = TRUE;
    // nothing shall collide with our invisible nodes
    _pullbackNode.physicsBody.collisionMask = @[];
}

// called on every touch in this scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self launchPenguin]; //Tell the class object/instance itself to use the method called "launchPenguin"
}

- (void)launchPenguin {
    // loads the Penguin.ccb we have set up in Spritebuilder
    CCNode* penguin = [CCBReader load:@"Penguin"]; // another node object created
    // position the penguin at the bowl of the catapult
    penguin.position = ccpAdd(_catapultArm.position, ccp(16, 50)); //Watch how you can use the CCNode methods out of the box
    
    // add the penguin to the physicsNode of this scene (because it has physics enabled)
    // send a message to the PhysicsNode object/instance to add the penguin object to itself as a child
    [_physicsNode addChild:penguin];
    
    // manually create & apply a force to launch the penguin
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000); // using the CGPoint "launchdirection" object
    [penguin.physicsBody applyForce:force]; //Watch how we send the method physicsBody apply force to the object
    
    
    /*
     We are telling the Gameplay scene to act as a camera following
     the penguin. We also say that the camera shall not leave our 
     scene by using the bounding box of the scene to define the world
     boundaries.
     */
    
    // ensure followed object is in visible are when starting
    self.position = ccp(0, 0);
    CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
    
    
    
    // ensure followed object is in visible are when starting
  //  self.position = ccp(0, 0); //setting position with CC macro -> CGPoint etc.
    //CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];//creating CCActionFollow object with bounderies of the scene itself
   // [self runAction:follow];
    
    
    
    
}


- (void)retry {
    // reload this level
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"Gameplay"]];
}

@end
