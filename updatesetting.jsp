<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            sql="use `cluster`";
            con.createStatement().execute(sql);
           
            String new_name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");
            String new_gender=request.getParameter("gender");
            String new_goodtag=request.getParameter("goodtag");
            String new_badtag=request.getParameter("badtag");
            String new_signature=new String(request.getParameter("signature").getBytes("ISO-8859-1"),"UTF-8");
            String new_introduction=new String(request.getParameter("introduction").getBytes("ISO-8859-1"),"UTF-8");
            String new_oldpwd=request.getParameter("oldpwd");
            String new_newpwd=request.getParameter("newpwd");
            String new_renewpwd=request.getParameter("renewpwd");

            sql = "SELECT * FROM `member` WHERE `Email`='"+session.getAttribute("email")+"'"; 
			ResultSet rs =con.createStatement().executeQuery(sql);
			String name="", gender="", pwd="", signature="", introduction="";
			while(rs.next())
            {
	    		name=rs.getString("Name");
				gender=rs.getString("Gender");
				pwd=rs.getString("Password");
                signature=rs.getString("Signature");
                introduction=rs.getString("Introduction");
			}

            if(new_name.equals(name))
            {
                out.println("<SCRIPT LANGUAGE='JavaScript'>");
                out.println("history.back();");
                out.println("</SCRIPT>");
            }
            else
            {
                sql = "UPDATE `member` SET `Name`='"+new_name+"' WHERE `Email`='"+session.getAttribute("email")+"'";
                con.createStatement().execute(sql);
                out.println("<SCRIPT LANGUAGE='JavaScript'>");
                out.println("history.back();");
                out.println("</SCRIPT>");
            }

            if(new_gender.equals(gender))
            {
                out.println("<SCRIPT LANGUAGE='JavaScript'>");
                out.println("history.back();");
                out.println("</SCRIPT>");
            }
            else
            {
                sql = "UPDATE `member` SET `Gender`='"+new_gender+"' WHERE `Email`='"+session.getAttribute("email")+"'";
                con.createStatement().execute(sql);
                out.println("<SCRIPT LANGUAGE='JavaScript'>");
                out.println("history.back();");
                out.println("</SCRIPT>");
            }

            if(new_goodtag != null && new_goodtag != "")
            {
                sql = "INSERT membergoodtag (`Email`, `goodtag`) VALUE ('"+session.getAttribute("email")+"', '"+new_goodtag+"')";
                con.createStatement().execute(sql);
                out.println("<SCRIPT LANGUAGE='JavaScript'>");
                out.println("history.back();");
                out.println("</SCRIPT>");
            }

            if(new_badtag != null && new_badtag != "")
            {
                sql = "INSERT `memberbadtag` (`Email`, `goodtag`) VALUE ('"+session.getAttribute("email")+"', '"+new_badtag+"')";
                con.createStatement().execute(sql);
                out.println("<SCRIPT LANGUAGE='JavaScript'>");
                out.println("history.back();");
                out.println("</SCRIPT>");
            }

            if(new_signature.equals(signature))
            {
                out.println("<SCRIPT LANGUAGE='JavaScript'>");
                out.println("history.back();");
                out.println("</SCRIPT>");
            }
            else
            {
                sql = "UPDATE `member` SET `Signature`='"+new_signature+"' WHERE `Email`='"+session.getAttribute("email")+"'";
                con.createStatement().execute(sql);
            }

            if(!new_introduction.equals(introduction))
            {
                out.println("<SCRIPT LANGUAGE='JavaScript'>");
                out.println("history.back();");
                out.println("</SCRIPT>");
            }
            else
            {
                sql = "UPDATE `member` SET `Introduction`='"+new_introduction+"' WHERE `Email`='"+session.getAttribute("email")+"'";
                con.createStatement().execute(sql);
            }

            if(new_oldpwd !=null && new_newpwd !=null && new_renewpwd !=null && new_oldpwd !="" && new_newpwd !="" && new_renewpwd !="")
            {
                if(new_oldpwd.equals(pwd))
                {
                    if(new_newpwd.equals(new_renewpwd))
                    {
                        sql = "UPDATE `member` SET `Password`='"+new_newpwd+"' WHERE `Email`='"+session.getAttribute("email")+"'";
                        con.createStatement().execute(sql);
                        out.println("<SCRIPT LANGUAGE='JavaScript'>");
                        out.println("alert('密碼更新成功')");
                        out.println("history.back();");
                        out.println("</SCRIPT>");
                    }
                    else
                    {
                        out.println("<SCRIPT LANGUAGE='JavaScript'>");
                        out.println("alert('新密碼 與 確認密碼不符')");
                        out.println("history.back();");
                        out.println("</SCRIPT>");
                    }
                }
                else
                {
                    out.println("<SCRIPT LANGUAGE='JavaScript'>");
                    out.println("alert('舊密碼輸入錯誤')");
                    out.println("history.back();");
                    out.println("</SCRIPT>");
                }
            }
           con.close();
        }

  }
    catch (SQLException sExec) {
           out.println("SQL錯誤"+sExec.toString());
    }
}
catch (ClassNotFoundException err) {
   out.println("class錯誤"+err.toString());
}
%>