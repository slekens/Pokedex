//
//  WebClient.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import "WebClient.h"

@implementation WebClient

#pragma mark - Initialization.

-(id)init {
    if (self = [super init]) {
        self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.manager = [[AFURLSessionManager alloc]initWithSessionConfiguration: self.sessionConfiguration];
    }
    return self;
}

#pragma mark - WS Calls.

-(void)fetchPokemonList:(PokemonCompletionHandler)completionBlock {
    NSURL *url = [NSURL URLWithString: @"https://pokeapi.co/api/v2/pokemon/"];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    self.dataTask = [self.manager dataTaskWithRequest: request uploadProgress: ^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"Upload progress %@", uploadProgress);
    } downloadProgress: ^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"Download Progress %@", downloadProgress);
    } completionHandler: ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Error: %@", error);
                completionBlock(nil, error);
            } else {
                completionBlock([ParsingData parsePokemonDataList: responseObject], nil);
            }
        });
    }];
    [self.dataTask resume];
}

-(void)fetchPokemonData:(PokemonList *)pokemonlist andBlock:(PokemonDataCompletionHandler)completionBlock {
    
    dispatch_group_t group = dispatch_group_create();

    NSMutableArray <Pokemon*> *pokemonList = [NSMutableArray array];
    
    for (Pokemon *pokemon in pokemonlist.pokemonList) {

        dispatch_group_enter(group);
        
        NSURL* url = [NSURL URLWithString: pokemon.url];
        NSURLRequest* request = [NSURLRequest requestWithURL: url];
        
        self.dataTask = [self.manager dataTaskWithRequest: request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"Upload progress %@", uploadProgress);
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"Download Progress %@", downloadProgress);
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error);
                completionBlock(nil, error);
            } else {
                [pokemonList addObject: [ParsingData parsePokemonData: responseObject]];
            }
            dispatch_group_leave(group);
        }];
        [self.dataTask resume];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"All pokemons get");
        completionBlock(pokemonList, nil);
    });
}

@end
