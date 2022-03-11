//
//  CoreDataManager.h
//  Pokedex
//
//  Created by Abraham Abreu on 01/02/22.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Constants.h"
#import "PokemonMO.h"
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

typedef void (^PokemonListHandler)(NSMutableArray<Pokemon *>* __nullable pokemonList, NSError * __nullable error);
typedef void (^SaveHandler)(BOOL isSuccess, NSError * __nullable error);

-(void)fetchResults:(PokemonListHandler)completionHandler;
-(void)saveNewPokemon:(Pokemon*)pokemon andHandler:(SaveHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
