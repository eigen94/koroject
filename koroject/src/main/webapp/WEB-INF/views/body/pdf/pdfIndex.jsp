
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*,com.itextpdf.text.*,com.itextpdf.text.pdf.PdfWriter"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type"content="text/html; charset="EUC-KR">
<script type="text/javascript" src="/js/static/jquery/2.0.3/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<title>Insert title here</title>
<style type="text/css">
.dual-list .list-group {
	margin-top: 8px;
}

.list-left li, .list-right li {
	cursor: pointer;
}

.list-arrows {
	padding-top: 100px;
}

.list-arrows button {
	margin-bottom: 20px;
}
</style>
</head>
<body>

<div class="container">
    <br />
    <div class="row">
		<div class="col-md-10">
		</div>
		<div class="col-md-2">
		 <div>
		 	<form:form action="downloadPDF" method="post" id="downloadPDF">
				<!-- <input id="submitId" type="submit" value="Downlaod PDF"> -->
			 	<button id="submitId" type="submit" value="Downlaod PDF" class="btn btn-primary">Downlaod PDF</button>
			</form:form>
		</div>
  </div>
</div>

	<br />
	<div class="row">

        <div class="dual-list list-left col-md-5">
            <div class="well text-right">
                <div class="row">
                    <div class="col-md-10">
                        <div class="input-group">
                            <span class="input-group-addon glyphicon glyphicon-search"></span>
                            <input type="text" name="SearchDualList" class="form-control" placeholder="search" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="btn-group">
                            <a class="btn btn-default selector" title="select all"><i class="glyphicon glyphicon-unchecked"></i></a>
                        </div>
                    </div>
                </div>
                <ul class="list-group">
                    <li class="list-group-item">UML</li>
                    <li class="list-group-item">UseCaseDescription</li>
                    <li class="list-group-item">UseCaseDiagram</li>
                    <li class="list-group-item">ERD</li>
                    <li class="list-group-item">화면 명세서</li>
                </ul>
            </div>
        </div>

        <div class="list-arrows col-md-1 text-center">
            <button class="btn btn-default btn-sm move-left">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </button>

            <button class="btn btn-default btn-sm move-right">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </button>
        </div>

        <div class="dual-list list-right col-md-5">
            <div class="well">
                <div class="row">
                    <div class="col-md-2">
                        <div class="btn-group">
                            <a class="btn btn-default selector" title="select all"><i class="glyphicon glyphicon-unchecked"></i></a>
                        </div>
                    </div>
                    <div class="col-md-10">
                        <div class="input-group">
                            <input type="text" name="SearchDualList" class="form-control" placeholder="search" />
                            <span class="input-group-addon glyphicon glyphicon-search"></span>
                        </div>
                    </div>
                </div>
                <ul class="list-group">
                    <!-- <li class="list-group-item"></li>
                    <li class="list-group-item">Dapibus ac facilisis in</li>
                    <li class="list-group-item">Morbi leo risus</li>
                    <li class="list-group-item">Porta ac consectetur ac</li>
                    <li class="list-group-item">Vestibulum at eros</li> -->
                </ul>
            </div>
        </div>

	</div>
</div>
</body>
<!-- ======================================================================================== -->
<script type="text/javascript">
$(function () {

    $('body').on('click', '.list-group .list-group-item', function () {
        $(this).toggleClass('active');
    });
    $('.list-arrows button').click(function () {
        var $button = $(this), actives = '';
        if ($button.hasClass('move-left')) {
            actives = $('.list-right ul li.active');
            actives.clone().appendTo('.list-left ul');
            actives.remove();
        } else if ($button.hasClass('move-right')) {
            actives = $('.list-left ul li.active');
            actives.clone().appendTo('.list-right ul');
            actives.remove();
        }
    });
    $('.dual-list .selector').click(function () {
        var $checkBox = $(this);
        if (!$checkBox.hasClass('selected')) {
            $checkBox.addClass('selected').closest('.well').find('ul li:not(.active)').addClass('active');
            $checkBox.children('i').removeClass('glyphicon-unchecked').addClass('glyphicon-check');
        } else {
            $checkBox.removeClass('selected').closest('.well').find('ul li.active').removeClass('active');
            $checkBox.children('i').removeClass('glyphicon-check').addClass('glyphicon-unchecked');
        }
    });
    $('[name="SearchDualList"]').keyup(function (e) {
        var code = e.keyCode || e.which;
        if (code == '9') return;
        if (code == '27') $(this).val(null);
        var $rows = $(this).closest('.dual-list').find('.list-group li');
        var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();
        $rows.show().filter(function () {
            var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
            return !~text.indexOf(val);
        }).hide();
    });

});
</script>
</html>