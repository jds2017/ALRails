var quill;

var initialize_question_form = function() {
  quill = new Quill('#editor-container', {
    modules: {
      toolbar: [
        [{ header: [1, 2, false] }],
        ['bold', 'italic', 'underline'],
        ['image', 'code-block']
      ]
    },
    placeholder: 'Enter your question here',
    theme: 'snow'
  });

  try {
    quill.setContents(JSON.parse($('#question_body').val()));
  } catch(e) {
    console.log("invalid json");
  }
  $('#form').submit(function(e) {
    $('#question_body').val(JSON.stringify(quill.getContents()));
    return true;
  });
}
