<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*"%>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    try {
        String url="jdbc:mysql://localhost/?serverTimezone=UTC";
        String sql="";
        Connection con=DriverManager.getConnection(url,"root","1234");
        if(con.isClosed())
           out.println("連線建立失敗");
        else { 
          sql="USE `cluster`";
          con.createStatement().execute(sql);
          sql = "SELECT * FROM `member` WHERE `Email`='"+session.getAttribute("email")+"'";
			    ResultSet memberrs =con.createStatement().executeQuery(sql);
			    String name="", mbclass="";
			    while(memberrs.next()){
	    		name = memberrs.getString("Name");
          mbclass = memberrs.getString("class");
          }
          sql = "SELECT member.Email, member.Name, member.Gender, memberskin.Skin, memberskin.Eyes, memberskin.Eyebrow, memberskin.Mouth, memberskin.Fronthair, memberskin.Backhair, memberskin.Clothes, memberskin.Accessories, member.Signature, member.Introduction, member.class FROM `member` JOIN `memberskin` ON member.Email = memberskin.Email WHERE member.class = '"+mbclass+"' AND member.Email NOT IN ('"+session.getAttribute("email")+"')";
			    ResultSet frrs =con.createStatement().executeQuery(sql);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>好友推薦</title>
    <!-- bootstrap required-->
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <link href="css/icon/css/all.css" rel="stylesheet">
    
    <style type="text/css">
      body,html {height:100%;}
      body{
        overflow-y: hidden;
        overflow-x: hidden;
      }
        .leftnav{
          background-color:#cb997e;
          height: 100%;
        } 
      a{
        color:black;
      }
      a:hover{text-decoration:none;}
        .mainarea{
          background-color: white;
          overflow:scroll;
          height: 800px;
        }
       i{
         color:white;
       } 
        .chatdiv{
          color:white;
          width:200px;
          background-color: #f2a65a;
          padding:15px;
          margin-top:15px;
          border-radius: 15px;
        }
        .mainboard{
          margin:30px;
        }
        #myTabContent{
          padding:30px;
          border-radius:20px;
          background-color: #f8edeb;
          height:85%;
        }
        .maindiv{
          background-color:white;
          padding:5px;
          margin-top:20px;
          border-radius: 20px;
          width:80%;
          
        }
        .userheader{
          position:relative;
          margin-top:20px;
          margin-left: 20px;
          margin-right: 120px;
        }
        .h2div{
          position: relative;
          font-weight: bolder;
          margin:10px;
          
        }
        .iframediv{
          position: relative;
          z-index: 2;
        }
        .open-button {
          background-color: #555;
          color: white;
          padding: 16px 20px;
          border: none;
          cursor: pointer;
          opacity: 0.8;
          position: fixed;
          bottom: 23px;
          right: 28px;
          height:50px;
          width: 50px;
        }
  
        /* The popup form - hidden by default */
        .form-popup {
          display: none;
          border: 3px solid #f1f1f1;
          position: absolute;
          z-index: 3;
          top:-5px;
          right:-5px;
          width: 350px;
        }
  
        /* Add styles to the form container */
        .form-container {
          max-width: 350px;
          padding: 10px;
          background-color: white;
        }
  
        /* Full-width input fields */
        .form-container input[type=text], .form-container input[type=password] {
          width: 100%;
          padding: 15px;
          margin: 5px 0 22px 0;
          border: none;
          background: #f1f1f1;
        }
  
        /* When the inputs get focus, do something */
        .form-container input[type=text]:focus, .form-container input[type=password]:focus {
          background-color: #ddd;
          outline: none;
        }
  
        /* Set a style for the submit/login button */
        .form-container .btn {
          background-color: #4CAF50;
          color: white;
          padding: 10px;
          margin: 5px;
          border: none;
          cursor: pointer;
          width: 30%;
          margin-bottom:10px;
          opacity: 0.8;
        }
  
        /* Add a red background color to the cancel button */
        .form-container .cancel {
          background-color: red;
        }
  
        /* Add some hover effects to buttons */
        .form-container .btn:hover, .open-button:hover {
          opacity: 1;
        }
        
        .percent{
          width:20%;
          margin:10px;
        }
        #myTabContent{
          width:100%;
          overflow:scroll;
          
        }
         #myTabContent::-webkit-scrollbar-track
          {
            border-radius: 10px;
            margin-top:10px;
            margin-bottom: 10px;
          }
          #myTabContent::-webkit-scrollbar
          {
            width: 10px;
          }
          #myTabContent::-webkit-scrollbar-thumb
          {
            border-radius: 10px;
            background-color:rgba(108,108,108,0.2);
          }
         .mainarea::-webkit-scrollbar-track
          {
            border-radius: 10px;
          }
          .mainarea::-webkit-scrollbar
          {
            width: 10px;
          }
          .mainarea::-webkit-scrollbar-thumb
          {
            border-radius: 10px;
            background-color:rgba(108,108,108,0.2);
          }
