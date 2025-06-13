# Login Feature Implement
## 바로인턴 iOS 직무 과제
### Overview
- Swift를 이용해 로그인 기능을 구현한 과제입니다.
  - 이메일/비밀번호를 기반 인증
  - 자동 로그인 기능
  - 이메일 유효성 검사
- TechStack
  - Language: Swift
  - Architecture: MVVMC(Model-View-ViewModel-Coordinator)
  - Framework: UIKit, Combine, Swift Concurrency(async/await)
  - Tools: Xcode, SwiftLint, Stitch, Figma

### Design
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/0d1315f9-2fc1-4b0e-a186-13f6d1b295b6" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/7d5cb1a2-64de-4496-8342-0c3dc6524225" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/936146fb-ff86-4734-a2bd-efcb15205ee9" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/104165b6-824a-4f32-be34-1f9a840824b4" width="250"/></td>
  </tr>

</table>

### Functional Requirement
<details>
  <summary>기능적 요구사항</summary>
  
- [x] **시작하기 화면**
    - [x] 사용자는 시작하기 버튼을 누를 수 있습니다.
        - [x] 비회원이면 회원가입 화면으로 이동합니다.
        - [x] 회원이면 로그인 성공 화면으로 이동합니다.
    - [x] 회원/ 비회원 여부는 저장된 로그인 정보로 판단합니다.
- [x] **회원가입 화면**
    - [x] 아이디 등록
        - [x] 아이디는 이메일 주소여야합니다.
            - [x] 예) abc@gmail.com
        - [x] 아이디는 다음 조건을 만족해야 합니다.
            - [x] 이메일 영역(@이후) 을 제외하고 최소 6자 이상, 최대 20자 이하여야 합니다.
            - [x] 영문 소문자(a-z)와 숫자(0-9)만 허용됩니다.
            - [x] 숫자로 시작할 수 없습니다.
        - [x] 아이디 중복체크는 회원가입 버튼을 탭할 때 수행됩니다.
    - [x] 비밀번호 등록
        - [x] 2개의 입력창이 있습니다.
            - [x] 비밀번호 입력창
            - [x] 비밀번호 확인창
        - [x] 비밀번호 제한 조건
            - [x] 최소 8자 이상
            - [x] 이외 추가 조건은 자유롭게 정의하시면 됩니다.
    - [x] 닉네임 등록
    - [x] 회원가입 버튼
        - [x] 회원가입 버튼은 아래 조건에 따라 활성화 됩니다.
            - [x] 아이디 입력 완료
            - [x] 비밀번호 입력 완료, 비밀번호 확인창과 일치
            - [x] 닉네임 입력 완료
        - [x] 버튼을 탭하면 회원가입을 시도하며, 서버와 통신하는 부분을 로컬 저장으로 대체합니다.
            - [x] 보통 회원가입 서버 요청이 성공하면 회원가입 정보는 서버가 관리하는 DB 에 저장되어야하지만, 이 과제에는 서버 요청을 생략하고 회원가입 정보를 CoreData 에 저장합니다.
        - [x] 회원가입 성공 조건
            - [x] 입력한 이메일이 로컬 DB에 저장된 아이디(이메일)와 중복되지 않아야 합니다.
        - [x] 회원가입에 성공하였다면 로그인 성공 화면으로 이동합니다.
    - [x] 이외 사용자를 위한 부가적인 UX 들은 자유롭게 추가해주세요.
- [x] **로그인 성공 화면**
    - [ ] 화면에 진입하였을 때 사용자의 “{닉네임} 님 환영합니다.”을 화면에 표시합니다.
    - [x] 로그아웃 버튼이 존재합니다. 탭 시 시작하기 화면으로 이동합니다.
    - [x] 회원탈퇴 버튼이 존재합니다. 탭 시, CoreData 에서 회원정보가 삭제되고 시작하기 화면으로 이동합니다.
- [ ] **테스트**
    - [ ] 회원가입/로그인 페이지 완성후 완벽한지 테스트하기
        - 다양한 상황에서 테스트해보기
</details>

### Non-Functional Requirement
<details>
  <summary>비기능적 요구사항</summary>

  - [x] 사용자 이메일에 대한 유일성이 지켜져야 한다.
  - [x] 입력받은 데이터는 항상 요구하는 형식과 일치해야 한다.
  - [ ] 에러 상황에 대한 안내를 사용자에게 명확히 전달한다.
</details>

### User Flow
![UserFlow](https://github.com/user-attachments/assets/33978035-8bc2-41b3-a5bc-117dc86db12f)


### Folder Tree
<img width="1002" alt="Screenshot 2025-06-10 at 04 55 32" src="https://github.com/user-attachments/assets/43a08bf8-5e98-41b1-a011-65196b6e2b22" />

### Domain Model
<img width="1002" alt="Screenshot 2025-06-10 at 04 56 27" src="https://github.com/user-attachments/assets/5c100eea-1af5-46f9-9aeb-2df83071e9c0" />

### Class Diagram
<!-- <img width="1002" alt="Screenshot 2025-06-10 at 04 58 00" src="https://github.com/user-attachments/assets/2110530c-9ff1-44c7-ad0d-c4e68adbfd24" />
<img width="1002" alt="Screenshot 2025-06-10 at 13 17 59" src="https://github.com/user-attachments/assets/3e9655ae-f2eb-497b-b569-625d442f89a9" /> -->
<!--![바로인턴+04  직무과제  2025-06-11 10 33 51 excalidraw](https://github.com/user-attachments/assets/9cd80308-33d6-42ee-9caf-df84e2343606)-->
![의존성 업데이트](https://github.com/user-attachments/assets/f652f799-6a99-41b5-b158-d0060044e70d)




