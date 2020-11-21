//
//  CharacterDetailViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 18/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class CharacterDetailViewModel {
    
    private weak var view: CharacterDetailViewController?

    func bind(view: CharacterDetailViewController) {
        self.view = view
    }
    
    func getCharacterData(_ characterId: Int) -> Observable<CharacterDetailModel> {
        return CharacterService().getCharacter(with: characterId)
    }
}
