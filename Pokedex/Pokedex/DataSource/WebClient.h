//
//  WebClient.h
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "PokemonList.h"
#import "ParsingData.h"

@interface WebClient : NSObject

typedef void (^PokemonCompletionHandler)(PokemonList * __nullable pokemon, NSError * __nullable error);
typedef void (^PokemonDataCompletionHandler)(NSArray <Pokemon *>* __nullable pokemonList, NSError * __nullable error);

NS_ASSUME_NONNULL_BEGIN

@property(nonatomic, strong)NSURLSessionConfiguration *sessionConfiguration;
@property(nonatomic, strong)AFURLSessionManager *manager;
@property(nonatomic, strong)NSURLSessionDataTask *dataTask;

NS_ASSUME_NONNULL_END

- (void)fetchPokemonList:(PokemonCompletionHandler _Nullable)completionBlock;
- (void)fetchPokemonData:(PokemonList* _Nonnull)pokemonList andBlock:(PokemonDataCompletionHandler _Nullable)completionBlock;

@end

