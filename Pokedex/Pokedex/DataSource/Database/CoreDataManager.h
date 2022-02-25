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
#import "PokemonDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

-(NSMutableArray<PokemonDisplay *>*)fetchResults;
-(void)saveNewPokemon:(PokemonDisplay*)pokemon;
-(void)deleteAllPokemons;

@end

NS_ASSUME_NONNULL_END
