

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    @IBOutlet weak var previousResultButton: UIButton!
    @IBOutlet weak var nextResultsButton : UIButton!
    let pokeDataSource: PokeDataSource = PokeDataSource()
    lazy  var presenter: PokemonListPresenterProtocol = PokemonListPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pokeCollectionView.dataSource = pokeDataSource
        pokeCollectionView.delegate = self
        presenter.loadInitialPokemonList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showPokemonInfo",
            let detailVC = segue.destination as? PokemonDetailViewController,
            let name = sender as? String {
            detailVC.pokemonName = name
        }
    }
    @IBAction func didSelectPreviousResults(_ sender: Any){
        presenter.fetchMoreResult(for: .previous)
        
    }
    @IBAction func didSelectNextResult(_ sender: Any){
        presenter.fetchMoreResult(for: .next)
        
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let pokemonName = pokeDataSource.getPokemonNames()[indexPath.row].name
        self.performSegue(withIdentifier: "showPokemonInfo", sender: pokemonName)
    }
}

extension ViewController : PokemonlistViewProtocol {
    func enableButtonLoading(for buttonVisibility: ButtonVisibility) {
        previousResultButton.isHidden = buttonVisibility.0
        nextResultsButton.isHidden = buttonVisibility.1
    }
    func refreshPokeCollectionView(with pokemonData: PokemonData) {
        self.pokeDataSource.setPokemonNames(pokemonNames: pokemonData.results)
        self.pokeCollectionView.reloadData()
    }
    
    
}







