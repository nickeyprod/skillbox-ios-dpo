//
//  DetailView.swift
//  MVVM_Project
//
//  Created by Николай Ногин on 05.09.2022.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {

    var detailVM = DetailViewModel()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        return img
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.Colors.headerColor
        label.font = UIFont(name: Constants.Fonts.interSemiBold, size: 22)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var filmDescription: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.textColor
        label.font = UIFont(name: Constants.Fonts.interRegular, size: 19)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img.image = detailVM.selectedFilm?.image
        name.text = detailVM.selectedFilm?.title
        filmDescription.text = detailVM.selectedFilm?.description
        
        stackView.addArrangedSubview(img)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(filmDescription)
        
        view.addSubview(stackView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        img.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).inset(20)
        }
    }
    
    
}
