<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }

    // null이 아니면 true를 반환
    function isNotNull(e){
    	if(e == "" || e == null){
    		return false
    	}
    	return true
    }

  </script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="${pageContext.request.contextPath }/resources/assets/js/soft-ui-dashboard.min.js?v=1.0.3"></script>
  
