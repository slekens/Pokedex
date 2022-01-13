//
//  PokemonListCoordinator.m
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import "PokemonListCoordinator.h"

@implementation PokemonListCoordinator

@synthesize rootController;

-(UIViewController*)start {
    PokemonListViewController* pokemonListController = [[PokemonListViewController alloc]initWithNibName: kMainViewName bundle: [NSBundle mainBundle]];
    self.rootController = [[UINavigationController alloc]initWithRootViewController: pokemonListController];
    return self.rootController;
}

@end
