#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
//#import "google/cloud/language/v1beta1/LanguageService.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class AnalyzeEntitiesRequest;
@class AnalyzeEntitiesResponse;
@class AnalyzeSentimentRequest;
@class AnalyzeSentimentResponse;
@class AnalyzeSyntaxRequest;
@class AnalyzeSyntaxResponse;
@class AnnotateTextRequest;
@class AnnotateTextResponse;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  #import <googleapis/Annotations.pbobjc.h>
#endif

@class GRPCProtoCall;
@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;


NS_ASSUME_NONNULL_BEGIN

@protocol LanguageService2 <NSObject>

#pragma mark AnalyzeSentiment(AnalyzeSentimentRequest) returns (AnalyzeSentimentResponse)

/**
 * Analyzes the sentiment of the provided text.
 */
- (GRPCUnaryProtoCall *)analyzeSentimentWithMessage:(AnalyzeSentimentRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AnalyzeEntities(AnalyzeEntitiesRequest) returns (AnalyzeEntitiesResponse)

/**
 * Finds named entities (currently proper names and common nouns) in the text
 * along with entity types, salience, mentions for each entity, and
 * other properties.
 */
- (GRPCUnaryProtoCall *)analyzeEntitiesWithMessage:(AnalyzeEntitiesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AnalyzeSyntax(AnalyzeSyntaxRequest) returns (AnalyzeSyntaxResponse)

/**
 * Analyzes the syntax of the text and provides sentence boundaries and
 * tokenization along with part of speech tags, dependency trees, and other
 * properties.
 */
- (GRPCUnaryProtoCall *)analyzeSyntaxWithMessage:(AnalyzeSyntaxRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AnnotateText(AnnotateTextRequest) returns (AnnotateTextResponse)

/**
 * A convenience method that provides all the features that analyzeSentiment,
 * analyzeEntities, and analyzeSyntax provide in one call.
 */
- (GRPCUnaryProtoCall *)annotateTextWithMessage:(AnnotateTextRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

/**
 * The methods in this protocol belong to a set of old APIs that have been deprecated. They do not
 * recognize call options provided in the initializer. Using the v2 protocol is recommended.
 */
@protocol LanguageService <NSObject>

#pragma mark AnalyzeSentiment(AnalyzeSentimentRequest) returns (AnalyzeSentimentResponse)

/**
 * Analyzes the sentiment of the provided text.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)analyzeSentimentWithRequest:(AnalyzeSentimentRequest *)request handler:(void(^)(AnalyzeSentimentResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Analyzes the sentiment of the provided text.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAnalyzeSentimentWithRequest:(AnalyzeSentimentRequest *)request handler:(void(^)(AnalyzeSentimentResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AnalyzeEntities(AnalyzeEntitiesRequest) returns (AnalyzeEntitiesResponse)

/**
 * Finds named entities (currently proper names and common nouns) in the text
 * along with entity types, salience, mentions for each entity, and
 * other properties.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)analyzeEntitiesWithRequest:(AnalyzeEntitiesRequest *)request handler:(void(^)(AnalyzeEntitiesResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Finds named entities (currently proper names and common nouns) in the text
 * along with entity types, salience, mentions for each entity, and
 * other properties.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAnalyzeEntitiesWithRequest:(AnalyzeEntitiesRequest *)request handler:(void(^)(AnalyzeEntitiesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AnalyzeSyntax(AnalyzeSyntaxRequest) returns (AnalyzeSyntaxResponse)

/**
 * Analyzes the syntax of the text and provides sentence boundaries and
 * tokenization along with part of speech tags, dependency trees, and other
 * properties.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)analyzeSyntaxWithRequest:(AnalyzeSyntaxRequest *)request handler:(void(^)(AnalyzeSyntaxResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Analyzes the syntax of the text and provides sentence boundaries and
 * tokenization along with part of speech tags, dependency trees, and other
 * properties.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAnalyzeSyntaxWithRequest:(AnalyzeSyntaxRequest *)request handler:(void(^)(AnalyzeSyntaxResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AnnotateText(AnnotateTextRequest) returns (AnnotateTextResponse)

/**
 * A convenience method that provides all the features that analyzeSentiment,
 * analyzeEntities, and analyzeSyntax provide in one call.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)annotateTextWithRequest:(AnnotateTextRequest *)request handler:(void(^)(AnnotateTextResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * A convenience method that provides all the features that analyzeSentiment,
 * analyzeEntities, and analyzeSyntax provide in one call.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAnnotateTextWithRequest:(AnnotateTextRequest *)request handler:(void(^)(AnnotateTextResponse *_Nullable response, NSError *_Nullable error))handler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface LanguageService : GRPCProtoService<LanguageService, LanguageService2>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
// The following methods belong to a set of old APIs that have been deprecated.
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

