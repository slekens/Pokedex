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
    self.rootController = [[UINavigationController alloc]initWithRootViewController: pokemonListController];
    [self configureNavigationBar];
    return self.rootController;
}

-(void)configureNavigationBar {
    self.rootController.navigationBar.prefersLargeTitles = YES;
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc]init];
    [appearance configureWithTransparentBackground];
    appearance.backgroundEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleProminent];
    [self.rootController.navigationBar setCompactAppearance: appearance];
    [self.rootController.navigationBar setScrollEdgeAppearance: appearance];
    [self.rootController.navigationBar setStandardAppearance: appearance];
}

@end
