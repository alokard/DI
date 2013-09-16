//
//  CRDIBuilderSpec.m
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Kiwi.h>
#import "CRDIClassBuilder.h"
#import "CRDIBlockBuilder.h"
#import "CRDIContainer.h"

#import "CRDISampleClass.h"
#import "CRDISampleProtocol.h"

SPEC_BEGIN(CRDIClassBuilderSpec)

describe(@"CRDIClassBuilderSpecs", ^{
    __block CRDIContainer *container = nil;
    
    Protocol *sampleProtocol = @protocol(CRDISampleProtocol);
    
    beforeEach(^{
        container = [CRDIContainer new];
    });
    
    context(@"Class builder Context", ^{
        __block CRDIClassBuilder *classBuilder = nil;
        
        beforeAll(^{
            [container bindClass:[CRDISampleClass class] toProtocol:sampleProtocol];
            
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
            
            [[sampleClass should] beKindOfClass:[CRDISampleClass class]];
        });
    });
    
    context(@"Block builder context", ^{
        __block CRDIBlockBuilder *blockBuilder = nil;
        
        beforeAll(^{
            [container bindBlock:^id{
                return [NSNull null];
            } toProtocol:sampleProtocol];
            
            blockBuilder = [container builderForProtocol:sampleProtocol];
        });
        
        it(@"block builder should not be nil", ^{
            [[blockBuilder shouldNot] beNil];
            
            [[blockBuilder should] beKindOfClass:[CRDIBlockBuilder class]];
        });
        
        it(@"builded object should not be nil", ^{
            [[[blockBuilder build] shouldNot] beNil];
        });
        
        it(@"block builder should return object if NSNULL class", ^{
            [[[blockBuilder build] should] beKindOfClass:[NSNull class]];
        });
    });
});

SPEC_END
