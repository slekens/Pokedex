//
//  WebClient.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import "WebClient.h"

@implementation WebClient


-(id)init {
    if (self = [super init]) {
        self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.manager = [[AFURLSessionManager alloc]initWithSessionConfiguration: self.sessionConfiguration];
    }
    return self;
}

-(void)fetchPokemonData:(PokemonCompletionHandler)completionBlock {
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
                NSLog(@"Response %@, Object: %@", response, responseObject);
                completionBlock([self parsePokemonData: responseObject], nil);
            }
        });
    }];
    [self.dataTask resume];
}

-(PokemonList*)parsePokemonData:(id)responseObject {
    PokemonList *pokemonList = [[PokemonList alloc]init];
    if ([responseObject isKindOfClass: [NSDictionary class]]) {
        pokemonList.previous = responseObject[@"previous"];
        pokemonList.next = responseObject[@"next"];
        pokemonList.count = [responseObject[@"count"] integerValue];
        pokemonList.pokemonList = [NSMutableArray array];
        if ([responseObject[@"results"] isKindOfClass: [NSArray class]]) {
            for (NSDictionary* item in responseObject[@"results"]) {
                Pokemon *pokemon = [[Pokemon alloc]initWithName: item[@"name"] andURL: item[@"url"]];
                [pokemonList.pokemonList addObject: pokemon];
            }
        }
    }
    return pokemonList;
}

@end
