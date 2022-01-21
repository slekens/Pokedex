//
//  PokemonCollectionViewCell.h
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "PokemonDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonCollectionViewCell : UICollectionViewCell

@property(nonatomic, weak)IBOutlet UILabel *lblName;
@property(nonatomic, weak)IBOutlet UILabel *lblPokemonNumber;
@property(nonatomic, weak)IBOutlet UIImageView *pokemonPicture;
@property(nonatomic, weak)IBOutlet UIView *pokemonColor;
@property(nonatomic, weak)IBOutlet UIView *firstBackground;
@property(nonatomic, weak)IBOutlet UIView *pokeBallButton;

-(void)configure:(PokemonDisplay *)pokemon;

@end

NS_ASSUME_NONNULL_END
