<!--#include file="../inc/access.asp"  -->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/rand.asp" -->
<!-- #include file="../inc/x_to_html/index_to_html.asp" -->
<!-- #include file="../inc/x_to_html/article_to_html.asp" -->
<!-- #include file="../inc/x_to_html/blog_index_to_html.asp" -->
<!-- #include file="../inc/x_to_html/blog_class_list_to_html.asp" -->
<% '更新数据到数据表
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
article_id=cint(request.querystring("id"))



act1=Request("act1")
If act1="save" Then 


a_id=cint(request.form("a_id"))
a_title=request.form("a_title")
a_cid=trim(request.form("cid"))
a_pid=trim(request.form("pid"))
a_ppid=trim(request.form("ppid"))
a_url=trim(request.form("a_url"))
a_image=trim(request.form("web_image"))
a_keywords=trim(request.form("a_keywords"))
a_description=trim(request.form("a_description"))
a_content=request.form("a_content")
a_from_name=trim(request.form("a_from_name"))
a_from_url=trim(request.form("a_from_url"))
a_author=trim(request.form("a_author"))
a_hit=trim(request.form("a_hit"))
a_index_push=trim(request.form("a_index_push"))
a_keywords_yes=trim(request.form("a_keywords_yes"))
a_time=now()


'替换关键字
if a_keywords_yes=1 then
set rs_1=server.createobject("adodb.recordset")
sql="select [web_theme] from web_settings "
rs_1.open(sql),cn,1,1
if not rs_1.eof then
Theme_Folder=rs_1("web_theme")
end if
rs_1.close
set rs_1=nothing
set rs=server.createobject("adodb.recordset")
sql="select [name],[url] from web_keywords order by [time] desc"
rs.open(sql),cn,1,1
if not rs.eof  then
do while not rs.eof 

if rs("url")="" then
name_url="/query/?q="&rs("name")
else
name_url=rs("url")
end if

a_content=replace(a_content,rs("name"),"<a href='"&name_url&"' target='_blank'>"&rs("name")&"</a>")
rs.movenext
loop
end if
rs.close
set rs=nothing
end if

'文章文件夹获取
set rs_1=server.createobject("adodb.recordset")
sql="select FolderName from web_Models_type where [id]=9"
rs_1.open(sql),cn,1,1
if not rs_1.eof then
if rs_1("FolderName")<>"" then
Article_FolderName="/"&rs_1("FolderName")
end if
end if
rs_1.close
set rs_1=nothing

set rs=server.createobject("adodb.recordset")
sql="select * from [article] where id="&a_id&""
rs.open(sql),cn,1,3
rs("title")=a_title
rs("cid")=a_cid
rs("pid")=a_pid
rs("ppid")=a_ppid
rs("url")=a_url
rs("image")=a_image
rs("keywords")=a_keywords
rs("description")=a_description
rs("content")=a_content
rs("from_name")=a_from_name
rs("from_url")=a_from_url
rs("author")=a_author
rs("hit")=a_hit
rs("index_push")=a_index_push
rs("headline")=a_headline
rs("edit_time")=a_time
if request.form("slide_yes")<>"" then
rs("slide_yes")=1
else
rs("slide_yes")=0
end if
a_link=Article_FolderName&"/"&rs("file_path")
rs.update
rs.close
set rs=nothing
%>

<% '生成文章静态页
call article_to_html(a_id)
%>
<% '生成首页
call blog_index_to_html()
call index_to_html()
%>
<%
response.Write "<script language='javascript'>alert('修改成功！');location.href='article_list.asp?page="&page&"&act="&act&"&keywords="&keywords&"';</script>"
end if 
%>
<script type="text/javascript" charset="utf-8" src="../KKKeditor/kindeditor.js"></script>
<script type="text/javascript" src="../KKKeditor/editor.js"></script> 
 <!-- 三级联动菜单 开始 -->
<script language="JavaScript">
<!--
<%
'二级数据保存到数组
Dim count2,rsc2,sqlClass2
set rsc2=server.createobject("adodb.recordset")
sqlClass2="select id,pid,ppid,name from category where ppid=2 order by id " 
rsc2.open sqlClass2,cn,1,1
%>
var subval2 = new Array();
//数组结构：一级根值,二级根值,二级显示值
<%
count2 = 0
do while not rsc2.eof
%>
subval2[<%=count2%>] = new Array('<%=rsc2("pID")%>','<%=rsc2("ID")%>','<%=rsc2("Name")%>')
<%
count2 = count2 + 1
rsc2.movenext
loop
rsc2.close
%>

<%
'三级数据保存到数组
Dim count3,rsc3,sqlClass3
set rsc3=server.createobject("adodb.recordset")
sqlClass3="select id,pid,ppid,name from category where ppid=3 order by id" 
rsc3.open sqlClass3,cn,1,1
%>
var subval3 = new Array();
//数组结构：二级根值,三级根值,三级显示值
<%
count3 = 0
do while not rsc3.eof
%>
subval3[<%=count3%>] = new Array('<%=rsc3("pID")%>','<%=rsc3("ID")%>','<%=rsc3("Name")%>')
<%
count3 = count3 + 1
rsc3.movenext
loop
rsc3.close
%>

