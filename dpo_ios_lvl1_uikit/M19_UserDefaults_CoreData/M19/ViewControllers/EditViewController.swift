//
//  File.swift
//  M20
//
//  Created by Николай Ногин on 19.08.2022.
//

import UIKit
import SnapKit
import CoreData

class EditViewController: UIViewController {
    
    public var container: NSPersistentContainer?
    public var artistModel: Artist?
    public var edit: Bool = false
    
    @IBOutlet weak var fieldsStack: UIStackView!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var lastNameStack: UIStackView!
    @IBOutlet weak var dateOfBirthStack: UIStackView!
    @IBOutlet weak var countryStack: UIStackView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthdayTextfield: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBAction func onSaveClick(_ sender: Any) {
        save()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrains()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        edit = false
    }
    
    
    private func save() {

        artistModel?.name = nameTextField.text
        artistModel?.lastName = lastNameTextField.text
        artistModel?.birth = dateOfBirthdayTextfield.text
        artistModel?.country = countryTextField.text
        
        if (edit == false) {
            container!.viewContext.insert(artistModel!)
        }

        try? container!.viewContext.save()
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateUI() {
        nameTextField.text = artistModel?.name
        lastNameTextField.text = artistModel?.lastName
        dateOfBirthdayTextfield.text = artistModel?.birth
        countryTextField.text = artistModel?.country
    }
    
    func setupConstrains() {
    
        fieldsStack.spacing = 20
        fieldsStack.distribution = .fill
        fieldsStack.alignment = .center
        
        saveBtn.layer.cornerRadius = 6
    
        fieldsStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        nameStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        lastNameStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        dateOfBirthStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        countryStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        saveBtn.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
    }
    
}
