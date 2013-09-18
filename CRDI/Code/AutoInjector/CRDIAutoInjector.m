//
//  CRDIAutoInjector.m
//  CRDI
//
//  Created by Sergey Zenchenko on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDIAutoInjector.h"

@interface CRDIAutoInjector ()

@property (nonatomic, strong) CRDIInjector *injector;

@end

@implementation CRDIAutoInjector

- (id)initWithInjector:(CRDIInjector*)anInjector;
{
    NSParameterAssert(anInjector);
    self = [super init];
    if (self) {
        self.injector = anInjector;
    }
    return self;
}

- (void)attachToClass:(Class)classToAttach
{
    
}

@end