/* The popup chat - hidden by default */
.chat-popup2 {
  display: none;
  position: fixed;
  top: 30px;
  margin:0px auto;
  right: 300px;
  border: 2px solid #f1f1f1;
  z-index: 9;
}
/* Add styles to the form container */
.form-container2 {
  width:520px;
  padding: 10px;
  background-color: white;
}
/* Full-width textarea */
.form-container2 iframe {
  width: 100%;  
  height:620px;
  padding: 5px;
  border: none;
  background: #f1f1f1;
  resize: none;
  min-height: 300px;
}
#skin{
  z-index:2;
  height: 80px;
  width:80px;
  position:absolute;
  left:20px;
  top:15%;
  border-radius: 50%;
  border: 1px solid rgba(255,255,255,1.00);
  background:#fff;
}
#eyes{
  z-index:3;
  height: 80px;
  width:80px;
  position:absolute;
  left:20px;
  top:15%;
  border-radius: 50%;
}
#eyebrow{
  z-index:4;
  height: 80px;
  width:80px;
  position:absolute;
  left:20px;
  top:15%;
  border-radius: 50%;
}
#mouth{
  z-index:5;
  height: 80px;
  width:80px;
  position:absolute;
  left:20px;
  top:15%;
  border-radius: 50%;
}
#fronthair{
  z-index:6;
  height: 80px;
  width:80px;
  position:absolute;
  left:20px;
  top:15%;
  border-radius: 50%;
}
#backhair{
  z-index:7;
  height: 80px;
  width:80px;
  position:absolute;
  left:20px;
  top:15%;
  border-radius: 50%;
}
#clothes{
  z-index:8;
  height: 80px;
  width:80px;
  position:absolute;
  left:20px;
  top:15%;
  border-radius: 50%;
}
#accessories{
  z-index:9;
  height: 80px;
  width:80px;
  position:absolute;
  left:20px;
  top:15%;
}
#skin2{
  z-index:2;
  height: 100px;
  width:100px;
  position:absolute;
}
#eyes2{
  z-index:3;
  height: 100px;
  width:100px;
  position:absolute;
}
#eyebrow2{
  z-index:4;
  height: 100px;
  width:100px;
  position:absolute;
}
#mouth2{
  z-index:5;
  height: 100px;
  width:100px;
  position:absolute;
}
#fronthair2{
  z-index:6;
  height: 100px;
  width:100px;
  position:absolute;
}
#backhair2{
  z-index:7;
  height: 100px;
  width:100px;
  position:absolute;
}
#clothes2{
  z-index:8;
  height: 100px;
  width:100px;
  position:absolute;
}
#accessories2{
  z-index:9;
  height: 100px;
  width:100px;
  position:absolute;
}


.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  margin: auto;
  text-align: center;
  font-family: arial;
}

.title {
  color: grey;
  font-size: 18px;
}

button {
  border: none;
  outline: 0;
  display: inline-block;
  padding: 8px;
  color: white;
  background-color: #000;
  text-align: center;
  cursor: pointer;
  width: 100%;
  font-size: 18px;
}

.add:hover, a:hover {
  opacity: 0.7;
}


</style>
<script type="text/javascript">
$(function(){
$(".flip").hover(function(){
    $(".panel").slideToggle("normal");
    $(".xs1").toggle();
    $(".xs2").toggle();
  });
});
$(function(){
$(".flip2").hover(function(){
    $(".pane2").slideToggle("normal");
    $(".xs1").toggle();
    $(".xs2").toggle();
  });
});
</script>
</head>

