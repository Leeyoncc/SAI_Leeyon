<!--#include file="../inc/access.asp"  -->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/pingyin.asp" -->
<!-- #include file="../inc/x_to_html/index_to_html.asp" -->
<!-- #include file="../inc/x_to_html/blank_index_to_html.asp" -->
<% '读取数据
pid_name=request.querystring("pid_name")
pid_name2=request.querystring("pid_name2")
pid=cint(request.querystring("pid"))
ppid=cint(request.querystring("ppid"))

act=Request("act")
If act="save" Then 
pid=trim(request.form("pid"))
ppid=trim(request.form("ppid"))
c_name=trim(request.form("c_name"))
c_folder=trim(request.form("c_folder"))
c_image=trim(request.form("web_image"))
c_keywords=trim(request.form("c_keywords"))
c_description=trim(request.form("c_description"))
c_content=trim(request.form("a_content"))
c_ClassType=trim(request.form("ClassType"))
c_index_push=trim(request.form("c_index_push"))
c_time=now()

'博客文件夹获取
set rs_1=server.createobject("adodb.recordset")
sql="select FolderName from web_Models_type where [id]=2"
rs_1.open(sql),cn,1,1
if not rs_1.eof then
Blog_FolderName=rs_1("FolderName")
end if
rs_1.close
set rs_1=nothing
%>


<% '汉字转化成拼音
if c_folder="" then
c_folder=trans_letters(c_name)
end if
%>

<% '判断是否名称重复并添加到数据库

set rs=server.createobject("adodb.recordset")
sql="select * from category where [folder]='"&c_folder&"'"
rs.open(sql),cn,1,3
if not rs.eof then
response.Write "<script language='javascript'>alert('该栏目文件夹名称已经存在，请重新命名！');history.go(-1);</script>"
else
rs.addnew
if ppid=2 then
rs("pid")=pid
rs("ppid")=2
elseif ppid=3 then
rs("pid")=pid
rs("ppid")=3
else
rs("ppid")=1
end if
rs("name")=c_name
rs("folder")=c_folder
rs("image")=c_image
rs("keywords")=c_keywords
rs("description")=c_description
rs("content")=c_content
rs("ClassType")=c_ClassType
rs("index_push")=c_index_push
rs("time")=c_time
rs.update
rs.close
set rs=nothing


%>
<%'生成栏目单页
if c_ClassType=2  then
set rs2=server.createobject("adodb.recordset")
sql="select top 1 [id] from [category] where [name]='"&c_name&"' order by [time] desc"
rs2.open(sql),cn,1,1
if not rs2.eof  then
a_id=rs2("id")
call blank_index_to_html(a_id)
end if
rs2.close
set rs2=nothing
end if %>
<%
response.Write "<script language='javascript'>alert('添加成功！');location.href='category_list.asp';</script>"
end if 
end if
 %>
 <script type="text/javascript" charset="utf-8" src="../KKKeditor/kindeditor.js"></script>
<script type="text/javascript" src="../KKKeditor/editor.js"></script>
	<%
Call header()

%>

  <form id="form1" name="form1" method="post" action="?act=save&pid_name=<%=pid_name%>&pid_name2=<%=pid_name2%>">
         <script language='javascript'>
function checksignup1() {
if ( document.form1.c_name.value == '' ) {
window.alert('请输入栏目名称^_^');
document.form1.c_name.focus();
return false;}

return true;}
</script>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class='tableHeaderText' colspan=2 height=25>添加栏目</th>
	<tr>
	  <td height=23 colspan="2" class='forumRow'><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="20" class='TipTitle'>&nbsp;√ 操作提示</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords"><p>1、一般情况下，您可需要填写栏目名称即可，“栏目推荐”决定您的栏目是否显示在页面侧边栏。</p>
          <p>2、栏目有两种类型："文章"和"单页"，前者可以在该栏目下添加多篇文章，后台只形成单一的页面，无法添加多篇文章。</p></td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table></td>
	  </tr>
	<tr>
	<td width="15%" height=23 class='forumRowHighLight'>栏目名称 (必填) </td>
	<td class='forumRowHighLight'><input name='c_name' type='text' id='c_nampe' size='40'>
	<input name='pid' type='hidden' id='pid' size='40' value="<%=pid%>">
	<input name='ppid' type='hidden' id='ppid' size='40' value="<%=ppid%>">
	  &nbsp;<span style="color: #FF0000"><%
	  if ppid=2 then
response.write "当前为二级栏目:&nbsp;"&pid_name
elseif ppid=3 then
response.write "当前为三级栏目:&nbsp;"&pid_name&"&nbsp;>&nbsp;"&pid_name2
else
response.write "当前为一级栏目"
end if%></span></td>
	</tr>
	<tr>
	<td class='forumRowHighLight' height=23>栏目文件夹名称 (选填)</td>
    <td class='forumRowHighLight'><input type='text' id='c_folder' name='c_folder' size='40'>
      &nbsp;<span style="color: #FF0000">请使用英文命名，保持为空将自动使用栏目名称的拼音命名,填入的字符将无效。</span></td>
	</tr>	  <tr>
	    <td class='forumRow' height=23>栏目图片</td>
	    <td width="85%" class='forumRow'><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%"  class='forumRow'><input name="web_image" type="text" id="web_image"  size="30"></td>
           <td width="78%"  class='forumRow'><iframe width="500" name="ad" frameborder=0 height=30 scrolling=no src=upload.asp></iframe></td>
         </tr>
       </table></td>
      </tr>

      <td class='forumRowHighLight' height=11>栏目关键字</td>
	      <td class='forumRowHighLight'><input type='text' id='v3' name='c_keywords' size='80'>
	  &nbsp;请以，隔开</td>
	</tr><tr>
	  <td class='forumRow' height=11>栏目描述</td>
	  <td class='forumRow'><textarea name='c_description'  cols="100" rows="4" id="c_description" ></textarea></td>
	</tr>
	<tr>
	  <td class='forumRowHighLight' height=23>栏目简介</td>
	  <td class='forumRowHighLight'> <textarea name="a_content" id="a_content" style=" width:100%; height:400px; visibility:hidden;"></textarea></td>
	</tr>
	<tr>
	  <td class='forumRow' height=23>栏目属性</td>
	  <td class='forumRow'><label>
	    <input name="ClassType" type="radio" value="1" checked="checked" >
      文章  
	&nbsp;&nbsp;		
      <input name="ClassType" type="radio" value="2"  />
      单页</label></td>
	  </tr>
	<tr>
	  <td class='forumRow' height=23>栏目推荐</td>
	  <td class='forumRow'><label>
	    <input name="c_index_push" type="radio" value="1" checked="checked">
      是
      &nbsp;
      <input name="c_index_push" type="radio" value="0">
      否</label></td>
	</tr>
	<tr><td height="50" colspan=2  class='forumRow'><div align="center">
	  <INPUT type=submit value='提交' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table>
</form>

<%
Call DbconnEnd()
 %>