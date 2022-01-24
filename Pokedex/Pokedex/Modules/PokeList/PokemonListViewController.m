//
//  ViewController.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import "PokemonListViewController.h"

@implementation PokemonListViewController

@synthesize flowLayout, collectionView;

#pragma mark - Initialization.

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"MainViewTitle", @"");
    [self setup];
    [self.viewModel viewDidLoad];
}

#pragma mark - Setup

-(void)setup {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib: [UINib nibWithNibName: @"PokemonCollectionViewCell" bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: @"PokemonCellIdentifier"];
    [self setupLayout];
}

-(void)setupLayout {
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    [self.flowLayout setItemSize: CGSizeMake(width / 3, 140)];
    [self.flowLayout setScrollDirection: UICollectionViewScrollDirectionVertical];
    self.flowLayout.minimumLineSpacing = 5.0f;
    self.flowLayout.minimumInteritemSpacing = 5.0f;
    [self.collectionView setCollectionViewLayout: self.flowLayout];
    self.collectionView.bounces = YES;
}

-(void)refresh {
    [self.collectionView reloadData];
}

#pragma mark - UICollection Data Source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.numberOfSections;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.numberOfItems;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PokemonCellIdentifier";
    PokemonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifier forIndexPath: indexPath];
    [cell configure: [self.viewModel itemAtIndexPath: indexPath]];
    return cell;
}

#pragma mark - UIcollection Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Pokemon Selected: %@", self.viewModel.pokemonList[indexPath.row].pokemonName);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row + 1 == self.viewModel.pokemonList.count) {
        NSLog(@"Call next WS");
    }
}

#pragma mark - FlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
