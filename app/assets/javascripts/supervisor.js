/*
 Javascripts for Supervisor layout.
*/
$(document).ready(function(){
  
  // Tabs for pending and approved teachers
  $('.tabs').tabs()
  
  //Show edit_user_role
  $('.change_role_button').click(function(){
    $(this).parent().next().show(400);
    $(this).parent().hide(400);
  });
});
