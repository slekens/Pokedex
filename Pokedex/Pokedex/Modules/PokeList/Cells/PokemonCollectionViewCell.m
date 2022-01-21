//
//  PokemonCollectionViewCell.m
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import "PokemonCollectionViewCell.h"

@implementation PokemonCollectionViewCell

@synthesize pokemonPicture, pokemonColor, lblName, lblPokemonNumber, firstBackground, pokeBallButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5.0;
}

-(void)configure:(PokemonDisplay *)pokemon {
    self.backgroundColor = [UIColor clearColor];
    self.pokemonColor.backgroundColor = [UIColor whiteColor];
    self.firstBackground.backgroundColor = [UIColor redColor];
    self.pokeBallButton.backgroundColor = [UIColor blackColor];
    self.pokeBallButton.layer.cornerRadius = self.pokeBallButton.frame.size.width / 2;
    self.lblName.text = pokemon.pokemonName;
    self.lblPokemonNumber.text = [NSString stringWithFormat: @"#%ld" ,pokemon.pokemonNumber];
    [self downloadPicture: pokemon.pokemonImage];
}

-(void)downloadPicture:(NSString*)imageURL {
    [[ImageDownloader sharedImageDownloader]downloadImageWithURL: imageURL andHandler:^(UIImage * _Nullable pokemonSprite, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        self.pokemonPicture.image = pokemonSprite;
    }];
}

@end