function changeselect1(locationid)
{
    document.form1.pid.length = 0;
    document.form1.pid.options[0] = new Option('选择二级分类','');
    document.form1.ppid.length = 0;
    document.form1.ppid.options[0] = new Option('选择三级分类','');
    for (i=0; i<subval2.length; i++)
    {
        if (subval2[i][0] == locationid)
        {document.form1.pid.options[document.form1.pid.length] = new Option(subval2[i][2],subval2[i][1]);}
    }
}

function changeselect2(locationid)
{
    document.form1.ppid.length = 0;
    document.form1.ppid.options[0] = new Option('选择三级分类','');
    for (i=0; i<subval3.length; i++)
    {
        if (subval3[i][0] == locationid)
        {document.form1.ppid.options[document.form1.ppid.length] = new Option(subval3[i][2],subval3[i][1]);}
    }
}
//-->
</script><!-- 三级联动菜单 结束 -->
	<%
Call header()

%>

         <script language='javascript'>
function checksignup1() {
if ( document.form1.a_title.value == '' ) {
window.alert('请输入文章标题^_^');
document.form1.a_title.focus();
return false;}

if ( document.form1.cid.value == '' ) {
window.alert('请选择分类^_^');
document.form1.cid.focus();
return false;}
return true;}
</script>
<%
      
			set rs=server.createobject("adodb.recordset")
sql="select * from [article] where id="&article_id&""
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
%>  <form id="form1" name="form1" method="post" action="?act1=save&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class='tableHeaderText' colspan=2 height=25>修改文章</th>
	<tr>
	<td width="15%" height=23 class='forumRow'>文章标题 (必填) </td>
	<td class='forumRow'><input name='a_title' type='text' id='a_title' value="<%=rs("title")%>" size='70'>
	<input name='a_id' type='hidden' id='a_id' value="<%=rs("id")%>" size='70'>
	  &nbsp;</td>
	</tr>
	<tr>
	<td class='forumRowHighLight' height=23>文章分类<span class="forumRow"> (必选) </span></td>
    <td class='forumRowHighLight'><%
set rsc1=server.createobject("adodb.recordset")
sqlClass1="select id,pid,ppid,name from category where ppid=1 order by id" 
rsc1.open sqlClass1,cn,1,1
%>
            <select name="cid" id="cid" onChange="changeselect1(this.value)">
              <option>选择一级分类</option>
              <% '输出一级分类，并选定当前分类
count1 = 0
do while not rsc1.eof
%><option value="<%=rsc1("ID")%>"  <%if cint(rs("cid"))=rsc1("id") then
response.write "selected"
end if%>><%=rsc1("Name")%></option>
<%count1 = count1 + 1
rsc1.movenext
loop
rsc1.close
%>
            </select>
            &nbsp;&nbsp;
	
            <select name="pid" id="pid"  onchange="changeselect2(this.value)">
              <option value="">选择二级分类</option>
			 		<%'输出二级分类，并选定当前分类
		if rs("pid")<>"" then	
set rsc2=server.createobject("adodb.recordset")
sqlClass2="select id,pid,ppid,name from category where ppid=2 and pid="&cint(rs("cid"))&" order by id" 
rsc2.open sqlClass2,cn,1,1

count1 = 0
do while not rsc2.eof
%><option value="<%=rsc2("ID")%>"  <%if cint(rs("pid"))=rsc2("id") then
response.write "selected"
end if%>><%=rsc2("Name")%></option>
<%count1 = count1 + 1
rsc2.movenext
loop
rsc2.close
end if
%>
            </select>
            &nbsp;&nbsp;
				
            <select name="ppid" id="ppid">
              <option value="">选择三级分类</option>
			  			  		<% '输出三级分类，并选定当前分类
								if rs("ppid")<>"" then
set rsc3=server.createobject("adodb.recordset")
sqlClass3="select id,pid,ppid,name from category where ppid=3 and pid="&cint(rs("pid"))&" order by id" 
rsc3.open sqlClass3,cn,1,1

