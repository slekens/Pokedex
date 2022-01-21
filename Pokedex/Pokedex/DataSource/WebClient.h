//
//  WebClient.h
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import <Foundation/Foundation.h>
#import "ServicesProtocol.h"
#import "PokemonList.h"
#import "ParsingData.h"

@interface WebClient : NSObject<PokemonFetcherProtocol>

NS_ASSUME_NONNULL_BEGIN

@property(nonatomic, strong)NSURLSessionConfiguration *sessionConfiguration;
@property(nonatomic, strong)NSURLSession *manager;
@property(nonatomic, strong)NSURLSessionDataTask *dataTask;

-(instancetype)initWithParser:(id<PokemonParserProtocol>)parser;

NS_ASSUME_NONNULL_END


@end

