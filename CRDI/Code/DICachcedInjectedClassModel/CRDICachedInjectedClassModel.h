//
//  CRDICachedInjectedClassModel.h
//  CRDI
//
//  Created by TheSooth on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRDICachedInjectedClassModel : NSObject

- (void)addProtocol:(Protocol *)aProtocol forPropertyNamed:(NSString *)aPropertyName;

- (NSArray *)propertiesList;

- (Protocol *)getProtocolForPropertyNamed:(NSString *)aPropertyName;

@end
