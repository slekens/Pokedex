//
//  Pokemon.h
//  Pokedex
//
//  Created by Abraham Abreu on 03/12/21.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonList : NSObject

@property(nonatomic, copy) NSString * _Nullable previous;
@property(nonatomic, copy) NSString * _Nullable next;
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, strong)NSMutableArray<Pokemon*> *pokemonList;

-(instancetype)initWithNext:(NSString *)next andPrevious:(NSString*)previous andCount:(NSInteger)count andPokemons:(NSMutableArray<Pokemon*>*)pokemonList;

@end

NS_ASSUME_NONNULL_END
