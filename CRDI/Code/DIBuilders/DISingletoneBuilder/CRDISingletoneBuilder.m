//
//  CRDISingletoneBuilder.m
//  CRDI
//
//  Created by Vladimir Shevchenko on 16.09.13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDISingletoneBuilder.h"

@interface CRDISingletoneBuilder ()

@property (nonatomic, strong) id sharedInstance;

@property (nonatomic, weak) id <CRDIDependencyBuilder> instanceBuilder;

@end

@implementation CRDISingletoneBuilder

- (id)initWithBuilder:(id <CRDIDependencyBuilder>)aBuilder
{
    NSAssert(aBuilder, @"aBuilder == nil");
    NSAssert([aBuilder conformsToProtocol:@protocol(CRDIDependencyBuilder)], @"aBuilder not implemet CRDIDependencyBuilder protocol");
    
    self = [super init];
    
    assert(self);
    
    self.instanceBuilder = aBuilder;
    
    return self;
}

- (id)build
{
    dispatch_queue_t queue = dispatch_queue_create("CRDISingletoneBuilder queue", 0);
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_sync(queue, ^{
        if (!weakSelf.sharedInstance) {
            weakSelf.sharedInstance = [weakSelf.instanceBuilder build];
        }
    });
    
    return self.sharedInstance;
}

@end
