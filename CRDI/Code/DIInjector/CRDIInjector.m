//
//  CRDIInjector.m
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDIInjector.h"
#import "CRDICachedInjectedClassModel.h"
#import <objc/runtime.h>

static CRDIInjector *defaultInjector = nil;

@interface CRDIInjector ()

@property (nonatomic, weak) CRDIContainer *container;
@property (nonatomic, strong) NSMutableDictionary *classesCache;


@end

@implementation CRDIInjector

+ (CRDIInjector *)defaultInjector
{
    return defaultInjector;
}

+ (void)setDefaultInjector:(CRDIInjector *)aDefaultInjector
{
    defaultInjector = aDefaultInjector;
}

- (id)initWithContainer:(CRDIContainer *)aContainer
{
    NSParameterAssert(aContainer);
    self = [super init];
    
    if (self) {
        self.container = aContainer;
    }
    
    return self;
}

- (void)injectImplementationsToInstance:(id<NSObject>)aInstance
{
    NSParameterAssert(aInstance);
}

- (void)injectObjecPropertiesToInstance:(id)aInstance
{
    NSString *className = NSStringFromClass([aInstance class]);
    
    CRDICachedInjectedClassModel *cachedClassModel = self.classesCache[className];
    
    for (NSString *propertyName in cachedClassModel.propertiesList) {
        Protocol *propertyProtocol = [cachedClassModel getProtocolForPropertyNamed:propertyName];
        
        id <CRDIDependencyBuilder> builder = [self.container builderForProtocol:propertyProtocol];
        
        id buildedObject = [builder build];
        
        [aInstance setValue:buildedObject forKey:propertyName];
    }
}

@end