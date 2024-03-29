//
//  ServiceCell.swift
//  Intervk
//
//  Created by Andrei Kovryzhenko on 28.03.2024.
//

import UIKit

class ServiceCell: UITableViewCell {
    
    let titleServiceLabel = UILabel()
    let descriptionServiceLabel = UILabel()
    let imageService = UIImageView()
    let chevronImage = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Networking
    func configure(with service: Service) {
        titleServiceLabel.text = service.name
        descriptionServiceLabel.text = service.description
        
        DispatchQueue.global().async {
            let stringUrl = service.iconURL
            
            guard let imageURL = URL(string: stringUrl) else { return }
            if let imageData = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageService.image = UIImage(data: imageData)
                }
            }
        }
    }
    
// MARK: - Setup UI
    private func setupCell() {
        backgroundColor = .clear
        setupImage()
        setupChevron()
        setupTitle()
        setupDescription()
    }
    
    private func setupImage() {
        addSubview(imageService)
        imageService.contentMode = .scaleToFill
        imageService.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageService.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            imageService.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageService.widthAnchor.constraint(equalToConstant: self.frame.width / 5),
            imageService.heightAnchor.constraint(equalToConstant: self.frame.width / 5)
        ])
    }
    private func setupChevron() {
        addSubview(chevronImage)
        chevronImage.tintColor = .darkGray
        chevronImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chevronImage.centerYAnchor.constraint(equalTo: imageService.centerYAnchor),
            chevronImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupTitle() {
        addSubview(titleServiceLabel)
        titleServiceLabel.textColor = .white
        titleServiceLabel.font = .boldSystemFont(ofSize: 18)
        titleServiceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleServiceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            titleServiceLabel.leadingAnchor.constraint(equalTo: imageService.trailingAnchor, constant: 20),
        ])
    }
    private func setupDescription() {
        addSubview(descriptionServiceLabel)
        descriptionServiceLabel.textColor = .white
        descriptionServiceLabel.numberOfLines = 0
        descriptionServiceLabel.font = .systemFont(ofSize: 14)
        descriptionServiceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionServiceLabel.topAnchor.constraint(equalTo: titleServiceLabel.bottomAnchor),
            descriptionServiceLabel.leadingAnchor.constraint(equalTo: imageService.trailingAnchor, constant: 20),
            descriptionServiceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}


#Preview{
    ViewController()
}
