<!--#include file="../inc/access.asp"  -->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/pingyin.asp" -->
<!-- #include file="../inc/x_to_html/index_to_html.asp" -->
<!-- #include file="../inc/x_to_html/blank_index_to_html.asp" -->

<% '��ȡ����
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
article_id=cint(request.querystring("id"))

id1=cint(request.querystring("id"))
pid_name=request.querystring("pid_name")
pid_name2=request.querystring("pid_name2")
ppid=cint(request.querystring("ppid"))

act1=Request("act1")
If act1="save" Then 

'�����ļ��л�ȡ
set rs_1=server.createobject("adodb.recordset")
sql="select FolderName from web_Models_type where [id]=2"
rs_1.open(sql),cn,1,1
if not rs_1.eof then
Blog_FolderName=rs_1("FolderName")
end if
rs_1.close
set rs_1=nothing

id2=trim(request.form("id2"))
c_name=trim(request.form("c_name"))
c_folder=trim(request.form("c_folder"))
c_image=trim(request.form("web_image"))
c_keywords=trim(request.form("c_keywords"))
c_description=trim(request.form("c_description"))
c_content=trim(request.form("a_content"))
c_ClassType=trim(request.form("ClassType"))
c_index_push=trim(request.form("c_index_push"))
c_time=now()
%>

<% '����ת����ƴ��
if c_folder="" then
c_folder=trans_letters(c_name)
end if
%>

<% '���ӵ����ݿ�
set rs_1=server.createobject("adodb.recordset")
sql="select [id] from category where ( [folder]='"&c_folder&"' and [folder]<>'' ) and [id]<>"&id2
rs_1.open(sql),cn,1,3
if not rs_1.eof then
response.Write "<script language='javascript'>alert('���ļ��������Ѿ����ڣ�������������');history.go(-1);</script>"
else
rs_1.close
set rs_1=nothing
set rs=server.createobject("adodb.recordset")
sql="select * from category where id="&id2&""
rs.open(sql),cn,1,3
rs("name")=c_name
rs("image")=c_image
rs("folder")=c_folder
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

<%'������Ŀ��ҳ
if c_ClassType=2  then
a_id=id2
call blank_index_to_html(a_id)
 end if
 %>

<%
response.Write "<script language='javascript'>alert('�޸ĳɹ���');location.href='category_list.asp?page="&page&"&act="&act&"&keywords="&keywords&"';</script>"
end if 
end if %>
<script type="text/javascript" charset="utf-8" src="../KKKeditor/kindeditor.js"></script>
<script type="text/javascript" src="../KKKeditor/editor.js"></script>
	<%
Call header()

%>
<%
set rs2=server.createobject("adodb.recordset")
sql="select * from category where id="&id1&""
rs2.open(sql),cn,1,3
if not rs2.eof and not rs2.bof then
%>
  <form id="form1" name="form1" method="post" action="?act1=save&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>&pid_name=<%=pid_name%>&pid_name2=<%=pid_name2%>&ppid=<%=ppid%>">
         <script language='javascript'>
function checksignup1() {
if ( document.form1.c_name.value == '' ) {
window.alert('��������Ŀ����^_^');
document.form1.c_name.focus();
return false;}

return true;}
</script>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class='tableHeaderText' colspan=2 height=25>��Ŀ����</th>
	<tr>
	<td width="15%" height=23 class='forumRow'>��Ŀ���� (����)</td>
	<td class='forumRow'><input name='c_name' type='text' id='c_nampe' value="<%=rs2("name")%>" size='40'>
	<input name='id2' type='hidden' id='id2' size='40' value="<%=id1%>">
	
	  &nbsp;<span style="color: #FF0000"><%
	  if ppid=2 then
response.write "��ǰΪ������Ŀ:&nbsp;"&pid_name&"&nbsp;>"
elseif ppid=3 then
response.write "��ǰΪ������Ŀ:&nbsp;"&pid_name&"&nbsp;>&nbsp;"&pid_name2&"&nbsp;>"
else
response.write "��ǰΪһ����Ŀ"
end if%></span></td>
	</tr>
    	<tr>
	<td class='forumRowHighLight' height=23>��Ŀ�ļ�������(ѡ��)</td>
    <td class='forumRowHighLight'><input type='text' id='c_folder' name='c_folder' value="<%=rs2("folder")%>" size='40'  >
      <span style="color: #FF0000">��ʹ��Ӣ������������Ϊ�ս��Զ�ʹ����Ŀ���Ƶ�ƴ������,������ַ�����Ч��</span> </td>
	</tr>
	  <tr>
	    <td class='forumRow' height=23>��ĿͼƬ</td>
	    <td width="85%" class='forumRow'><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%"  class='forumRow'><input name="web_image" type="text" id="web_image" value="<%=rs2("image")%>" size="30"></td>
           <td width="78%"  class='forumRow'><iframe width="500" name="ad" frameborder=0 height=30 scrolling=no src=upload.asp></iframe></td>
         </tr>
       </table></td>
      </tr>

      <td class='forumRowHighLight' height=11>��Ŀ�ؼ���</td>
	      <td class='forumRowHighLight'><input type='text' id='v3' name='c_keywords' value="<%=rs2("keywords")%>" size='80'>
	  &nbsp;���ԣ�����</td>
	</tr><tr>
	  <td class='forumRow' height=11>��Ŀ����</td>
	  <td class='forumRow'><textarea name='c_description'  cols="100" rows="4" id="c_description" ><%=rs2("description")%></textarea></td>
	</tr>
	<tr>
	  <td class='forumRowHighLight' height=23>��Ŀ���</td>
	  <td class='forumRowHighLight'> <textarea name="a_content" id="a_content" style=" width:100%; height:400px; visibility:hidden;"  ><%=rs2("content")%></textarea></td>
	</tr>
	<tr>
	  <td class='forumRow' height=23>��Ŀ����</td>
	  <td class='forumRow'><label>
	    <input type="radio" name="ClassType" value="1" <%
		if rs2("ClassType")=1 then
		response.write "checked"
		end if%>>
      ����  
	&nbsp;&nbsp;		
      <input name="ClassType" type="radio" value="2" <%if rs2("ClassType")=2 then
		response.write "checked"
		end if%>>
      ��ҳ</label></td>
	  </tr>
	<tr>
	  <td class='forumRowHighLight' height=23>��Ŀ�Ƽ�</td>
	  <td class='forumRowHighLight'><label>
	    <input type="radio" name="c_index_push" value="1" <%
		if rs2("index_push")=1 then
		response.write "checked"
		end if%>>
      ��
      &nbsp;
      <input name="c_index_push" type="radio" value="0" <%if rs2("index_push")=0 then
		response.write "checked"
		end if%>>
      ��</label></td>
	</tr>
	<tr><td height="50" colspan=2  class='forumRow'><div align="center">
	  <INPUT type=submit value='�ύ' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table>
</form>
<%
end if
rs2.close
set rs2=nothing
%>
<%
Call DbconnEnd()
 %>