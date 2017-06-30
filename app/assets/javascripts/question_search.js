// NOTE: Only searches for one term with no additional spaces or punctuation.
function questionsTableTagSearch() {
  //declare variables: serach input, table to search, filter for input, and table rows.
  var input, filter, table, tr
  input = document.getElementById("tagSearchInput");
  filter = input.value.toLowerCase();
  table = document.getElementById("questionTagTable");
  tr = table.getElementsByTagName("tr");

  //loop thru all table rows, and hide those that don't match the search input.
  var hiddenCount = 0;
  for (i = 0; i < tr.length; i++) {
    //get tags column for this row
    td = tr[i].getElementsByTagName("td")[1];
    if (td) {
      if (td.innerHTML.toLowerCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
        hiddenCount = hiddenCount + 1;
      } else {
        tr[i].style.display= "none";
      }
    }
  }
}

//NOTE: Only searches for one term with no additional spaces or punctuation.
function qSetQuestionTagSearch() {
  //declare variables: serach input, table to search, filter for input, and table rows.
  var input, filter, table, tr
  input = document.getElementById("tagSearchInput");
  filter = input.value.toLowerCase();
  table = document.getElementById("questionTagTable");
  tr = table.getElementsByTagName("tr");

  //loop thru all table rows, and hide those that don't match the search input.
  for (i = 0; i < tr.length; i++) {
    //get tags column for this row
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      if (td.innerHTML.toLowerCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display= "none";
      }
    }
  }
}