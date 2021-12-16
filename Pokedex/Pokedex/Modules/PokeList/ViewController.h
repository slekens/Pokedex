//
//  ViewController.h
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import <UIKit/UIKit.h>
#import "WebClient.h"
#import "PokemonCollectionViewCell.h"

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, assign)IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong)IBOutlet UICollectionViewFlowLayout *flowLayout;

@property(nonatomic, copy)NSMutableArray<Pokemon *> *pokemonList;

@end

