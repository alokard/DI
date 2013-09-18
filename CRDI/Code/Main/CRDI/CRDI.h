//
//  CRDI.h
//  CRDI
//
//  Created by TheSooth on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRDIInjector.h"

@interface CRDI : NSObject

+ (CRDIInjector *)defaultInjector;

+ (void)setDefaultInjector:(CRDIInjector *)aInjector;

+ (void)startService;

+ (void)stopService;

@end
