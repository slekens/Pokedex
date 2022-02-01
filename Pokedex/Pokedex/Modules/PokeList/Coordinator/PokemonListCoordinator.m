//
//  PokemonListCoordinator.m
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import "PokemonListCoordinator.h"

@implementation PokemonListCoordinator

@synthesize rootController;

#pragma mark - Initialization.

-(UIViewController*)start {
    PokemonListViewController* pokemonListController = [[PokemonListViewController alloc]initWithNibName: kMainViewName bundle: [NSBundle mainBundle]];
    ParsingData *parser = [[ParsingData alloc]init];
    WebClient *client = [[WebClient alloc]initWithParser: parser];
    PokemonListViewModel *viewModel = [[PokemonListViewModel alloc]initWithService: client];
    viewModel.pokemonListView = pokemonListController;
    pokemonListController.viewModel = viewModel;
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController: pokemonListController];
    navController.navigationBar.prefersLargeTitles = YES;
    self.rootController = navController;
    return self.rootController;
}

@end
