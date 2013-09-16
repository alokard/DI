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
    context(@"Default container specs", ^{
        __block CRDIContainer *defaultContainer = nil;
        
        beforeEach(^{
            defaultContainer = [CRDIContainer defaultContainer];
        });
        
        it(@"defaultContainer should not be nil", ^{
            defaultContainer = [CRDIContainer defaultContainer];
            [[defaultContainer shouldNot] beNil];
        });
        
        it(@"default container should be equal to def. contaienr var", ^{
            CRDIContainer *container = [CRDIContainer defaultContainer];
            
            [[container should] equal:defaultContainer];
        });
        
        it(@"defaultContainer should be nil", ^{
            CRDIContainer *container = [CRDIContainer defaultContainer];
            
            [container setDefaultContainer:nil];
            
            CRDIContainer *nilledContainer = [CRDIContainer defaultContainer];
            
            [[nilledContainer should] beNil];
        });
    });
    
    context(@"Container specs", ^{
        __block CRDIContainer *container = nil;
        Protocol *sampleProtocol = @protocol(CRDISampleProtocol);
        
        beforeEach(^{
            container = [CRDIContainer new];
        });
        
        it (@"Should return class builder", ^{
            
            [container bindClass:[CRDISampleClass class] toProtocol:sampleProtocol];
            
            NSObject *builder = [container builderForProtocol:sampleProtocol];
            
            [[builder shouldNot] beNil];
            
            [[theValue([builder conformsToProtocol:@protocol(CRDIDependencyBuilder)]) should] beTrue];
        });
        
        it(@"Should raise exception due to already added protocol", ^{
            [container bindClass:[CRDISampleClass class] toProtocol:sampleProtocol];
             
             [[theBlock(^{
                [container bindClass:[CRDISampleClass class] toProtocol:sampleProtocol];
            }) should] raise];
        });
    });

});

SPEC_END
