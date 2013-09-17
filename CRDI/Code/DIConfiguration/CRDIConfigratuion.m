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

@property (nonatomic, weak) CRDIConfiguration *parentConfiguration;

@end

@implementation CRDIConfiguration

- (id)initWithContainer:(CRDIContainer *)aContainer
{
    self = [super init];
    
    if (self) {
        self.container = aContainer;
    }
    
    return self;
}

- (id)initWithParentConfiguratuion:(CRDIConfiguration *)aConfiguration container:(CRDIContainer *)aContainer
{
    self = [super init];
    
    if (self) {
        self.parentConfiguration = aConfiguration;
        
        [self checkForDependencyLoop];
        
        self.container = aContainer;
    }
    
    return self;
}

- (void)configure {}

- (void)includeConfigurationWithClass:(Class)aConfigurationClass
{
    BOOL configurationIsSublcassOfConfigurationClass = [aConfigurationClass isSubclassOfClass:[CRDIConfiguration class]];
    
    NSParameterAssert(configurationIsSublcassOfConfigurationClass);
    
    CRDIConfiguration *configuration = [[aConfigurationClass alloc] initWithParentConfiguratuion:self container:self.container];
    
    [configuration configure];
}

- (void)checkForDependencyLoop
{
    CRDIConfiguration *configuration = self.parentConfiguration;
    
    while (configuration) {
        if ([configuration isKindOfClass:[self class]]) {
            NSAssert(false, @"Parent module isKind of received module");
        }
        configuration = configuration.parentConfiguration;
    }
}

@end
