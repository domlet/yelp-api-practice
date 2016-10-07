$(function() {
  $('form').on('submit', function(e) {
    e.preventDefault();
    console.log(gapi.client);
    console.log($('#search').val());
    // prepare the request 
    var request = gapi.client.youtube.search.list({
      part: 'snippet',
      type: 'video',
      q: encodeURIComponent($('#search').val()).replace(/%20/g, '+'),
      maxResults: 3,
      order: 'viewCount',
      publishedAfter: '2015-01-01T00:00:00Z'
    });
    // execute the request
    request.execute(function(response) {
      var results = response.result;
      $.each(results.items, function(index, item) {
        //use jquery to get partial html file, hereby known as data
        $.get("tpl/item.html", function(data) {
          $("#results").append(data);
        })
        // $("#results").append(item.id.videoId + " " + item.snippet.title + "<br>");
      })
    });
  });
});

function init() {
  gapi.client.setApiKey('AIzaSyBx2DLpBph9YmHtRY9hUcaCR5U03gb2QPo')
  gapi.client.load('youtube', 'v3', function() {
    // yt api is ready
  });
}