<!DOCTYPE html>
<html>
<head>
    <title><g:message code="image.edit" /></title>
    <meta name="layout" content="main"/>
    <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
    <meta name='description' content='' />
    <meta name='keywords' content='' />
</head>
<body>
    <div class='row fork-gallery-container'>
        <div class='col-md-12' style='padding:0px; margin:10px; margin-bottom:0px;overflow:auto; max-height:500px'>
            <img src="/image/${image.id}"/>
        </div>
        <div class="row">
            <div class="col-md-2"></div>
            <div class='col-md-8 fork-image-info'>
                <div style='text-align: left; margin-bottom:20px;'>
                    <h2> {{title}} <small style='font-size:45%'>09.09.2009</small></h2>
                    <span>{{description}}</span>
                </div>
            </div>
            <div clas="col-md-2"></div>
        </div>

    </div>
</body>
</html>