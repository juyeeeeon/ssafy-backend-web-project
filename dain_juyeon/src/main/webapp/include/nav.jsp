
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav
    class="navbar navbar-expand-md bg-dark sticky-top border-bottom bg-primary-subtle border border-primary-subtle rounded-3"
    style="top: 20px; margin: 10px;">
    <div class="container d-flex ">
    <a class="navbar-brand" href="${root}/index.jsp">여행정보를 주다</a>
    </div>
	<div class="container">
		
		<div class="offcanvas offcanvas-end" tabindex="-1" id="#offcanvas"
			aria-labelledby="#offcanvasLabel">
			<div class="offcanvas-body ms-5">
				<ul class="navbar-nav flex-grow-1 justify-content-between">
					<c:if test="${sessionScope.user ne null}">
						<li class="nav-item ms-auto"><a class="nav-link"
							href="${root}/user/mypage.jsp">내 정보</a></li>
						<li class="nav-item ms-auto"><a class="nav-link"
							href="${root}/member?action=logout">로그아웃</a></li>
					</c:if>
					<c:if test="${sessionScope.user eq null}">
						<li class="nav-item ms-auto">&nbsp;&nbsp;&nbsp;&nbsp;</li>
						<li class="nav-item ms-auto"><a class="nav-link"
							href="${root}/user/login.jsp">로그인</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</nav>





