//
//  ViewController.swift
//  LoginProject
//
//  Created by 송선진 on 2022/08/08.
//

import UIKit
import SnapKit



final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let emailTextFieldView = CustomTextFieldView()
    private var emailInfoLable = CustomInfoLabel(info: "이메일 주소 또는 전화번호")
    private lazy var emailTextField = CustomTextField()
    private lazy var passwordTextFieldView = CustomTextFieldView()
    private var passwordInfoLable = CustomInfoLabel(info: "비밀번호")
    private lazy var passwordTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        return tf
    }()
    
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        // view의 모서리 둥글게 하기 위해선 아래 2개 필요
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        //
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        // 아이디 비밀번호가 둘 다 입력이 되어야지만 로그인 버튼 활성화
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        st.spacing = 18
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        
        return st
    }()
    
    
    // 비밀번호 재설정 버튼
    private lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        makeUI()
        autoLayout()
    }

    // MARK: - Helpers

    // 3개의 각 텍스트필드 및 로그인 버튼 높이 설정
    private let textViewHeight: CGFloat = 40
    
    func makeUI() {
        view.backgroundColor = .black
        
        emailTextFieldView.addSubview(emailTextField)
        emailTextFieldView.addSubview(emailInfoLable)
        emailTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        passwordTextFieldView.addSubview(passwordTextField)
        passwordTextFieldView.addSubview(passwordInfoLable)
        passwordTextFieldView.addSubview(passwordSecureButton)
        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(passwordResetButton)
    }

    func autoLayout() {
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.trailing.equalToSuperview().inset(150)
        }

        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(2)
        }
        
        emailInfoLable.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(2)
        }
        
        passwordInfoLable.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        passwordSecureButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.top.bottom.equalToSuperview().inset(15)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(textViewHeight *  3 + 36)
        }
        
        passwordResetButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.height.equalTo(textViewHeight)
        }
    }
    
    
    // MARK: - Actions
    
    @objc func resetButtonTapped() {
        
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼 눌림")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancel in
            print("취소버튼 눌림")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        // present: 다음 화면으로 넘어가는 버튼
        present(alert, animated: true) {
            print("완료되었음.")
        }
    }
    
    @objc func passwordSecureModeSetting() {
        // ***으로 표시된 비밀번호 원래 문자 그대로 보이게 함
        passwordTextField.isSecureTextEntry.toggle()
    }

    
    // 백그라운드 누르면 키보드 내려가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func loginButtonTapped() {
        print("로그인 버튼 눌림")
    }
}


// MARK: - Extensions

// UITextFieldDelegate: TextField 수정하기 위해 델리게이트 패턴 프로토콜 채택
extension ViewController: UITextFieldDelegate {
    
    // textField 눌렀을 때 = focus가 textfield
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = .lightGray
            emailInfoLable.font = UIFont.systemFont(ofSize: 11)
            // 클릭시 애니메이션 효과
            emailInfoLable.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-11)
            }
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = .lightGray
            passwordInfoLable.font = UIFont.systemFont(ofSize: 11)
            passwordInfoLable.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-11)
            }
        }
        
        // 애니메이션
        UIView.animate(withDuration: 0.3) {
            // 애니메이션이 필요한 모든 view에 다 걸어야 함.
            self.stackView.layoutIfNeeded()
        }
    }
    
    
    // textField 누른 후 액션 모두 다한 뒤 = focus가 textfield 해지
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = .darkGray
            
            if emailTextField.text == "" {
                emailInfoLable.font = UIFont.systemFont(ofSize: 18)
                emailInfoLable.snp.updateConstraints { make in
                    make.centerY.equalToSuperview().offset(0)
                }
            }
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = .darkGray
            
            if passwordTextField.text == "" {
                passwordInfoLable.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLable.snp.updateConstraints { make in
                    make.centerY.equalToSuperview().offset(0)
                }
            }
        }
        
        // 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
}
