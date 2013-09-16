//
//  CRDIBuilderSpec.m
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Kiwi.h>
#import "CRDIClassBuilder.h"
#import "CRDIContainer.h"

#import "CRDISampleClass.h"
#import "CRDISampleProtocol.h"

SPEC_BEGIN(CRDIClassBuilderSpec)

describe(@"CRDIClassBuilderSpecs", ^{
    __block CRDIContainer *container = nil;
    
    Protocol *sampleProtocol = @protocol(CRDISampleProtocol);
    Protocol *anotherSampleProtocol = @protocol(CRDIAnotherSampleProtocol);
    
    beforeAll(^{
        container = [CRDIContainer defaultContainer];
        [container bindClass:[CRDISampleClass class] toProtocol:sampleProtocol];
        [container bindBlock:^id{
            return [NSNull null];
        } toProtocol:anotherSampleProtocol];
    });
    
    context(@"Class builder Context", ^{
        __block CRDIClassBuilder *classBuilder = nil;
        
        beforeAll(^{
            classBuilder = [container builderForProtocol:sampleProtocol];
        });
        
        it(@"class builder should not be nil", ^{
            [[classBuilder shouldNot] beNil];
            [[classBuilder should] beKindOfClass:[CRDIClassBuilder class]];
        });
        
        it(@"builded object should not be nil", ^{
            [[[classBuilder build] shouldNot] beNil];
        });
        
        it(@"buider should build object of class CRSampleClass", ^{
            CRDISampleClass *sampleClass = [classBuilder build];
            
            [[sampleClass should] isKindOfClass:[CRDISampleClass class]];
        });
        
        it(@"builded class should conforms to CRDISampleProtocol", ^{
            CRDISampleClass *sampleClass = [classBuilder build];
            
            [[theValue([sampleClass conformsToProtocol:sampleProtocol]) should] beTrue];
        });
    });
});

SPEC_END
