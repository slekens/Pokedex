//
//  WebClient.h
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "PokemonList.h"

@interface WebClient : NSObject

typedef void (^PokemonCompletionHandler)(PokemonList * __nullable pokemon, NSError * __nullable error);

NS_ASSUME_NONNULL_BEGIN

@property(nonatomic, strong)NSURLSessionConfiguration *sessionConfiguration;
@property(nonatomic, strong)AFURLSessionManager *manager;
@property(nonatomic, strong)NSURLSessionDataTask *dataTask;

NS_ASSUME_NONNULL_END

- (void)fetchPokemonData:(PokemonCompletionHandler _Nullable)completionBlock;

@end

