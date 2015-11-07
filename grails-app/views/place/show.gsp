<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
    <div id="show-place">
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="row">
                    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                        <h1>${this.place.town} - ${this.place.name}</h1>
                        <div class="row">
                            <div class="col-md-4">
                                image
                            </div>

                            <div class="col-md-8">
                                <p class="text-left">
                                    ${this.place.description}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
        <div class="row page-section blue-section">
            <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                <g:render template="tabs" model="[place:place]"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <g:render template="scores" model="[place:place, score:score]"/>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
        <fieldset>
            <legend>File Upload</legend>
            <g:uploadForm action="uploadFile">
                <label for="avatar">Avatar (16K)</label>
                <input type="file" name="avatar" id="avatar" />
                <div style="font-size:0.8em; margin: 1.0em;">
                    For best results, your avatar should have a width-to-height ratio of 4:5.
                    For example, if your image is 80 pixels wide, it should be 100 pixels high.
                </div>
                <input type="submit" class="buttons" value="Upload" />
            </g:uploadForm>
        </fieldset>
    </div>
</body>
</html>