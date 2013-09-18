//
//  CRDIInjectorSpec.m
//  CRDI
//
//  Created by TheSooth on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Kiwi.h>
#import "CRDIInjector.h"
#import "CRDIContainer.h"

#import "CRDISampleClass.h"
#import "CRDISampleProtocol.h"
#import "CRDIInjectedClass.h"

SPEC_BEGIN(CRDIInjectorSpec)

describe(@"CRDIInjector Specs", ^{
    it(@"Should return this same object for default injector", ^{
        CRDIInjector *injector = [CRDIInjector new];
        
        [CRDIInjector setDefaultInjector:injector];
        
        [[injector should] equal:[CRDIInjector defaultInjector]];
    });
   
    it(@"Should return object with injected property", ^{
        CRDISampleClass *sampleObject = [CRDISampleClass new];
        id builderMock = [KWMock mockForProtocol:@protocol(CRDIDependencyBuilder)];
        [builderMock stub:@selector(build) andReturn:sampleObject];
        
        id containerMock = [KWMock mockForClass:[CRDIContainer class]];
        [containerMock stub:@selector(builderForProtocol:) andReturn:builderMock];
        
        CRDIInjector *injector = [[CRDIInjector alloc] initWithContainer:containerMock];
        
        CRDIInjectedClass *classWhichMustBeInjected = [CRDIInjectedClass new];
        
        [injector injectImplementationsToInstance:classWhichMustBeInjected];
        
        [[classWhichMustBeInjected.ioc_injected shouldNot] beNil];
        
        [[classWhichMustBeInjected.ioc_injected should] equal:sampleObject];
        
        [[theValue([classWhichMustBeInjected.ioc_injected conformsToProtocol:@protocol(CRDISampleProtocol)]) should] beTrue];
    });
    
    context(@"Initialization", ^{
       it(@"should throw an exception if nil container is received", ^{
          [[theBlock(^{
              CRDIInjector *injector = [[CRDIInjector alloc] initWithContainer:nil];
          }) should] raise];
       });
    });
    
});

SPEC_END