count1 = 0
do while not rsc3.eof
%><option value="<%=rsc3("ID")%>"  <%if cint(rs("ppid"))=rsc3("id") then
response.write "selected"
end if%>><%=rsc3("Name")%></option>
<%count1 = count1 + 1
rsc3.movenext
loop
rsc3.close
end if
%>
            </select>&nbsp;</td>
	</tr>
	  <tr>
	    <td class='forumRow' height=23>文章跳转地址</td>
	    <td class='forumRow'><input name='a_url' type='text' id='c_name'  value="<%=rs("url")%>" size='70'>
        &nbsp;以http://开头</td>
      </tr>
	  <tr>
	    <td class='forumRowHighLight' height=23>文章图片</td>
	    <td width="85%" class='forumRowHighLight'><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%"  ><input name="web_image" type="text" id="web_image"  value="<%=rs("image")%>" size="30"></td>
           <td width="78%" ><iframe width="500" name="ad" frameborder=0 height=30 scrolling=no src=upload.asp></iframe></td>
         </tr>
       </table></td>
      </tr>

        <td  class='forumRow' height=23>文章关键字</td>
	      <td class='forumRow'><input type='text' id='v3' name='a_keywords'  value="<%=rs("keywords")%>" size='60'> <select name="keywords_list" id="keywords_list" onclick="document.form1.a_keywords.value=document.form1.keywords_list.value">
	      <option value="">请选择</option>
		   <% set rsp=server.createobject("adodb.recordset")
		   sql="select name from web_keywords order by [id] "
		   rsp.open(sql),cn,1,1
		   if not rsp.eof and not rsp.bof then
		   do while not rsp.eof 
		   %> <option value="<%=rsp("name")%>"  ><%=rsp("name")%></option>
            <%
			rsp.movenext
			loop
			end if
			rsp.close
			set rsp=nothing%></select>
	  &nbsp;请以，隔开(中文逗号)</td>
	</tr><tr>
	  <td class='forumRowHighLight' height=11>文章描述 / 文章摘要 </td>
	  <td class='forumRowHighLight'><textarea name='a_description'  cols="100" rows="4" id="a_description" ><%=rs("description")%></textarea></td>
	</tr>
	<tr>
	  <td class='forumRow' height=23>文章内容 (必填) </td>
	  <td class='forumRow'> <textarea name="a_content" id="a_content" style=" width:100%; height:400px; visibility:hidden;"  ><%=rs("content")%></textarea></td>
	</tr>
	<tr>
	  <td class='forumRowHighLight' height=23>文章来源</td>
	  <td class='forumRowHighLight'>
	    <input name='a_from_name' type='text' id='c_name2' value="<%=rs("from_name")%>" size='30'>
	   <select name="position" id="position" onclick="document.form1.a_from_name.value=document.form1.position.value">
	      <option value="">请选择</option>
		   <% set rsp=server.createobject("adodb.recordset")
		   sql="select name from web_article_author order by [order] "
		   rsp.open(sql),cn,1,1
		   if not rsp.eof and not rsp.bof then
		   do while not rsp.eof 
		   %> <option value="<%=rsp("name")%>"  ><%=rsp("name")%></option>
            <%
			rsp.movenext
			loop
			end if
			rsp.close
			set rsp=nothing%></select></td>
	  </tr>
	<tr>
	  <td class='forumRow' height=23>来源网址</td>
	  <td class='forumRow'><span class="forumRow">
	    <input name='a_from_url' type='text' id='c_name3' value="<%=rs("from_url")%>" size='40'>
      &nbsp;以http://开头</span></td>
	</tr>
	<tr>
	  <td class='forumRowHighLight' height=23>文章作者</td>
	  <td class='forumRowHighLight'><span class="forumRow">
	    <input name='a_author' type='text' id='c_name32' value="<%=rs("author")%>" size='40'>
	  </span></td>
	</tr>
	<tr>
	  <td class='forumRow' height=23>文章浏览次数</td>
	  <td class='forumRow'><input name='a_hit' type='text' id='a_hit' value="<%=rs("hit")%>" size='40'>
      &nbsp;只能是数字</td>
	  </tr>
	<tr>
	  <td class='forumRowHighLight' height=23>文章置顶</td>
	  <td class='forumRowHighLight'><label>
	    <input type="radio" name="a_index_push" value="1" <%
		if rs("index_push")=1 then
		response.write "checked"
		end if%>>
      是
      &nbsp;
      <input name="a_index_push" type="radio" value="0" <%if rs("index_push")=0 then
		response.write "checked"
		end if%>>
      否</label></td>
	</tr>	
	<tr>
	  <td class='forumRow' height=23>替换关键字</td>
	  <td class='forumRow'><input type="radio" name="a_keywords_yes" value="1" >
是
      &nbsp;
      <input name="a_keywords_yes" type="radio" value="0" checked>
否</td>
	  </tr>	
	<tr>
	  <td class='forumRowHighLight' height=23>文章属性</td>
	  <td class='forumRowHighLight'><label>
	    <input type="checkbox" name="slide_yes" value="1" <%
		if rs("slide_yes")=1 then
		response.write "checked='checked'"
		end if%>>
      设为幻灯片 
      <input name="special_yes" type="checkbox" value="1" >
      设为热点专题</label></td>
	  </tr>	 	  
	<tr><td height="50" colspan=2  class='forumRow'><div align="center">
	  <INPUT type=submit value='提交' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table>
</form>
<%
else
response.write"未找到数据"
end if%>
<%
Call DbconnEnd()
 %>