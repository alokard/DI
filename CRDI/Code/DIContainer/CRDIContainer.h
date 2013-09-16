//
//  CRDIContainer.h
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDITypedefs.h"
#import "CRDIDependencyBuilder.h"

@class CRDIConfiguration;

@interface CRDIContainer : NSObject

+ (CRDIContainer *)defaultContainer;

- (void)startWithRootModule:(CRDIConfiguration *)aModule;

- (void)bindClass:(Class)aClass toProtocol:(Protocol *)aProtocol;

- (void)bindBlock:(CRDIContainerBindBlock)aBlock toProtocol:(Protocol *)aProtocol;

- (id <CRDIDependencyBuilder>)builderForProtocol:(Protocol *)aProtocol;

- (void)setDefaultContainer:(CRDIContainer *)aContainer;

@end
