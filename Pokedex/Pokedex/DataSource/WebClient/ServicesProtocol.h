//
//  ServicesProtocol.h
//  Pokedex
//
//  Created by Abraham Abreu on 14/01/22.
//

#import "PokemonList.h"
#import "Pokemon.h"

#ifndef ServicesProtocol_h
#define ServicesProtocol_h

@protocol PokemonParserProtocol <NSObject>

typedef void (^PokemonParserHandler)(NSArray <Pokemon *>* __nullable pokemonList, NSError* __nullable error);

NS_ASSUME_NONNULL_BEGIN

-(PokemonList*)parsePokemonDataList:(NSData*)responseObject;
-(Pokemon*)parsePokemonData:(NSData*)responseObject;
-(PokemonImage*)parsePokemonSprites:(NSData*)responseObject;

NS_ASSUME_NONNULL_END

@end

@protocol PokemonFetcherProtocol <NSObject>

typedef void (^PokemonCompletionHandler)(PokemonList * __nullable pokemon, NSError * __nullable error);
typedef void (^PokemonDataCompletionHandler)(NSArray <Pokemon *>* __nullable pokemonList, NSError * __nullable error);

-(void)fetchList:(PokemonCompletionHandler _Nonnull)completionBlock;
-(void)fetchPokemonData:(PokemonList * _Nonnull)pokemonlist andBlock:(PokemonDataCompletionHandler _Nonnull)completionBlock;

@end
#endif /* ServicesProtocol_h */
