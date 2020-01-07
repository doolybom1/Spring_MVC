var files_up = function(formData){
	
	$.ajax({
	
		url : rootPath + '/image/files_up',
		method : 'POST',
		data : formData,
		processData : false,
		contentType : false,
	
		success : function(result) {
			if (result == 'FAIL') {
				alert("파일 업로드 오류")
			} else {
				$("#d_d_box").html(result)
			}
		},
		error : function() {
			alert("서버 통신 오류")
		}
	
	})

}