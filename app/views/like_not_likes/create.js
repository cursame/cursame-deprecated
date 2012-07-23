
var like;
$("#like_super_<%= @comment.id%>").html('<div class="like-element label-tag">'+<%= @comment.like_not_likes.count %>+'</div>');