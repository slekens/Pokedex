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

-(void)configure:(PokemonDisplay *)pokemon;

@end

NS_ASSUME_NONNULL_END
