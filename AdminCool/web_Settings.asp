<!--#include file="../inc/access.asp"  -->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/x_to_html/index_to_html.asp" -->
<%
act=Request("act")
If act="save" Then 
web_name=trim(request.form("web_name"))
web_slogan=trim(request.form("web_slogan"))
web_url=trim(request.form("web_url"))
web_image=trim(request.form("web_image"))
web_title=trim(request.form("web_title"))
web_keywords=trim(request.form("web_keywords"))
web_description=trim(request.form("web_description"))
web_copyright=trim(request.form("web_copyright"))
'web_contact=trim(request.form("a_content"))
web_person=trim(request.form("web_person"))
web_birthdate=trim(request.form("web_birthdate"))
web_birthplace=trim(request.form("web_birthplace"))
web_shortintro=trim(request.form("web_shortintro"))
web_email=trim(request.form("web_email"))
web_tel=trim(request.form("web_tel"))
web_ModelEdit=trim(request.form("web_ModelEdit"))
web_time=trim(request.form("web_time"))
if web_time="" then
 web_time=now()
end if 

set rs=server.createobject("adodb.recordset")
sql="select * from web_settings"
rs.open(sql),cn,1,3
rs("web_name")=web_name
rs("web_slogan")=web_slogan
rs("web_url")=web_url
rs("web_image")=web_image
rs("web_title")=web_title
rs("web_keywords")=web_keywords
rs("web_description")=web_description
rs("web_copyright")=web_copyright
'rs("web_contact")=web_contact
rs("web_person")=web_person
rs("web_birthdate")=web_birthdate
rs("web_birthplace")=web_birthplace
rs("web_shortintro")=web_shortintro
rs("web_email")=web_email
rs("web_tel")=web_tel
rs("web_ModelEdit")=web_ModelEdit
rs("web_time")=web_time
rs.update
rs.close
set rs=nothing

call index_to_html()
response.Write "<script language='javascript'>alert('�޸ĳɹ���')</script>"

end if
 %>
<script type="text/javascript" charset="utf-8" src="../KKKeditor/kindeditor.js"></script>
<script type="text/javascript" src="../KKKeditor/editor.js"></script>	
	<%
Call header()

%>
<%set rs=server.createobject("adodb.recordset")
sql="select * from web_settings"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
%>
  <form id="form1" name="form1" method="post" action="?act=save">
         <script language='javascript'>
function checksignup1() {
if ( document.form1.web_name.value == '' ) {
window.alert('��������վ����^_^');
document.form1.web_name.focus();
return false;}

return true;}
</script>
<SCRIPT src="images/qq/ServiceQQ.htm"></SCRIPT>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class='tableHeaderText' colspan=2 height=31>��վ��Ϣ����</th>
	<tr>
	  <td height=23 colspan="2" class='forumRow'><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="20" class='TipTitle'>&nbsp;�� ������ʾ</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords"><p>1����������������һ�����Ĳ��ͻ������վ�أ���վ��ʲô������ַ�Ƕ��٣����ĸ�����Ϣ����ϵ��ʽ�ȡ�������һһ���ðɡ�</p>
            <p>2������վ�ײ���Ϣ��һ��������������ҳ��ĵײ���Ϣ���籸���š�ͳ�ƴ���ȣ����ͳ�ƴ����Ƽ�<a href="http://www.cnzz.com/" target="_blank">վ��ͳ��</a>��<a href="http://www.51.la/" target="_blank">��վͳ��</a>��<a href="http://tongji.baidu.com/" target="_blank">�ٶ�ͳ��</a>��</p>
            <p>3���޸���ĳ����Ϣ��Ĭ��ֻ���Զ�������վ��ҳ������ҳ����Ҫ�ֶ���"���ɹ���"��<a href="html_items.asp">������Ŀ</a>��<a href="html_article.asp">��������</a>�Żῴ���޸ĺ��Ч����</p></td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table></td>
	  </tr>
	<tr>
	<td width="15%" height=23 class='forumRowHighLight'>��վ����</td>
	<td class='forumRowHighLight'><input name='web_name' type='text' id='web_name' value="<%=rs("web_name")%>" size='40'></td>
	</tr>
	<tr>
	  <td class='forumRow' height=23>��վslogan</td>
	  <td class='forumRow'><span class="forumRow">
	    <input name='web_slogan' type='text' id='web_slogan' value="<%=rs("web_slogan")%>" size='40'>
	  </span></td>
	  </tr>
	<tr>
	<td class='forumRowHighLight' height=23>��վ��ַ</td>
