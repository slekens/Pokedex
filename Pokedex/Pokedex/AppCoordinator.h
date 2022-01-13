//
//  BaseCoordinator.h
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Coordinator.h"
#import "PokemonListCoordinator.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppCoordinator : NSObject<Coordinator>

@property(nonatomic, strong)PokemonListCoordinator *pokemonList;

-(instancetype)initWithWindow:(UIWindow*)window;

@end

NS_ASSUME_NONNULL_END
