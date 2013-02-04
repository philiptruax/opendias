$(document).ready(function() {
  var role = getCookie("role");

  $("#newrealname").val( getCookie("realname") );
  $("#currentrole").html( get_priv_from_role( role, 'name' ) + " (" + role + ")" );
  if ( get_priv_from_role( role, 'update_access' ) ) {
    $('.onlyadmin').css({ display: 'block' });

    // Get a list of current users
    $.ajax({ url: "/opendias/dynamic",
             dataType: "xml",
             timeout: 10000,
             data: { action: "getUserList",
                     },
             cache: false,
             type: "POST",
             error: function( x, t, m ) {
               if(t=="timeout") {
                 alert("[s001] " + LOCAL_timeout_talking_to_server);
               } else {
                 alert("[s001] " + LOCAL_error_talking_to_server+": "+t+"\n"+m);
               }
             },
             success: function(data){
               if( $(data).find('error').text() ) {
                 alert( $(data).find('error').text() );
               } else {
                 $(data).find('GetUserList').find('Users').find('User').each( function() {
                    var userid = $(this).find('username').text();
                    var real = $("<td></td>").text( $(this).find('realname').text() + " (" + userid + ")");

                    var last = $("<td></td>").text( $(this).find('last_access').text() );

                    var r = $(this).find('role').text();
                    var s = "selected='selected'";
                    var role = $("<td></td>").html( "<select id='role_"+userid+"'>"
                        + "<option value='1'" + ( ( r == "1" ) ? s : "" ) + ">" + LOCAL_role_admin + "</option>"
                        + "<option value='2'" + ( ( r == "2" ) ? s : "" ) + ">" + LOCAL_role_user + "</option>"
                        + "<option value='3'" + ( ( r == "3" ) ? s : "" ) + ">" + LOCAL_role_view + "</option>"
                        + "<option value='4'" + ( ( r == "4" ) ? s : "" ) + ">" + LOCAL_role_add + "</option>"
                        + "</select>" );

                    var update = $("<button>Update</button>");
                    update.click( function() {
                        alert( "Set users " + userid + " role to " + $('#role_'+userid).val() );
                      });

                    var reset = $("<button>Reset Password</button>");
                    reset.click( function() {
                        alert( "Reset users password" );
                      });

                    var delet = $("<button>Delete</button>");
                    delet.click( function() {
                        alert( "Delete user " + userid );
                      });

                    var actions = $("<td class='actions'></td>").append(update).append(reset).append(delet);
                    var row = $("<tr></tr>").append(real).append(last).append(role).append(actions);

                    $('#useradmin table tbody').append( row );
                 });
               }
             }
           });
  }

  $("#tabs").tabs();

  $('#updateThisUser').click( function(){
    if( $('#newpassword').val() != $('#newpassword2').val() ) {
      alert( LOCAL_new_password_do_not_match );
      return 0;
    }
    $.ajax({ url: "/opendias/dynamic",
             dataType: "xml",
             timeout: 10000,
             data: { action: "updateUser",
                     username: "[current]",
                     realname: $("#newrealname").val(),
                     password: $("#newpassword").val(),
                     },
             cache: false,
             type: "POST",
             error: function( x, t, m ) {
               if(t=="timeout") {
                 alert("[s001] " + LOCAL_timeout_talking_to_server);
               } else {
                 alert("[s001] " + LOCAL_error_talking_to_server+": "+t+"\n"+m);
               }
             },
             success: function(data){
               if( $(data).find('error').text() ) {
                 alert( $(data).find('error').text() );
               } else {
                 setCookie("realname", $('#newrealname').val() );
                 setLoginOutArea();
                 alert( LOCAL_details_updated );
               }
             }
           });
    });

  $('#createNewUser').click( function(){
    if( $('#createpassword').val() != $('#createpassword2').val() ) {
      alert( LOCAL_new_password_do_not_match );
      return 0;
    }
    $.ajax({ url: "/opendias/dynamic",
             dataType: "xml",
             timeout: 10000,
             data: { action: "createUser",
                     username: $("#createuserid").val(),
                     realname: $("#createrealname").val(),
                     password: $("#createpassword").val(),
                     role: $("#createuserrole").val(),
                     },
             cache: false,
             type: "POST",
             error: function( x, t, m ) {
               if(t=="timeout") {
                 alert("[s001] " + LOCAL_timeout_talking_to_server);
               } else {
                 alert("[s001] " + LOCAL_error_talking_to_server+": "+t+"\n"+m);
               }
             },
             success: function(data){
               if( $(data).find('error').text() ) {
                 alert( $(data).find('error').text() );
               }
               else {
                 alert( LOCAL_user_created );
               }
             }
           });
    });

});
