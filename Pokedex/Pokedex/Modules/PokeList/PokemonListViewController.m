//
//  ViewController.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import "PokemonListViewController.h"

@interface PokemonListViewController()

@property(nonatomic, strong)UISearchController *searchController;
@property(nonatomic, strong)UIBarButtonItem *countItem;
@property(nonatomic, strong)UILabel *itemCount;

@end

@implementation PokemonListViewController

@synthesize flowLayout, collectionView;

#pragma mark - Initialization.

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"MainViewTitle", @"");
    [self setup];
    [self.viewModel viewDidLoad];
}

#pragma mark - Setup.

-(void)setup {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib: [UINib nibWithNibName: @"PokemonCollectionViewCell" bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: @"PokemonCellIdentifier"];
    [self setupLayout];
    [self setupSearchController];
    [self setupToolBar];
}

-(void)setupSearchController {
    self.searchController = [[UISearchController alloc]init];
    self.searchController.searchBar.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = YES;
    self.searchController.searchBar.placeholder = @"Search a Pokemon";
    self.navigationItem.searchController = self.searchController;
    [self setDefinesPresentationContext: YES];
}

-(void)setupToolBar {
    self.itemCount = [[UILabel alloc]initWithFrame: CGRectZero];
    self.itemCount.text = [NSString stringWithFormat: @"%ld", self.viewModel.pokemonList.count];
    self.itemCount.textColor = UIColor.systemRedColor;
    self.countItem = [[UIBarButtonItem alloc]initWithCustomView: self.itemCount];
    [self.toolbar setItems: @[self.countItem]];
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

#pragma mark - View Model Protocol.

-(void)refresh {
    [self.collectionView reloadData];
    [self setupToolBar];
}

-(void)showError:(NSError *)error {
    NSLog(@"Error %@", error.localizedDescription);
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
    NSLog(@"Pokemon Selected: %@", [self.viewModel didSelectAtIndexPath: indexPath]);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row + 1 == self.viewModel.pokemonList.count) {
        [self.viewModel nextDataList];
    }
}

#pragma mark - FlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - Search Delegate
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"Update Search");
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.viewModel search: searchText];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.viewModel cancelSearch];
}

@end
