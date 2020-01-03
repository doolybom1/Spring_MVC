# 이미지 갤러리 프로젝트
* 2020-01-03

### WYSWYG Editor
* summernote : <https://summernote.org/>

* textarea에 id 값을 설정하고 id에 jq를 이용해서 속성을 설정해주면 간편하게
wyswyg 문서를 작성할 수 있다

### Drag and Drop으로 파일 올리기
* Drag and Drop 을 수행할 box를 만들기
* jq dragover, drop event를 설정
* e.originalEvent.dataTransfer로부터 files 객체추출
* files 객체의 0번째 file 객체를 추출

* ajax를 사용해서 서버로 파일을 업로드 수행하고
* 파일이름등을 다시 response로 되돌려 받아서 
* form img_file input box에 저장을 하고 내용을 form post로 upload하면 나머지 정보를 db에 저장