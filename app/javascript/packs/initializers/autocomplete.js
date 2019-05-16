// Initializes autocomplete for the "author" field, on songs form.
$('#song_author').ready(function() {
  var input = $('#song_author');
  var groupId = input.data('group_id');

  if (groupId) {
    $.get("/groups/" + groupId + "/songs/authors", function(data) {
      var authors = {};

      data.forEach(function(author) {
        authors[author] = null;
      });

      input.autocomplete({
        data: authors,
        limit: 5
      });
    });
  }
});
