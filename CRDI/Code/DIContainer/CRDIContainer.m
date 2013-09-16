//
//  CRDIContainer.m
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDIContainer.h"

static CRDIContainer *_defaultContainer = nil;

@interface CRDIContainer ()

@property (nonatomic, strong) CRDIMutableConfigurationStorage *configurationDictionary;

@end

@implementation CRDIContainer

+ (CRDIContainer *)defaultContainer
{
    NSParameterAssert(_defaultContainer);
    
    return _defaultContainer;
}

- (id)init
{
    self = [super init];
    
    assert(self);
    
    self.configurationDictionary = [CRDIMutableConfigurationStorage new];
    
    return self;
}

+ (void)setDefaultContainer:(CRDIContainer *)aContainer
{
    _defaultContainer = aContainer;
}

@end
