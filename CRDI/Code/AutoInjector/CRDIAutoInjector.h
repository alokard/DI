//
//  CRDIAutoInjector.h
//  CRDI
//
//  Created by Sergey Zenchenko on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRDIInjector.h"

@interface CRDIAutoInjector : NSObject

- (id)initWithInjector:(CRDIInjector*)anInjector;

- (void)attachToClass:(Class)classToAttach;

@end
