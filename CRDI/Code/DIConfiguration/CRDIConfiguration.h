//
//  CRDIModule.h
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CRDIContainer;

@interface CRDIConfiguration : NSObject

@property (nonatomic, weak, readonly) CRDIConfiguration *parentModule;

- (id)initWithContainer:(CRDIContainer *)aContainer;

- (void)configure;

@end
