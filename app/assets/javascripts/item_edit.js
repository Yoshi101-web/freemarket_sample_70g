$(document).ready(function() {
  
  var box_number = $('.exmain-box__main__previews__view').length
  console.log(box_number);
  if (box_number == 10){
    $('#box-hidden').css('pointer-events', 'none')
    $('#box-hidden').css('opacity', '0')
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<div data-index="${index}", class="exmain-box__main__previews__view">
                    <div class="exmain-box__main__previews__view__image">
                      <img class= "image${index} input_images", data-index="${index}" src="${url}" width="114" height="80">
                      <div class="js-remove exmain-box__main__previews__view__delete">
                        削除
                      </div>
                    </div>
                  </div>`;
    return html;
  }
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <i class="fa fa-camera"></i>
                    <input class="js-file" type="file"
                    name="item[images_attributes][${num}][image]"
                    id="item_images_attributes_${num}_image">
                  </div>`;
    return html;
  }
  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
  $('.hidden-destroy').hide();
  
  $('.exmain-box__main').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('image', blobUrl);
    } else {  // 新規画像追加の処理
      $('.exmain-box__main__previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('.exmain-box__main__uploader__label').prepend(buildFileField(fileIndex[0]));
      $(this).css({'display':'none'});
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
      
    }
    var box_number = $('.exmain-box__main__previews__view').length
    console.log(box_number);
    if (box_number == 10){
      $('#box-hidden').css('pointer-events', '')
      $('#box-hidden').css('pointer-events', 'none')
      $('#box-hidden').css('opacity', '')
      $('#box-hidden').css('opacity', '0')
    }else{
      $('#box-hidden').css('pointer-events', '')
      $('#box-hidden').css('pointer-events', 'normal')
      $('#box-hidden').css('opacity', '')
      $('#box-hidden').css('opacity', '1')
    }
  });

  // 削除ボタンの設定
  $('.exmain-box__main').on('click', '.js-remove', function() {
    const targetIndex = $(this).prev().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(this).parent().remove();
    $(`div[data-index="${targetIndex}"]`).remove();
    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('.exmain-box__main__uploader__label').prepend(buildFileField(fileIndex[0]));
    if ($('.exmain-box__main__uploader__label').length == 10){
      $('#image-box__container').css('display', 'none')   
    }
    var box_number = $('.exmain-box__main__previews__view').length
    console.log(box_number);
    if (box_number < 10){
      $('#box-hidden').css('pointer-events', '')
      $('#box-hidden').css('pointer-events', 'normal')
      $('#box-hidden').css('opacity', '')
      $('#box-hidden').css('opacity', '1')
    }
  });
});