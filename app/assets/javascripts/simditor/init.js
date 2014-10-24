$(document).ready(function(){
  for(_i = 0;_i < $("textarea[simditor]").length; _i++){
    var simditor_value = $($("textarea[simditor]")[_i]).attr("simditor");
    var toolbar = ['title', 'bold', 'italic', 'underline', 'strikethrough', 'color', '|', 'ol', 'ul', 'blockquote', 'code', 'table', '|', 'link', 'image', 'hr', '|', 'indent', 'outdent'];
    var mobileToolbar = ["bold", "underline", "strikethrough", "color", "ul", "ol"];
    if (mobilecheck()) {
      toolbar = mobileToolbar;
    }
    new Simditor({
      textarea: $("textarea[simditor]")[_i],
      upload: true,
      pasteImage: true,
      toolbar: toolbar,
      autosave: true,
      width: simditor_value
    });
  };
});