<body>


   <!--第一區-->
   <div class="container-fluid" style="height: 100%;">
    <div class="row justify-content-center" style="height: 100%;">
      <div class="col leftnav">
        <ul class="nav flex-column" style="height: 100%">
          <li class="nav-item" style="height: 17%"></li>
          <li class="nav-item" style="height: 15%;">
            <a class="nav-link active" href="member.jsp" style="color:white;font-size:large">
              <%
                String new_mail=(String)(session.getAttribute("email"));
                //con.createStatement().execute("USE `cluster`");
                String sql1 = "SELECT * FROM `memberskin` WHERE `Email`='"+new_mail+"'";
                ResultSet rs1 =  con.createStatement().executeQuery(sql1);
                con.createStatement().execute(sql1);
                while(rs1.next())
                {
                    out.println("<img src='img/header/skin/skin"+rs1.getString(2)+".png' id='skin'>");
                    out.println("<img src='img/header/eyes/eyes"+rs1.getString(3)+".png' id='eyes'>");
                    out.println("<img src='img/header/eyebrow/eyebrow"+rs1.getString(4)+".png' id='eyebrow'>");
                    out.println("<img src='img/header/mouth/mouth"+rs1.getString(5)+".png' id='mouth'>");
                    out.println("<img src='img/header/fronthair/fronthair"+rs1.getString(6)+".png' id='fronthair'>");
                    out.println("<img src='img/header/backhair/backhair"+rs1.getString(7)+".png' id='backhair'>");
                    out.println("<img src='img/header/clothes/clothes"+rs1.getString(8)+".png' id='clothes'>");
                    out.println("<img src='img/header/accessories/accessories"+rs1.getString(9)+".png' id='accessories'>");
                }
                //con.close();
