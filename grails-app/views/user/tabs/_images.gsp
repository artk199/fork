<div ng-controller='galleryController' user-images id="${user.id}">
    <div class='row fork-gallery-container'>
           <div class='col-md-12' style='padding:0px; margin:10px; margin-bottom:0px;overflow-x:auto;overflow-y:hidden;' ng-show='isSelected()'>
               <img full-image ng-src='{{getSelectedUrl()}}'/>
           </div>
           <div class='col-md-12 fork-image-info' ng-show='isSelected()'>
               <div class='pull-right fork-cog'>
                   <span toggle-dropdown class='glyphicon glyphicon-cog'></span>
                   <div ng-show='showDropdown()'>
                       <div><a ng-href='/image/{{images[selectedImage]}}/link'><g:message code="image.link"/></a></div>
                       <div><a ng-href='/image/{{images[selectedImage]}}/edit'><g:message code="image.edit"/></a></div>
                       <div><a ng-href='/image/{{images[selectedImage]}}/report'><g:message code="image.report"/></a></div>
                       <div><a ng-href='/image/{{images[selectedImage]}}/delete'><g:message code="image.delete"/></a></div>
                   </div>
               </div>
               <div style='text-align: left; margin-bottom:20px;'>
                   <h2> Image title <small style='font-size:45%'>09.09.2009</small></h2>
                   <span>Image descripLorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque bibendum dui sed sapien hendrerit posuere. Duis luctus libero felis, ac convallis orci dignissim at. Nam imperdiet semper urna, ac dignissim risus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus ut porttitor felis. Curabitur vel urna in est lobortis facilisis id sed urna. Sed aliquam urna neque, non ullamcorper mauris mollis fermentum. </span>
               </div>
           </div>
           <div class='col-md-12'>
               <div style='position:relative;display:inline-block; margin: 5px; width:100px; height:200px;line-height: 200px;' title="Dodaj zdjęcie">
                   <img add-image="1" src="${g.assetPath(src: 'Plus.png')}" style="border-radius: 50px; width:75px;"/>
                   <img add-image="2" src="${g.assetPath(src: 'Plusp.png')}" class="fork-add-image active"/>
                   <input type='file' file-dialog style="display: none"/>
               </div>

               <div user-image-wrapper style='position:relative;display:inline-block; margin: 5px;' ng-repeat='image in images'>
                   <img ng-style='imageStyle()' style='border:1px #777 solid;' ng-src='/image/{{image}}' user-image/>
                   <div ng-style='overlayStyle()' style='position:absolute; background-color: white; top:0; left:0; width:100%; pointer-events: none; height:100%;'></div>
               </div>
           </div>
      </div>
</div>