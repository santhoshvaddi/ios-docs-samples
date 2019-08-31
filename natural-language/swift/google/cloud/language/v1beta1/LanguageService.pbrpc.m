#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "google/cloud/language/v1beta1/LanguageService.pbrpc.h"
#import "google/cloud/language/v1beta1/LanguageService.pbobjc.h"
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

#import <googleapis/Annotations.pbobjc.h>

@implementation LanguageService

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"google.cloud.language.v1beta1"
                 serviceName:@"LanguageService"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"google.cloud.language.v1beta1"
                 serviceName:@"LanguageService"];
}

#pragma clang diagnostic pop

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName
                 callOptions:(GRPCCallOptions *)callOptions {
  return [self initWithHost:host callOptions:callOptions];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [[self alloc] initWithHost:host callOptions:callOptions];
}

#pragma mark - Method Implementations

#pragma mark AnalyzeSentiment(AnalyzeSentimentRequest) returns (AnalyzeSentimentResponse)

// Deprecated methods.
/**
 * Analyzes the sentiment of the provided text.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)analyzeSentimentWithRequest:(AnalyzeSentimentRequest *)request handler:(void(^)(AnalyzeSentimentResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAnalyzeSentimentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Analyzes the sentiment of the provided text.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAnalyzeSentimentWithRequest:(AnalyzeSentimentRequest *)request handler:(void(^)(AnalyzeSentimentResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AnalyzeSentiment"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AnalyzeSentimentResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Analyzes the sentiment of the provided text.
 */
- (GRPCUnaryProtoCall *)analyzeSentimentWithMessage:(AnalyzeSentimentRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AnalyzeSentiment"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AnalyzeSentimentResponse class]];
}

#pragma mark AnalyzeEntities(AnalyzeEntitiesRequest) returns (AnalyzeEntitiesResponse)

// Deprecated methods.
/**
 * Finds named entities (currently proper names and common nouns) in the text
 * along with entity types, salience, mentions for each entity, and
 * other properties.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)analyzeEntitiesWithRequest:(AnalyzeEntitiesRequest *)request handler:(void(^)(AnalyzeEntitiesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAnalyzeEntitiesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Finds named entities (currently proper names and common nouns) in the text
 * along with entity types, salience, mentions for each entity, and
 * other properties.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAnalyzeEntitiesWithRequest:(AnalyzeEntitiesRequest *)request handler:(void(^)(AnalyzeEntitiesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AnalyzeEntities"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AnalyzeEntitiesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Finds named entities (currently proper names and common nouns) in the text
 * along with entity types, salience, mentions for each entity, and
 * other properties.
 */
- (GRPCUnaryProtoCall *)analyzeEntitiesWithMessage:(AnalyzeEntitiesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AnalyzeEntities"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AnalyzeEntitiesResponse class]];
}

#pragma mark AnalyzeSyntax(AnalyzeSyntaxRequest) returns (AnalyzeSyntaxResponse)

// Deprecated methods.
/**
 * Analyzes the syntax of the text and provides sentence boundaries and
 * tokenization along with part of speech tags, dependency trees, and other
 * properties.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)analyzeSyntaxWithRequest:(AnalyzeSyntaxRequest *)request handler:(void(^)(AnalyzeSyntaxResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAnalyzeSyntaxWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Analyzes the syntax of the text and provides sentence boundaries and
 * tokenization along with part of speech tags, dependency trees, and other
 * properties.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAnalyzeSyntaxWithRequest:(AnalyzeSyntaxRequest *)request handler:(void(^)(AnalyzeSyntaxResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AnalyzeSyntax"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AnalyzeSyntaxResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Analyzes the syntax of the text and provides sentence boundaries and
 * tokenization along with part of speech tags, dependency trees, and other
 * properties.
 */
- (GRPCUnaryProtoCall *)analyzeSyntaxWithMessage:(AnalyzeSyntaxRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AnalyzeSyntax"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AnalyzeSyntaxResponse class]];
}

#pragma mark AnnotateText(AnnotateTextRequest) returns (AnnotateTextResponse)

// Deprecated methods.
/**
 * A convenience method that provides all the features that analyzeSentiment,
 * analyzeEntities, and analyzeSyntax provide in one call.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)annotateTextWithRequest:(AnnotateTextRequest *)request handler:(void(^)(AnnotateTextResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAnnotateTextWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * A convenience method that provides all the features that analyzeSentiment,
 * analyzeEntities, and analyzeSyntax provide in one call.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAnnotateTextWithRequest:(AnnotateTextRequest *)request handler:(void(^)(AnnotateTextResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AnnotateText"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AnnotateTextResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * A convenience method that provides all the features that analyzeSentiment,
 * analyzeEntities, and analyzeSyntax provide in one call.
 */
- (GRPCUnaryProtoCall *)annotateTextWithMessage:(AnnotateTextRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AnnotateText"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AnnotateTextResponse class]];
}

@end
#endif
