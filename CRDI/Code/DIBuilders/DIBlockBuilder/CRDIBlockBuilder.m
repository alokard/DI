//
//  CRDIBlockBuilder.m
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDIBlockBuilder.h"

@interface CRDIBlockBuilder ()

@property (nonatomic, copy) CRDIContainerBindBlock bindBlock;

@end

@implementation CRDIBlockBuilder

- (id)initWithBlock:(CRDIContainerBindBlock)aBindBlock
{
    self = [super init];
    
    assert(self);
    
    self.bindBlock = aBindBlock;
    
    return self;
}

- (id)build
{
    return self.bindBlock();
}

@end
