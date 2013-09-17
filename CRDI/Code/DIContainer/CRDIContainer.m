//
//  CRDIContainer.m
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDIContainer.h"

#import "CRDIClassBuilder.h"
#import "CRDIBlockBuilder.h"

static CRDIContainer *defaultContainer = nil;

@interface CRDIContainer ()

@property (nonatomic, strong) NSMutableDictionary *configurationDictionary;

@end

@implementation CRDIContainer

+ (CRDIContainer *)defaultContainer
{
    
    return defaultContainer;
}

+ (void)setDefaultContainer:(CRDIContainer *)aContainer
{
    defaultContainer = aContainer;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.configurationDictionary = [NSMutableDictionary new];
    }
    
    return self;
}

- (void)bindClass:(Class)aClass toProtocol:(Protocol *)aProtocol
{
    NSParameterAssert(aClass);
    NSParameterAssert(aProtocol);
    
    CRDIClassBuilder *classBuilder = [[CRDIClassBuilder alloc] initWithClass:aClass];
    
    [self addBuilder:classBuilder forProtocol:aProtocol];
}

- (void)bindBlock:(CRDIContainerBindBlock)aBlock toProtocol:(Protocol *)aProtocol
{
    NSParameterAssert(aBlock);
    NSParameterAssert(aProtocol);
    
    CRDIBlockBuilder *blockBuilder = [[CRDIBlockBuilder alloc] initWithBlock:aBlock];
    
    [self addBuilder:blockBuilder forProtocol:aProtocol];
}

- (void)addBuilder:(id <CRDIDependencyBuilder>)aBuilder forProtocol:(Protocol *)aProtocol
{
    NSParameterAssert(aBuilder);
    NSParameterAssert(aProtocol);
    
    NSString *protocolKey = [self stringFromPorotocol:aProtocol];
    
    [self checkKeyIsAlreadyExists:protocolKey];
    
    [self.configurationDictionary setObject:aBuilder forKey:protocolKey];
}

- (id <CRDIDependencyBuilder>)builderForProtocol:(Protocol *)aProtocol
{
    NSParameterAssert(aProtocol);
    
    NSString *protocolKey = [self stringFromPorotocol:aProtocol];
    
    [self checkIfKeyNotExists:protocolKey];
    
    return self.configurationDictionary[protocolKey];
}

- (void)checkKeyIsAlreadyExists:(NSString *)aKey
{
    if (self.configurationDictionary[aKey]) {
        @throw [CRDIException exceptionWithReason:[NSString stringWithFormat:@"Container already contains protocol %@", aKey]];
    }
}

- (void)checkIfKeyNotExists:(NSString *)aKey
{
    if (!self.configurationDictionary[aKey]) {
        @throw [CRDIException exceptionWithReason:[NSString stringWithFormat:@"Builder for protocol %@ not binded", aKey]];
    }
}

- (NSString *)stringFromPorotocol:(Protocol *)aProtocol
{
    return NSStringFromProtocol(aProtocol);
}

@end
