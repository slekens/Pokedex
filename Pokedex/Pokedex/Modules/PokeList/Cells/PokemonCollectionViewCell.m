//
//  PokemonCollectionViewCell.m
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import "PokemonCollectionViewCell.h"

@interface PokemonCollectionViewCell()

@property(nonatomic, weak)IBOutlet UILabel *lblName;
@property(nonatomic, weak)IBOutlet UILabel *lblPokemonNumber;
@property(nonatomic, weak)IBOutlet UIImageView *pokemonPicture;
@property(nonatomic, weak)IBOutlet UIView *pokemonColor;
@property(nonatomic, weak)IBOutlet UIView *firstBackground;
@property(nonatomic, weak)IBOutlet UIView *pokeBallButton;

@property(nonatomic, copy)NSString *previousURL;

@end

@implementation PokemonCollectionViewCell

@synthesize pokemonPicture, pokemonColor, lblName, lblPokemonNumber, firstBackground, pokeBallButton;

#pragma mark - Initialization.

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = UIColor.systemGrayColor.CGColor;
}

#pragma mark - Cleaning.

-(void)prepareForReuse {
    [super prepareForReuse];
    self.lblName.text = @"";
    self.lblPokemonNumber.text = @"";
    self.pokemonPicture.image = nil;
}

#pragma mark - View Setup.

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
    __weak PokemonCollectionViewCell  *strongSelf = self;
    [[ImageDownloader sharedImageDownloader]downloadImageWithURL: imageURL andHandler:^(UIImage * _Nullable pokemonSprite, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
        }
        if (strongSelf.previousURL == imageURL) {
            strongSelf.pokemonPicture.image = pokemonSprite;
        }
    }];
    strongSelf.previousURL = imageURL;
}

@end
