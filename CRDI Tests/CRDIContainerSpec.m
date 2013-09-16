//
//  CRDIContainerSpec.m
//  CRDI Tests
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Kiwi.h>
#import "CRDIContainer.h"
#import "CRDISampleClass.h"
#import "CRDISampleProtocol.h"

SPEC_BEGIN(CRDIContainerSpec)

describe(@"CRDIContainerSpecs", ^{
    
    __block CRDIContainer *container = nil;
    Protocol *sampleProtocol = @protocol(CRDISampleProtocol);
    
    beforeAll(^{
        container = [CRDIContainer defaultContainer];
    });
    
    it(@"Container should not be nil", ^{
        [[container shouldNot] beNil];
    });
    
    it (@"Should return class builder", ^{
        
        [container bindClass:[CRDISampleClass class] toProtocol:sampleProtocol];
        
        NSObject *builder = [container builderForProtocol:sampleProtocol];
        
        [[theValue([builder conformsToProtocol:@protocol(CRDIDependencyBuilder)]) should] beTrue];
    });
    
    it(@"Should raise exception due to already added protocol", ^{
        [[theBlock(^{
            [container bindClass:[CRDISampleClass class] toProtocol:sampleProtocol];
        }) should] raise];
    });
});

SPEC_END
