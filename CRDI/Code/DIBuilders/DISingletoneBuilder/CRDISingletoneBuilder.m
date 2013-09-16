//
//  CRDISingletoneBuilder.m
//  CRDI
//
//  Created by Vladimir Shevchenko on 16.09.13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRDISingletoneBuilder.h"

@interface CRDISingletoneBuilder ()

@property (nonatomic, unsafe_unretained) Class classToBuild;
@property (nonatomic, strong) id instance;

@end

@implementation CRDISingletoneBuilder

- (id)initWithClass:(Class)aClass
{
    self = [super init];
    
    self.classToBuild = aClass;
    
    return self;
}

- (id)build
{
    if (self.instance == nil) {
        self.instance = [self.classToBuild new];
    }
    
    return self.instance;
}

@end
