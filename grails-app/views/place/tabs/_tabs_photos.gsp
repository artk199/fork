<fieldset>
<sec:ifLoggedIn>
    <g:uploadForm action="uploadFile" resource="${place}">
        <label for="file"><g:message code="custom.choosePhoto" default="Photo"/></label>
        <input type="file" name="image" id="file" />
        <label for="title"><g:message code="custom.title" default="Title"/></label>
        <input type="text" name="title" id="title"/>
        <label for="description"><g:message code="custom.description" default="Description"/></label>
        <input type="text" name="description" id="description"/>
        <input type="submit" class="buttons" value="Wyślij" />
    </g:uploadForm>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
    <p>Zaloguj się aby dodawać zdjęcia</p>
</sec:ifNotLoggedIn>
</fieldset>

<g:each in="${place.images}" var="image">
    <img src="/image/${image.id}/mini"/>
</g:each>