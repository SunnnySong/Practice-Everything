//
//  ViewController.swift
//  LoginProject
//
//  Created by 송선진 on 2022/08/08.
//

import UIKit

// 연습 1.
//class ViewController: UIViewController {
//
//    // 메모리에 올리는 활동
//    // ver 1.
////    let emailTextFieldView = UIView()
//
//    // ver 2.
//    var emailTextFieldView: UIView = {
//        let myView = UIView()
//
//        myView.backgroundColor = UIColor.darkGray
//        myView.layer.cornerRadius = 8
//        myView.layer.masksToBounds = true
//        return myView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        makeUI()
//    }
//
//    func makeUI() {
//        // 1. view에 하위 뷰인 emailTextFieldView 추가하여 화면에 올림
//        view.addSubview(emailTextFieldView)
//        // autoLayout을 끄고 수동으로 설정하는 코드. 이거 설정 안하면 view에 보이지 않음.
//        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
//
//
//        // 2. 하위 뷰가 어디에 위치하는지 잡아줘야함
//        // 왼쪽, 오른쪽 면에서 얼마나 띄어 위치할 것인지
//        // .constraint == auto layout
//        // equalTo: ~여기서부터 시작해서 constant: ~이만큼 띄울거야
//        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
//        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
//
//        // 위, 아래 면에서 얼마나 띄어 위치할 것인지
//        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
////        emailTextFieldView.bottomAnchor
//
//        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        // ver 1. 배경 색깔
////        emailTextFieldView.backgroundColor = UIColor.darkGray
//        // ver 1. 코너 둥글게
////        emailTextFieldView.layer.cornerRadius = 8
////        emailTextFieldView.layer.masksToBounds = true
//
//    }
//
//}

// class는 구조체보다 느리게 작동. 왜? 동적 디스패치(table Dispatch) 때문에
// final : 더 이상 상속을 못하게 막고, Direct Dispatch로 동작
// 그래서 ViewController에는 final을 꼭 사용.
final class ViewController: UIViewController {
    
    // MARK: - 이메일 입력하는 텍스트 뷰
    // 위에 지정은 code Snippet
    // 클로저의 실행문 {}()
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        // 회색 뷰 위에 이메일 입력하는 Field올리고, 이메일 라벨 붙이는 Lable까지 올림
        // 두 코드 위치 바뀌면 안됌. TextField 위에 Lable이 올라가기 때문. 순서 중요
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLable)
        
        return view
    }()
    
    // MARK: - 이메일 또는 전화번호 안내문구
    // 대부분의 변수에 보안 이슈를 위해 private 붙임
    private var emailInfoLable: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    
    
    // MARK: - 로그인 : 이메일 입력 필드
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        return tf
    }()
    
    
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLable)
        view.addSubview(passwordSecureButton)
        
        return view
    }()
    // lazy var을 사용하는 이유?
    // 여기서 보면 passwordTextField를 addSubview 해 UIView()에 올리고 있음.
    // 때문에 먼저 passwordTextField가 존재하고 난 뒤 UIView 에 올리기 가능. 생성 순서가 passwordTextField가 먼저.
    // 따라서 passwordTextFieldView는 lazy var 선언으로 호출될 때 생성.
    
    // MARK: - 패스워드 안내문구
    private var passwordInfoLable: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    
    
    // MARK: - 로그인: 비밀번호 입력 필드
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        return tf
    }()
    
    
    // MARK: - 패스워드에 "표시"버튼 비밀번호 표시 가능
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - 로그인 버튼
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
    
    
    
    // MARK: - Stack View
    lazy var stackView: UIStackView = {
        // ver 1.
//        let st = UIStackView()
//        return st
        
        // ver 2.
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
    
    
    
    // 3개의 각 텍스트필드 및 로그인 버튼 높이 설정
    private let textViewHeight: CGFloat = 40
    
    // 오토레이아웃 향후 변경을 위한 변수(애니메이션)
    lazy var emailInfoLableCenterYConstraint = emailInfoLable.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)

    lazy var passwordInfoLableCenterYConstraint = passwordInfoLable.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이렇게 코드를 설정해야 viewController가 대리자 역할 할 수 있고, 지정이 되어야지만 extention으로 설정한 Delegate 코드들이 먹힘
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        makeUI()
    }
    
    func makeUI() {
        view.backgroundColor = .black
        
        // 전체 viewController 위에 stackView를 올림 (stackView 안에 emailTextFieldView, pass~, log~ 다 있기 때문)
        view.addSubview(stackView)
        view.addSubview(passwordResetButton)
        
        // 1. 자동 제약 false
        emailInfoLable.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordInfoLable.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 각 제약들 뒤에 .isActive = true가 귀찮을 경우 이런식으로도 가능.
        NSLayoutConstraint.activate([
            // emailInfoLable auto Layout
            // 2. 왼쪽 간격 맞추기
            emailInfoLable.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            // 3. 오른쪽 간격 맞추기
            emailInfoLable.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            // 4. 가운데 맞추기
//            emailInfoLable.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
            // 추후 애니메이션 효과를 위해 위치 조정이 필요하기 때문에 위의 코드처럼 고정해놓으면 수정 불가. 따라서 변수 만듦.
            emailInfoLableCenterYConstraint,
            
            
            // emailTextField auto Layout
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),
            
            
            // passwordInfoLable auto Layout
            passwordInfoLable.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLable.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
//            passwordInfoLable.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            passwordInfoLableCenterYConstraint,
            
            // passwordTextField auto Layout
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),
            
            
            // passwordSecureButton auto Layout
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            
            
            // stackView auto Layout
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
            
            
            // passwordResetButton auto Layout
            passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            // 직접적인 숫자로 조정할 땐, equalToConstant
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
            
            
        ])
        
        // ver 1.
//        stackView.addSubview(emailTextFieldView)
//        stackView.addSubview(passwordTextFieldView)
//        stackView.addSubview(loginButton)
        
        // isActive 생략되지 않은 코드 예시
//        emailInfoLable.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8).isActive = true
        
    }
    
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



// UITextFieldDelegate: TextField 수정하기 위해 델리게이트 패턴 프로토콜 채택
extension ViewController: UITextFieldDelegate {
    
    // textField 눌렀을 때 = focus가 textfield
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = .lightGray
            emailInfoLable.font = UIFont.systemFont(ofSize: 11)
            // auto Layout Update
            emailInfoLableCenterYConstraint.constant = -11
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = .lightGray
            passwordInfoLable.font = UIFont.systemFont(ofSize: 11)
            // auto Layout Update
            passwordInfoLableCenterYConstraint.constant = -11
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
                
                // auto Layout Update
                emailInfoLableCenterYConstraint.constant = 0
            }
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = .darkGray
            
            if passwordTextField.text == "" {
                passwordInfoLable.font = UIFont.systemFont(ofSize: 18)
                
                // auto Layout Update
                passwordInfoLableCenterYConstraint.constant = 0
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
