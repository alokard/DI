//
//  CRDICachedInjectedClassModel.m
//  CRDI
//
//  Created by TheSooth on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDICachedInjectedClassModel.h"

@interface CRDICachedInjectedClassModel ()

@property (nonatomic, strong) NSMutableDictionary *propertyDictionary;

@end

@implementation CRDICachedInjectedClassModel

- (id)init
{
    self = [super init];
    if (self) {
        self.propertyDictionary = [NSMutableDictionary new];
    }
    return self;
}


- (void)addProtocol:(Protocol *)aProtocol forPropertyNamed:(NSString *)aPropertyName
{
    NSParameterAssert(aProtocol);
    NSParameterAssert(aPropertyName);
    
    NSString *protocolName = NSStringFromProtocol(aProtocol);

    [self.propertyDictionary setObject:protocolName forKey:aPropertyName];
}

- (NSArray *)propertiesList
{
    return self.propertyDictionary.allKeys;
}

- (Protocol *)getProtocolForPropertyNamed:(NSString *)aPropertyName
{
    NSParameterAssert(aPropertyName);
    
    NSString *protocolName = self.propertyDictionary[aPropertyName];
    
    return NSProtocolFromString(protocolName);
}

@end
