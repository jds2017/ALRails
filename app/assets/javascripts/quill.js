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

  //put the thing in the input, into quill
  console.log($('#question_body').val());
  quill.setContents(JSON.parse($('#question_body').val()));


  //intercept form to add the contents in
  $('#form').submit(function(e) {
    $('#question_body').val(JSON.stringify(quill.getContents()));
    return true;
  });
}