%>
              <span style="position:absolute; left: 120px;font-size:larger;"><%=name%></span></a>
          </li>
          <li class="nav-item" style="height: 10%">
            <a class="nav-link active" href="homepage.jsp"style="color:white;font-size:larger;margin-top:10px;"><i class="far fa-newspaper fa-lg"></i>　話題</a>
          </li>
          <li class="nav-item"style="height: 10%">
            <a class="nav-link" href="recommend.jsp"style="color:white;font-size:larger;margin-top:10px;"><i class="far fa-bell fa-lg"></i>　推薦</a>
          </li>
          <li class="nav-item"style="height: 10%">
            <a class="nav-link" href="friends.jsp"style="color:white;font-size:larger;margin-top:10px;"><i class="far fa-address-book fa-lg"></i>　好友</a>
          </li>
          
          <li class="nav-item"style="height: 10%">
            <a class="nav-link" href="logout.jsp"style="color:white;font-size:larger;margin-top:10px;"><i class="fas fa-power-off fa-lg"></i>　登出</a>
          </li>
          <li class="nav-item" style="height: 17%"></li>
        </ul>
      </div>

 <!--第一區-->

      <!--第二區-->
      <div class="col-8 mainarea">
        <div class="mainboard" style="height:80%">
          <div class="h2div" ><h2 style="font-weight:bold;">你可能感興趣的人</h2>

            <!--第二區form-->
         <div class="form-popup" id="myForm">
           <form action="add_topic.jsp" class="form-container">
             <h2>開新話題</h2>
               <div class="form-group">
                 <label for="title">標題</label>
                 <input type="text" class="form-control" id="title" name="subject" placeholder="請輸入標題">
               </div>
               <div class="form-group">
                 <label for="textarea">內文</label>
                 <textarea class="form-control" id="textarea" name="content" rows="4" placeholder="請輸入內文"></textarea>
               </div>
               <div class="form-group">
                 <label for="category">分類</label>
                 <select class="form-control" id="category" name="category">
                   <option>音樂</option>
                   <option>電影</option>
                   <option>運動</option>
                   <option>遊戲</option>
                   <option>旅遊</option>
                   <option>美食</option>
                 </select>
               </div>
             <button type="submit" class="btn">提交</button><button type="button" class="btn cancel" onclick="closeForm()">取消</button>
           </form>
         </div>
         
       </div>
 <!--第二區form-->

          <!--四個一組，超過四個就再多一個card-group-->  
         <div class="card-group"> 
            <%
            int i = 1, j = 0;
                
            while(frrs.next())
            {
              out.println("<div class='card text-center'>");
              out.println("<div class='card-body'>");
              out.println("<img src='img/header/skin/skin"+frrs.getString("Skin")+".png' id='skin2' class='headersstyle'>");
              out.println("<img src='img/header/eyes/eyes"+frrs.getString("Eyes")+".png' id='eyes2' class='headersstyle'>");
              out.println("<img src='img/header/eyebrow/eyebrow"+frrs.getString("Eyebrow")+".png' id='eyebrow2' class='headersstyle'>");
              out.println("<img src='img/header/mouth/mouth"+frrs.getString("Mouth")+".png' id='mouth2' class='headersstyle'>");
              out.println("<img src='img/header/fronthair/fronthair"+frrs.getString("Fronthair")+".png' id='fronthair2' class='headersstyle'>");
              out.println("<img src='img/header/backhair/backhair"+frrs.getString("Backhair")+".png' id='backhair2' class='headersstyle'>");
              out.println("<img src='img/header/clothes/clothes"+frrs.getString("Clothes")+".png' id='clothes2' class='headersstyle'>");
              out.println("<img src='img/header/accessories/accessories"+frrs.getString("Accessories")+".png' id='accessories2' class='headersstyle'>");
              out.println("<h5 class='card-title'>"+frrs.getString("Name")+"</h5>");
              out.println("<p class='card-text'>"+frrs.getString("Signature")+"</p>");
              out.println("<span class='badge rounded-pill bg-warning'>喜歡的</span>");
              out.println("<span class='badge rounded-pill bg-warning'>標籤們</span>");
              out.println("<br>");
              out.println("<span class='badge rounded-pill bg-secondary'>不喜歡的</span>");
              out.println("<span class='badge rounded-pill bg-secondary'>標籤們</span>");

                j+=i;
                out.println("<form action='add_friends.jsp' method='post' id='add_friends"+j+"'>");
                out.println("<input type='hidden' name='addEmail' value='"+frrs.getString("Email")+"'>");
                out.println("</form>");

              out.println("<button type='submit' form='add_friends"+j+"' value='submit' class='btn btn-primary'>加好友</button>");
              out.println("<button class='btn btn-danger'>不感興趣</button>");
              out.println("</div>");
              out.println("</div>");

            }
            
            %>
          </div>
        </div> 
      </div>
            
          
    


 <!--第三區-->
 <div class="col mainarea">
  <div class="thirdarea"style="height:100%">
  <%
    sql="SELECT title FROM chat WHERE chat.Name='"+name+"' GROUP BY title";
    ResultSet rs4=con.createStatement().executeQuery(sql);
    while(rs4.next())
    {
      sql="SELECT post.Subject, post.Category, COUNT(title) AS 討論度, post.Content, post.pno FROM chat JOIN post ON chat.title = post.pno WHERE chat.title = '"+rs4.getString(1)+"' ORDER BY chatid DESC";ResultSet rs5=con.createStatement().executeQuery(sql);
      //out.println("<script>console.log('[sql]: "+rs4.getString(1)+"')</script>");
      //out.println("<script>console.log('[sql]: "+"SELECT post.Subject, post.Category, COUNT(title) AS 討論度, post.Content FROM chat JOIN post ON chat.title = post.pno GROUP BY "+rs4.getString(1)+" ORDER BY chatid DESC"+"')</script>");
      while(rs5.next())
      {
        String room =rs5.getString(5);
        String set =rs5.getString(1);

        out.println("<a href='#' onclick=\"setcookie('"+room+"','"+set+"')\">"); 
        out.println("<div class='row'>");
        out.println("<div class='chatdiv'>");
        out.println("<i class='fas fa-user fa-2x'></i><span style='color:white'>　討論度：</span><span style='color:white'>"+ rs5.getString(3) +"</span>");
        out.println("<br>");
        out.println("<span class=''>"+ rs5.getString(1) +"</span>");
        out.println("</div>");
        out.println("</div>");
        out.println("</a>");
      }
    }
    %>

<!--第三區iframe-->    
<div class="chat-popup2" id="myForm2">
<div class="form-container2">

<iframe id="myframe" src="http://localhost:3000/room/%E6%9C%89%E4%BA%BA%E8%B7%9F%E6%88%91%E4%B8%80%E6%A8%A3%E6%80%95%E7%95%AB%E7%95%AB%E5%97%8E%EF%BC%9F" >
      你的瀏覽器不支援 iframe
</iframe>
</div>
</div>
<!--第三區iframe-->

  <div class="row">
    <button class="open-button" onclick="openForm()">+</button>
  </div>
</div>
</div>
<!--第三區-->

  </div>
</div>
<!--close-->
<%
//Step 6: 關閉連線
          con.close();
      }
    }
    catch (SQLException sExec) {
           out.println("SQL錯誤");
		   
    }
}
catch (ClassNotFoundException err) {
      out.println("class錯誤");
}
%>  
  
</body>
</html>