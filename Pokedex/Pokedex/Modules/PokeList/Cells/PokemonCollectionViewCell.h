//
//  PokemonCollectionViewCell.h
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonCollectionViewCell : UICollectionViewCell

@property(nonatomic, assign)IBOutlet UILabel *lblName;

-(void)configure:(Pokemon *)pokemon;

@end

NS_ASSUME_NONNULL_END
