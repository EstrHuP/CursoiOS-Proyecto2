//
//  UserFormViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 25/1/22.
//

import UIKit

struct UserFormViewModel {
    let name: String?
    let lastName: String?
    let phone: String?
    let mail: String?
    let bio: String?
}

class UserFormViewController: UIViewController, UserFormViewContract {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = "user_form_name_label".localized
        }
    }
    @IBOutlet weak var lastNameLabel: UILabel! {
        didSet {
            lastNameLabel.text = "user_form_last_name_label".localized
        }
    }
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet weak var mailInput: UITextField!
    @IBOutlet weak var userBioTextArea: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var presenter: UserFormPresenterContract?
    
    @IBAction func scrollViewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        presenter?.didPressEnd()
    }
    
    @IBAction func inputDidChange(_ textField: UITextField) {
        textFieldDidChange(textField)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userBioTextArea.delegate = self
        
        [nameInput, lastNameInput, phoneInput, mailInput].forEach { input in
            input?.delegate = self
        }
        
        presenter?.didLoad()
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case nameInput: presenter?.didUpdateName(textField.text)
        case lastNameInput: presenter?.didUpdateLastName(textField.text)
        case phoneInput: presenter?.didUpdatePhone(textField.text)
        case mailInput: presenter?.didUpdateMail(textField.text)
        default: break
        }
    }
    
    func configure(with viewModel: UserFormViewModel) {
        DispatchQueue.main.async {
            self.nameInput.text = viewModel.name
            self.lastNameInput.text = viewModel.lastName
            self.phoneInput.text = viewModel.phone
            self.mailInput.text = viewModel.mail
            self.userBioTextArea.text = viewModel.bio
        }
    }
    
    func didValidateName(_ valid: Bool) {
        didUpdateValidation(input: nameInput, valid: valid)
    }
    
    func didValidateLastName(_ valid: Bool) {
        didUpdateValidation(input: lastNameInput, valid: valid)
    }
    
    func didValidatePhone(_ valid: Bool) {
        didUpdateValidation(input: phoneInput, valid: valid)
    }
    
    func didValidateMail(_ valid: Bool) {
        didUpdateValidation(input: mailInput, valid: valid)
    }
    
    private func didUpdateValidation(input: UITextField, valid: Bool) {
        DispatchQueue.main.async {
            input.backgroundColor = valid ? .systemBackground : .systemRed
        }
    }
    
    func showValidationError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error de validación", message: "Por favor, revisa los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
    
    //MARK: Gestion de memoria
    deinit {
        print("deinit \(self)")
    }
}

extension UserFormViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        presenter?.didUpdateBio(textView.text)
    }
}

extension UserFormViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidChange(textField)
    }
    
    //return button in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameInput: lastNameInput.becomeFirstResponder()
        case lastNameInput: phoneInput.becomeFirstResponder()
        case phoneInput: mailInput.becomeFirstResponder()
        case mailInput: textField.resignFirstResponder() // hide keyboard
        default: break
        }
        return true
    }
}
