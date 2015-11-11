<div ng-controller='galleryController' user-images id="${place.id}" controller="place">
    <div class='row fork-gallery-container'>
        <div class='col-md-12' style='padding:0px; margin:10px; margin-bottom:0px;overflow-x:auto;overflow-y:hidden;' ng-show='isSelected()'>
            <img full-image ng-if="isSelected()" ng-src="{{getSelectedUrl()}}"/>
        </div>
        <div class='col-md-12 fork-image-info' ng-show='isSelected()'>
            <div style='text-align: left; margin-bottom:20px;margin-top:10px;'>
                <h2 style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 41px;font-weight: bold; font-style: italic;">
                &bdquo;{{title != null ? title : 'No title'}}&rdquo;
                    <small style='font-size:45%'>09.09.2009</small></h2>
                <span style="font-size:20px;">{{description}}</span>
            </div>
        </div>
        <div class='col-md-12'>
            <div ng-show="!uploading" style='position:relative;display:inline-block; margin: 5px; width:100px; height:200px;line-height: 200px;' title="Dodaj zdjęcie">
                <img add-image="1" src="${g.assetPath(src: 'Plus.png')}" style="border-radius: 50px; width:75px;"/>
                <img add-image="2" src="${g.assetPath(src: 'Plusp.png')}" class="fork-add-image active"/>
                <input type='file' file-dialog style="display: none"/>
            </div>
            <div ng-show="uploading" style='position:relative;display:inline-block; margin: 5px; width:200px;'>
                <div style="border: 1px solid black; display:inline-block;width:200px; height:20px;">
                    <div ng-style='{width:progress}' style="cursor:default;height:100%;background-attachment: fixed; background: repeating-linear-gradient( 45deg, #f0ad4e, #F5B964 10px, #d9534f 10px, #F77571 20px );">
                    </div>
                </div>
            </div>

            <div user-image-wrapper style='position:relative;display:inline-block; margin: 5px;' ng-repeat='image in images'>
                <img ng-style='imageStyle()' style='border:1px #777 solid;' ng-src='/image/{{image}}/mini' user-image/>
                <div ng-style='overlayStyle()' style='position:absolute; background-color: white; top:0; left:0; width:100%; pointer-events: none; height:100%;'></div>
            </div>
        </div>
    </div>
</div>