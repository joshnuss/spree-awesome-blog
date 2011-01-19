$(function() {
    var pictures = [];
    var allowPictures = false;

    if ($('#images').size() > 0) {
      allowPictures = true;
      //load images
      $('#images img').each(function() {
        pictures.push({
          url: $(this).attr('src'),
          title: $(this).attr('alt')});
      });
    }
    $("textarea.editor").markdownEditor({allowPictures: allowPictures, pictures: pictures});
});
