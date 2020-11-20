<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>話題</title>
    <!-- bootstrap required-->
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <style>

      body,html {height:100%;}
        .leftnav{
          background-color: rgb(141, 141, 141);
          height: 100%;
        } 
      a{
        color:black;
      }
        .mainarea{
          background-color: white;
        }
        .chatdiv{
          background-color: rgb(141, 174, 211);
          padding:15px;
          margin:15px;
          border-radius: 10%;
        }
        .mainboard{
          margin:30px;
          
        }
        #myTabContent{
          padding:30px;
          border-radius:15px;
          background-color: rgb(188, 228, 238);
          height:85%;
        }
        .maindiv{
          background-color:white;
          padding:5px;
          margin-top:10px;
          border-radius: 10px;
          width:60%;
          
        }
  
  
        .h2div{
          position: relative;
          z-index: 1;
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
  
       </style>
</head>

<body>


  <div class="container-fluid" style="height: 100%;">
    <div class="row justify-content-center" style="height: 100%;">
      <!--第一區-->
      <div class="col leftnav">
        <ul class="nav flex-column" style="height: 100%">
          <li class="nav-item" style="height: 17%"></li>
          <li class="nav-item" style="height: 15%">
            
            <a class="nav-link active" href="member.html"><img src="img/test.jpg" style="width:30%">User name</a>
          </li>
          <li class="nav-item" style="height: 10%">
            <a class="nav-link active" href="homepage.html">話題</a>
          </li>
          <li class="nav-item"style="height: 10%">
            <a class="nav-link" href="#">通知</a>
          </li>
          <li class="nav-item"style="height: 10%">
            <a class="nav-link" href="#">好友</a>
          </li>
          <li class="nav-item"style="height: 10%">
            <a class="nav-link" href="#">聊天</a>
          </li>
          <li class="nav-item"style="height: 10%">
            <a class="nav-link" href="#">登出</a>
          </li>
          <li class="nav-item" style="height: 17%"></li>
        </ul>
      </div>

      <!--第二區-->
      <div class="col-8 mainarea">
        <div class="mainboard" style="height:80%">
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="search" placeholder="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
        <div class="h2div" ><h2>話題</h2>

        <div class="form-popup" id="myForm">
          <form action="" class="form-container">
            <h2>開新話題</h2>
              <div class="form-group">
                <label for="title">標題</label>
                <input type="text" class="form-control" id="title" placeholder="請輸入標題">
              </div>
              <div class="form-group">
                <label for="textarea">內文</label>
                <textarea class="form-control" id="textarea" rows="4" placeholder="請輸入內文"></textarea>
              </div>
              <div class="form-group">
                <label for="category">分類</label>
                <select class="form-control" id="category">
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

          <ul class="nav justify-content-end" id="myTab" role="tablist">
            <li class="nav-item">
              <a class="nav-link active" id="home-tab" data-toggle="tab" href="#guess" role="tab" aria-controls="guess" aria-selected="true">猜你喜歡</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="profile-tab" data-toggle="tab" href="#hot" role="tab" aria-controls="hot" aria-selected="false">熱門話題</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="contact-tab" data-toggle="tab" href="#new" role="tab" aria-controls="new" aria-selected="false">最新話題</a>
            </li>
          </ul>
       
          <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="guess" role="tabpanel" aria-labelledby="home-tab">
              <div class="row" >
                <img src="img/test.jpg" style="width:10%;margin:10px;">
              <div class="maindiv">
                  <span class="">話題標題</span>
                  <p class="">話題內容話題內容</span><br>
                  <span class="badge badge-primary">音樂</span>
                </div>
                <div class="percent"><h2>80%</h2></div>
                
              </div>  
              <div class="row" >
                <img src="img/test.jpg" style="width:10%;margin:10px;">
              <div class="maindiv">
                  <span class="">話題標題</span>
                  <p class="">話題內容話題內容</span><br>
                    <span class="badge badge-primary">音樂</span>
                </div>
                <div class="percent"><h2>80%</h2></div>
              </div> 
              <div class="row" >
                <img src="img/test.jpg" style="width:10%;margin:10px;">
              <div class="maindiv">
                  <span class="">話題標題</span>
                  <p class="">話題內容話題內容</span><br>
                    <span class="badge badge-primary">音樂</span>
                </div>
                <div class="percent"><h2>80%</h2></div>
              </div> 
            </div>
            <div class="tab-pane fade" id="hot" role="tabpanel" aria-labelledby="profile-tab">
              <div class="row" >
                <img src="img/test.jpg" style="width:10%;margin:10px;">
              <div class="maindiv">
                  <span class="">話題標題</span>
                  <p class="">話題內容話題內容</span><br>
                    <span class="badge badge-primary">音樂</span>
                </div>
                <div class="percent"><h2>80%</h2></div>
              </div> 
              <div class="row" >
                <img src="img/test.jpg" style="width:10%;margin:10px;">
              <div class="maindiv">
                  <span class="">話題標題</span>
                  <p class="">話題內容話題內容</span><br>
                    <span class="badge badge-primary">音樂</span>
                </div>
                <div class="percent"><h2>80%</h2></div>
              </div> 
              
            </div>
            <div class="tab-pane fade" id="new" role="tabpanel" aria-labelledby="contact-tab">
              <div class="row" >
                <img src="img/test.jpg" style="width:10%;margin:10px;">
              <div class="maindiv">
                  <span class="">話題標題</span>
                  <p class="">話題內容話題內容</span><br>
                    <span class="badge badge-primary">音樂</span>
                </div>
                <div class="percent"><h2>80%</h2></div>
              </div> 
              <div class="row" >
                <img src="img/test.jpg" style="width:10%;margin:10px;">
              <div class="maindiv">
                  <span class="">話題標題</span>
                  <p class="">話題內容話題內容</span><br>
                    <span class="badge badge-primary">音樂</span>
                </div>
                <div class="percent"><h2>80%</h2></div>
              </div> 
            </div>
          </div>
        </div>

      </div>

      <!--第三區-->
      <div class="col mainarea">
        
        <div class="row">
          <div class="chatdiv">
            <img src="img/test.jpg" style="width:25%;">
            <img src="img/test.jpg" style="width:15%;"><img src="img/test.jpg" style="width:15%;">...+5
            <br>
            <span class="">話題標題</span>
            <p class="">話題內容話題內容</span>
          </div>
        </div>
        <div class="row">
          <div class="chatdiv">
            <img src="img/test.jpg" style="width:25%;">
            <img src="img/test.jpg" style="width:15%;"><img src="img/test.jpg" style="width:15%;">...+5
            <br>
            <span class="">話題標題</span>
            <p class="">話題內容話題內容</span>
          </div>
        </div>
        <div class="row">
          <div class="chatdiv">
            <img src="img/test.jpg" style="width:25%;">
            <img src="img/test.jpg" style="width:15%;"><img src="img/test.jpg" style="width:15%;">...+5
            <br>
            <span class="">話題標題</span>
            <p class="">話題內容話題內容</span>
          </div>
        </div>
        <div class="row">
          <button class="open-button" onclick="openForm()">+</button>
        </div>
      </div>

      </div>
    </div>
  </div>
  

  <script>
    function openForm() {
      document.getElementById("myForm").style.display = "block";
    }
    
    function closeForm() {
      document.getElementById("myForm").style.display = "none";
    }
    </script>

</body>
</html>
