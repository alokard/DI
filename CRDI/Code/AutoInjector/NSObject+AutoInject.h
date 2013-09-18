//
//  NSObject+AutoInject.h
//  CRDI
//
//  Created by Sergey Zenchenko on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRDIInjector.h"

@interface NSObject (AutoInject)

+ (void)setInjector:(CRDIInjector *)injector;
+ (CRDIInjector*)injector;

- (id)initWithInject;

@end