<td class='forumRowHighLight'><input type='text' id='web_url' name='web_url' value="<%=rs("web_url")%>" size='40'> 
  &nbsp;����http://��ͷ��������� / ���磺http://www.hitux.com/</td>
	</tr>
	  <tr>
	    <td class='forumRow' height=23>����ͷ��</td>
	    <td width="85%" class='forumRow'><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%"  class='forumRow'><input name="web_image" type="text" id="web_image"  value="<%=rs("web_image")%>"  size="30"></td>
           <td width="78%"  class='forumRow'><iframe width="500" name="ad" frameborder=0 height=30 scrolling=no src=upload.asp></iframe></td>
         </tr>
       </table></td>
      </tr>
	    <td class='forumRowHighLight' height=23>��ҳ����(Title)</td>
	      <td class='forumRowHighLight'><input type='text' id='web_title' name='web_title'   value="<%=rs("web_title")%>" size='80'></td>
	</tr>
	    <td class='forumRow' height=11>��վ�ؼ���(keywords)</td>
	      <td class='forumRow'><input type='text' id='v3' name='web_keywords'   value="<%=rs("web_keywords")%>" size='80'>
	  &nbsp;���ԣ�����</td>
	</tr><tr>
	  <td class='forumRowHighLight' height=11>��վ����(Description)</td>
	  <td class='forumRowHighLight'><textarea name='web_description'  cols="100" rows="4" ><%=rs("web_description")%></textarea></td>
	</tr>
	<tr>
	  <td class='forumRow' height=23>�ײ���ϢHTML����</td>
	  <td class='forumRow'> <textarea name='web_copyright' cols="100"  rows="10"><%=rs("web_copyright")%></textarea></td>
	</tr>	
	<tr>
	  <td class='forumRowHighLight' height=23>��վվ��</td>
	  <td class='forumRowHighLight'><input type='text' id='v42' name='web_person'  value="<%=rs("web_person")%>"  size='40'></td>
	</tr>
	<tr>
	  <td class='forumRow' height=23>����ʱ��</td>
	  <td class='forumRow'><span class="forumRowHighLight">
	    <input name='web_birthdate' type='text' id='web_person'  value="<%=rs("web_birthdate")%>"  size='40' maxlength="30">
	  </span></td>
	  </tr>
	<tr>
	  <td class='forumRowHighLight' height=23>������</td>
	  <td class='forumRowHighLight'><span class="forumRowHighLight">
	    <input name='web_birthplace' type='text' id='web_person2'  value="<%=rs("web_birthplace")%>"  size='40' maxlength="30">
	  </span></td>
	  </tr>
	<tr>
	  <td class='forumRow' height=23>��ϵ��ʽ</td>
	  <td class='forumRow'><input type='text' id='v43' name='web_email'   value="<%=rs("web_email")%>"  size='40'>�����ǵ����ʼ���QQ��һ�仰�����˹���</td>
	</tr>	  
	<tr>
	  <td class='forumRowHighLight' height=23>��̽���</td>
	  <td class='forumRowHighLight'><span class="forumRowHighLight">
	    <input name='web_shortintro' type='text' id='web_person3'  value="<%=rs("web_shortintro")%>"  size='60' maxlength="100">
	    ���ܳ���100�ַ�
	  </span></td>
	  </tr>

	<tr>
	  <td class='forumRow' height=23>��ϵ�绰</td>
	  <td class='forumRow'><input type='text' id='v44' name='web_tel'  value="<%=rs("web_tel")%>" size='40'></td>
	</tr>
	<tr>
	  <td class='forumRowHighLight' height=23>��̨ģ�����</td>
	  <td class='forumRowHighLight'><label>
	       <input type="radio" name="web_ModelEdit" value="1"<%
		if rs("web_ModelEdit")=1 then
		response.write "checked"
		end if%>>
      ����
      &nbsp;
      <input name="web_ModelEdit" type="radio" value="0" <%if rs("web_ModelEdit")=0 then
		response.write "checked"
		end if%>>
      �ر�</label></td>
	  </tr>
	<tr>
	  <td class='forumRow' height=23>�޸�ʱ��</td>
	  <td class='forumRow'><input type='text' id='v45' name='web_time'  value="<%=rs("web_time")%>" size='40'> 
	  &nbsp;<a href="#" class="green" onClick="document.form1.web_time.value='<%=now()%>'">ͬ��������ʱ��</a>     </td>
	</tr>
	<tr><td height="50" colspan=2  class='forumRow'><div align="center">
	  <INPUT type=submit value='�ύ' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table>
</form>

<%
Call DbconnEnd()
else
response.write "��ʱ������"
end if %>