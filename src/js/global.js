
function checkAlerts(){
  $.ajax({
      type: "GET",
      url: "services/get-alerts-svc.xqy",
      async: true, 
      cache: false,
      timeout:10000, 
      success: function(data){ 
		if (data > 0) {
		  $("#alert-count").html(data);
		  $("#alert-msg").show('slow');
		}
          setTimeout(
              'checkAlerts()', 
              10000 
          );
      },
      error: function(XMLHttpRequest, textStatus, errorThrown){
          addmsg("error", textStatus + " (" + errorThrown + ")");
          setTimeout(
              'waitForMsg()', /* Try again after.. */
              "10000"); /* milliseconds (15seconds) */
      },
  });
};

$(document).ready( function(){

    $('#warning').hide();

    var url = "http://localhost:7777/lib/get-suggest-words.xqy";
    $("#search").autocomplete(url);

    var url = "http://localhost:7777/lib/get-suggest-values.xqy";
    $("#fullname-r").autocomplete(url);
   	   		    
    if($('#loginuser').val() != "") {
      $('#registerbox').hide();
      $('#loginbox').hide();
      $('#messages').show();  
      $("#logout").show();
      
    } else {
      $('#messages').hide();
      $("#logout").hide();
      $('#loginbox').show();      
    }
    
    $('#registerbox').hide();
    $("#searchresults").hide;    
    $("#backtomessages").hide();
    $("#alert-msg").hide();    
    $("#searchresult-msg").hide();    
        
    $('.rounded').corners("20px 20px");
    $('.innerrounded').corners("5px 5px");
    $("a", ".markbutton").button();
    
    var msgText;

    $('#msgtext').keyup(function(event) {
      msgText = $("#msgtext").val();
      $("#counter").html((140 - msgText.length));
    });

    $("#msgtext").focus(function(event){
      $("#msgtext").val('');
    });
      
    $("#msgbutton").click(function(event){
      $.ajax({
	url: "services/create-msg-svc.xqy",
	data: "msg=" + msgText,
	cache: false,
	success: function(html){
	  $("#msglist").html(html);;
	}
      });
      $("#msgtext").val('');
      $("#counter").html('140');
    });

    $("#backtomessages").click(function(event){
      $.ajax({
	url: "services/clear-alerts-svc.xqy",
	data: "clear-rules=true",
	cache: false,
	success: function(data){}
      });
      
      $.ajax({
	url: "services/get-msg-svc.xqy",
	cache:false,
	success: function(html){
	  $("#msglist").html(html);
	}
      });        
      
      $("#mybox").show();
      $("#backtomessages").hide();      
      $("#alert-msg").hide();
      $("#searchresult-msg").hide();
   
    });    

    $("#register").click(function(event){
        $('#register').hide();
    	$('#registerbox').show();
    	$('#loginbox').hide();
        $('#fullname').val('');
    	$('#loginname').val('');    	
        $('#password').val('');
    	$('#confirmpassword').val('');    	
    });

    $("#login").click(function(event){
        $.ajax({
  	    url: "services/login-svc.xqy",
	    cache: false,
	    data: "loginname=" + $("#loginname").val() + 
	          "&password=" + $("#password").val(),
      	    success: function(data){
	      if(data == 'true') {
	          $('#messages').show();  	
	          $("#logout").show();
    	    	  $('#loginbox').hide();
    	          $('#register').hide();	          
	      }
    	    }	          
        });    
     
    });
    
    $("#logout").click(function(event){

      $.ajax({
    	url: "services/logout-svc.xqy",
	data: "clear-rules=true",
	cache: false,
	success: function(data){
	    $('#messages').hide();  
	    $("#logout").hide();
    	    $('#loginbox').show();
    	    $('#register').show();
    	}	              	
      });
      
    });
    
    $("#registerbutton").click(function(event){

    	if($('#password-r').val() != $('#confirmpassword-r').val()) {
          $('#password-r').val('');
    	  $('#confirmpassword-r').val('');
    	  $('#warning').show();
    	} else {
    	
    	$('#registerbox').hide();
    	$('#register').hide();	
  
        $.ajax({
  	    url: "services/register-svc.xqy",
	    cache: false,
	    data: "fullname=" + $("#fullname-r").val() + 
	          "&loginname=" + $("#loginname-r").val() +
	          "&password=" + $("#password-r").val(),
      	    success: function(html){
	      $('#messages').show();  	
	      $("#logout").show();
    	    }	          
        });
   
        }
    });    
        
    function getMessages() {
      $.ajax({
    	url: "services/messages",
    	cache: false,
    	success: function(html){
    	  $("#msglist").html(html);
    	}
      });
    }
    
    $("#searchbutton").click(function(event){
    
      checkAlerts();
 
      $("#mybox").hide();
      $("#msglist").html('');
      
      var searchTerm = $("#search").val();
      $('#search-term').attr('value', searchTerm);
      $("#search").val('');
      $("#alertlink").attr('href', '#');

      $("#searchresult-msg").html('Search Results for: ' + searchTerm);
      //$("#alert-msg").show('slow');
      $("#searchresult-msg").show('slow');
      
      $.ajax({
	url: "services/create-alerts-svc.xqy",
	data: "q=" + searchTerm,
	async: true, 
	cache: false,
	success: function(data){}	
      });
      
      $.ajax({
	url: "services/search-msg-svc.xqy",
	data: "q=" + searchTerm,
	cache: false,
	success: function(html){
	  $("#msglist").html(html);
	}

    });
      
    $("#alertlink").click(function(event){   
      $.ajax({
	url: "services/search-msg-svc.xqy",
	data: "q=" + $("#search-term").val(),
	cache: false,
	success: function(html){
	  $("#msglist").html(html);
	}
      });

      $.ajax({
	url: "services/clear-alerts-svc.xqy",
	data: "clear-rules=false",
	cache: false,
	success: function(data){}
      });      
      
      $("#alert-msg").hide();

    });

    $("#mybox").hide();
    $("#backtomessages").show();
  });
});
