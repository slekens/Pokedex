//
//  ViewController.h
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import <UIKit/UIKit.h>
#import "WebClient.h"
#import "PokemonListViewModel.h"
#import "PokemonCollectionViewCell.h"

@interface PokemonListViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PokemonListViewProtocol>

NS_ASSUME_NONNULL_BEGIN

@property(nonatomic, weak)IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong)IBOutlet UICollectionViewFlowLayout *flowLayout;

@property(nonatomic, strong)PokemonListViewModel *viewModel;

NS_ASSUME_NONNULL_END

@end

