//
//  ViewController.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Initialization.

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"MainViewTitle", @"");
    [self setup];
    [self callWebServices];
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
    [self.flowLayout setItemSize: CGSizeMake(width / 3, 110)];
    [self.flowLayout setScrollDirection: UICollectionViewScrollDirectionVertical];
    self.flowLayout.minimumLineSpacing = 5.0f;
    self.flowLayout.minimumInteritemSpacing = 5.0f;
    [self.collectionView setCollectionViewLayout: self.flowLayout];
    self.collectionView.bounces = YES;
}

-(void)callWebServices {
    WebClient *client = [[WebClient alloc]init];
    
    [client fetchPokemonList: ^(PokemonList * _Nullable pokemon, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"Pokemons: %@", pokemon.pokemonList);
            [client fetchPokemonData: pokemon andBlock: ^(NSArray<Pokemon *> * _Nullable pokemonList, NSError * _Nullable error) {
                if (error == nil) {
                    self.pokemonList = [[NSMutableArray alloc]initWithArray: pokemonList];
                    [self.collectionView reloadData];
                } else {
                    NSLog(@"Error %@", error);
                }
            }];
        } else {
            NSLog(@"An error ocurred: %@", error);
        }
    }];
}

#pragma mark - UICollection Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pokemonList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PokemonCellIdentifier";
    PokemonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifier forIndexPath: indexPath];
    [cell configure: self.pokemonList[indexPath.row]];
    
    return cell;
}

#pragma mark - UIcollection Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Pokemon Selected: %ld", indexPath.row);
}

#pragma mark - FlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
