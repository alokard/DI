//
//  CRDIModule.m
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDIConfiguration.h"

@interface CRDIConfiguration ()

@property (nonatomic, weak) CRDIContainer *container;

@end

@implementation CRDIConfiguration

- (id)initWithContainer:(CRDIContainer *)aContainer
{
    self = [super init];
    
    assert(self);
    
    return self;
}

- (void)configure {}

- (void)include:(CRDIConfiguration *)aModule
{
    [self checkForDependencyLoop];
}

- (void)checkForDependencyLoop
{
    CRDIConfiguration *configuration = self.parentModule;
    
    while (configuration) {
        if ([configuration isKindOfClass:[self class]]) {
            NSAssert(false, @"Parent module isKind of received module");
        }
        configuration = configuration.parentModule;
    }
}

@end
