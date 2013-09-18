//
//  CRDIInjector.h
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRDIContainer.h"
#import "CRDIInstanceInjector.h"

@interface CRDIInjector : NSObject <CRDIInstanceInjector>

- (id)initWithContainer:(CRDIContainer *)aContainer;

@end
