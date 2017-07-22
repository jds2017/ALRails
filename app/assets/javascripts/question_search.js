// NOTE: searches both Tags column and Course column; OR's findings.
// take sin multiple search filter entries, separated by spaces.
function questionsTableTagSearch() {
  //declare variables: search input, table to search, filter for input, and table rows.
  var input, filter, table, tr
  input = document.getElementById("tagSearchInput");
  filter = input.value.toLowerCase();
  table = document.getElementById("questionTagTable");
  tr = table.getElementsByTagName("tr"); //get rows

  var filterArr, tag, found
  //split user input by space, take out empty entries
  filterArr = filter.split(/[ ]+/).filter(Boolean);
     
  //loop thru all table rows except headers, and hide those that don't match the search input.
  //filter entries (tags or coursenames) are OR'ed
  for (i = 1; i < tr.length; i++) {
    //get tags and course columns for this row
    td1 = tr[i].getElementsByTagName("td")[1];
    td2 = tr[i].getElementsByTagName("td")[2];
    found = false;
    
    //loop thru filter entries and check the row for them.
    for (j = 0; j < filterArr.length; j++) {
      tag = filterArr[j];
      // check tags column for tag
      if (td1) {
        if (td1.innerHTML.toLowerCase().indexOf(tag) > -1) {
          found = true;
        }
      }
      //check course name column for tag
      if (td2) {
        if (td2.innerHTML.toLowerCase().indexOf(tag) > -1) {
          found = true;
        }
      }
    }
    //were any of the filter entries found in this row? 
    // if so, display the row. if not, hide it.
    if (found) {
      tr[i].style.display = "";
    } else if (filterArr.length == 0) {
      //search filter empty? display all rows.
      tr[i].style.display = "";
    } else {
      tr[i].style.display= "none";
    }
  }
  
}

/// NOTE: searches both Tags column and Course column; OR's findings.
// take sin multiple search filter entries, separated by spaces.
function qSetQuestionTagSearch() {
  //declare variables: serach input, table to search, filter for input, and table rows.
  var input, filter, table, tr
  input = document.getElementById("tagSearchInput");
  filter = input.value.toLowerCase();
  table = document.getElementById("questionTagTable");
  tr = table.getElementsByTagName("tr");

  var filterArr, tag, found
  //split user input by space, take out empty entries
  filterArr = filter.split(/[ ]+/).filter(Boolean);
  
  //loop thru all table rows except headers, and hide those that don't match the search input.
  for (i = 1; i < tr.length; i++) {
    //get tags and course columns for this row
    td1 = tr[i].getElementsByTagName("td")[2];
    td2 = tr[i].getElementsByTagName("td")[3];
    found = false;

    //loop thru filter entries and check the row for them.
    for (j = 0; j < filterArr.length; j++) {
      tag = filterArr[j];
      // check tags column for tag
      if (td1) {
        if (td1.innerHTML.toLowerCase().indexOf(tag) > -1) {
          found = true;
        }
      }
      //check course name column for tag
      if (td2) {
        if (td2.innerHTML.toLowerCase().indexOf(tag) > -1) {
          found = true;
        }
      }
    }
    //were any of the filter entries found in this row? 
    // if so, display the row. if not, hide it.
    if (found) {
      tr[i].style.display = "";
    } else if (filterArr.length == 0) {
      //search filter empty? display all rows.
      tr[i].style.display = "";
    } else {
      tr[i].style.display= "none";
    }
  }
  
}