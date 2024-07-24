<%@ page contentType="text/html;charset=windows-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*, java.text.SimpleDateFormat, java.util.Date" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
    Connection conn = cods.getConnection();
    if (conn == null || user.getUserCode() == null)
        pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);

    //response.setContentType("text/html;charset=WINDOWS-1251");
    //response.setContentType("application/json;charset=WINDOWS-1251");

    Language lang = new Language(user.getLanguageIndex(), sentences);
    pageContext.setAttribute(Resource.STR_LANGUAGE, lang);

    //response.setContentType("text/html; charset=windows-1251");

    request.setCharacterEncoding("WINDOWS-1251");

    Statement stmt = conn.createStatement();
    ResultSet rset;



    String branch_id = request.getParameter("branch_id");

    String id           = request.getParameter("id");
    String first_name   = request.getParameter("first_name");
    String last_name    = request.getParameter("last_name");
    String middle_name  = request.getParameter("middle_name");
    String position     = request.getParameter("position");
    String date_ishonchnoma   = request.getParameter("date_ishonchnoma");
    String number_ishonchnoma = request.getParameter("number_ishonchnoma");
    String emp_code     = request.getParameter("emp_code");
    String created_by   = request.getParameter("created_by");
    String created_on   = request.getParameter("created_on");
    String begin_date   = request.getParameter("begin_date");
    String end_date     = request.getParameter("end_date");

    String querys    = "select to_char(begin_date,'dd.mm.yyyy'), to_char(end_date,'dd.mm.yyyy'), procent from qqb_hl_index_info_v where id = '"+id+"'";
//-------------------------------------------------------------------------------------------------
%><t:page><%
%><t:form title="<%= si_form_title %>" minHeight="fill" minWidth="fill">
<script>
</script>
<div id=basepanel>
    <iframe name=frm style="display:none"></iframe>
    <form name=fm target="frm">
        <input name=request type=hidden value=save>
        <input name="id" type="hidden" value="<%=id%>">
        <table width=100% align=center class=formToolbar cellpadding=0>
             <tr>
                 <td>
                     <input id=btnAuthorization type=submit value="<%= lang.get(si_save) %>">
                 </td>
             </tr>
        </table>
        <table width="100%" border="0">
            <colgroup>
                <col width="25%"/>
                <col width="75%"/>
            </colgroup>
            <tr>
                <td align="right"><%=lang.get(si_emp_code)%>:</td>
                <td><input name="emp_code" size="40" value="<%=emp_code%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_first_name)%>:</td>
                <td><input name="first_name" type="text" size="40" value="<%=first_name%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_last_name)%>:</td>
                <td><input name="last_name" type="text" size="40" value="<%=last_name%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_middle_name)%>:</td>
                <td><input name="middle_name" type="text" size="40" value="<%=middle_name%>" style="width:100%"></td>
                    <%--                <input name="proc" mask="number(5,2)" size="24">--%>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_begin_date)%>:</td>
                <td><input name="begin_date" type="text" size="40" value="<%=begin_date%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_end_date)%>:</td>
                <td><input name="end_date" type="text" size="40" value="<%=end_date%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_position)%>:</td>
                <td><input name="position" type="text" size="40" value="<%=position%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_date_ishonchnoma)%>:</td>
                <td><input name="date_ishonchnoma" type="text" size="40" value="<%=date_ishonchnoma%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_number_ishonchnoma)%>:</td>
                <td><input name="number_ishonchnoma" type="text" size="40" value="<%=number_ishonchnoma%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_created_by)%>:</td>
                <td><input name="created_by" type="text" size="40" value="<%=created_by%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_created_on)%>:</td>
                <td><input name="created_on" type="text" size="40" value="<%=created_on%>" style="width:100%"></td>
            </tr>
        </table>
<%--    <%rset.close();--%>
<%--        stmt.close();}%>--%>
</form>
</div>
</t:form>
</t:page>
<t:requests>
<t:request name="save">
<script><%
  response.setContentType("text/html;charset=WINDOWS-1251");
  OracleCallableStatement cs = null;
  String query = "";
  String sDate1 = "04.02.2023";
  Date date1 = new SimpleDateFormat("dd.MM.yyyy").parse(sDate1);

  try {
      query = "{call QQB_E_SHARTNOMA_SHAVKAT.editBxoEmp(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
      cs = (OracleCallableStatement) conn.prepareCall(query);
      cs.registerOutParameter(1,Types.VARCHAR);
      cs.setString(2,"first_name");
      cs.setString(3,"last_name");
      cs.setString(4,"middle_name");
      cs.setString(5,"1");
      cs.setString(6,"04.02.2023");
      cs.setString(7,"123");
      cs.setString(8,"12344");
      cs.setString(9,"12345");
      cs.setString(10,sDate1);
      cs.setString(11,sDate1);
      cs.setString(12,sDate1);
      cs.setString(13, id);
      cs.execute();
      if (cs.getString(1).equals("OK")){%>
        alert("<%=cods.fixEnter(cs.getString(1))%>");parent.pageLock(false);top.returnValue={};top.close();<%
      } else {%>
        alert("<%=cods.fixEnter(cs.getString(1))%>" + "<%=lang.get(si_error)%>");parent.pageLock(false);top.returnValue={};top.close();<%}
  } catch (Exception ex) {
      %>alert("<%=cods.fixEnter(cs.getString(1))%>" + '<%=request.getParameter("emp_code")%>' + '\n' + '5555 \n' + '<%= Util.quotesEsc(ex.getMessage()) %>');parent.pageLock(false);<%
  } finally {
      cs.close();
  }
  %></script>
</t:request>
</t:requests>
<%!
    static final int si_form_title       = SI("Ходим маълумотларини ўзгартириш");
    static final int si_save             = SI("Са&#1179;лаш");

    static final int si_id = SI("ID");
    static final int si_first_name = SI("Имя");
    static final int si_last_name = SI("Фамилия");
    static final int si_middle_name = SI("Отчество");
    static final int si_position = SI("Позиция");
    static final int si_date_ishonchnoma = SI("Дата доверенности");
    static final int si_number_ishonchnoma = SI("Номер доверенности");
    static final int si_emp_code = SI("Код сотрудника2");
    static final int si_created_by = SI("Кто создаль запись");
    static final int si_created_on = SI("Дата создание запись");
    static final int si_begin_date = SI("Дата начала работы");
    static final int si_end_date = SI("Дата увольнения");

    static final int si_proc             = SI("Фоиз ставкаси:");
    static final int si_error            = SI("Хатолик!!!");
//-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>
