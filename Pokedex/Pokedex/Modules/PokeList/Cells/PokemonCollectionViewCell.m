//
//  PokemonCollectionViewCell.m
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import "PokemonCollectionViewCell.h"

@implementation PokemonCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)configure:(Pokemon *)pokemon {
    self.backgroundColor = [UIColor systemRedColor];
    self.lblName.text = pokemon.name;
}

@end
