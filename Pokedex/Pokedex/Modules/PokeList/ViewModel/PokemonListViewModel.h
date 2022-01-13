//
//  PokemonListViewModel.h
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"
#import "WebClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonListViewModel : NSObject

@property(nonatomic, strong)WebClient *service;
@property(nonatomic, copy)NSMutableArray<Pokemon *> *pokemonList;
@property(nonatomic, copy)NSString *title;

-(instancetype)initWithService:(WebClient*)client;

@end

NS_ASSUME_NONNULL_END
