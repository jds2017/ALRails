function questionsTableTagSearch(loc1, loc2) {
  var input, filter, table, tr
  input = document.getElementById("tagSearchInput");
  filter = input.value.toLowerCase();
  table = document.getElementById("questionTagTable");
  tr = table.getElementsByTagName("tr");

  var filterArr, tag, found
  filterArr = filter.split(/[ ]+/).filter(Boolean);

  for (i = 1; i < tr.length; i++) {
    td1 = tr[i].getElementsByTagName("td")[loc1];
    td2 = tr[i].getElementsByTagName("td")[loc2];
    found = false;

    for (j = 0; j < filterArr.length; j++) {
      tag = filterArr[j];
      if (td1) {
        if (td1.innerHTML.toLowerCase().indexOf(tag) > -1) {
          found = true;
        }
      }
      if (td2) {
        if (td2.innerHTML.toLowerCase().indexOf(tag) > -1) {
          found = true;
        }
      }
    }
    if (found) {
      tr[i].style.display = "";
    } else if (filterArr.length == 0) {
      tr[i].style.display = "";
    } else {
      tr[i].style.display= "none";
    }
  }
}
