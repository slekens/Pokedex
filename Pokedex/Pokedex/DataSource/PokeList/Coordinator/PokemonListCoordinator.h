//
//  PokemonListCoordinator.h
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Coordinator.h"
#import "PokemonListViewModel.h"
#import "PokemonListViewController.h"
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonListCoordinator : NSObject<Coordinator>

@property(nonatomic, strong)UINavigationController *rootController;

@end

NS_ASSUME_NONNULL_END
