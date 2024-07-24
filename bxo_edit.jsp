<%@ page contentType="text/html;charset=windows-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
	response.setContentType("text/html;charset=WINDOWS-1251");
    Connection conn = cods.getConnection();
    if (conn == null || user.getUserCode() == null)
        pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
    Language lang = new Language(user.getLanguageIndex(), sentences);
    pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
    Statement stmt = conn.createStatement();
    ResultSet rset;

//    Util.encodeISO(Util.nvl(
//    response.setContentType("text/html;charset=WINDOWS-1251");
    String id                   =   request.getParameter("id");
    String branch_id            =   request.getParameter("branch_id");
    String bxo_name_id          =   Util.encodeISO(Util.nvl(request.getParameter("bxo_name_id")));
    String bxo_min_address_id   =   Util.encodeISO(Util.nvl(request.getParameter("bxo_min_address_id")));
    String bxo_address_id       =   Util.encodeISO(Util.nvl(request.getParameter("bxo_address_id")));
    String bxo_manager_id       =   Util.encodeISO(Util.nvl(request.getParameter("bxo_manager_id")));
    String bxo_accountant_id    =   Util.encodeISO(Util.nvl(request.getParameter("bxo_accountant_id")));
    String bxo_lawyer_id        =   Util.encodeISO(Util.nvl(request.getParameter("bxo_lawyer_id")));

    String querys    = "select code_type, name_type, name from qqb_hl_indexes_v  where id = '"+id+"'";
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
                <td align="right"><%=lang.get(si_barnch_id)%>:</td>
                <td><input name="branch_id" type="text" size="40" value="<%=branch_id%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_bxo_name)%>:</td>
                    <select name="bxo_name" >
                        <t:options from="QQB_E_SHARTNOMA_BXO_V" code="id" name="bxo_name" where="1=1 order by id"/>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_bxo_min_address)%>:</td>
                <td><input name="bxo_min_address" type="text" size="40" value="<%=bxo_min_address_id%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_bxo_address)%>:</td>
                <td><input name="bxo_address" type="text" size="40" value="<%=cods.fixEnter(bxo_address_id)%>" style="width:100%"></td>
                    <%--                <input name="proc" mask="number(5,2)" size="24">--%>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_bxo_manager)%>:</td>
                <td>
                    <select name="bxo_manager" >
                        <t:options from="QQB_E_SHARTNOMA_BXO_V" code="id" name="bxo_manager" where="1=1 order by id"/>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_bxo_accountant)%>:</td>
                <td><input name="bxo_accountant" type="text" size="40" value="<%=bxo_accountant_id%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_bxo_lawyer)%>:</td>
                <td><input name="bxo_lawyer" type="text" size="40" value="<%=bxo_lawyer_id%>" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_begin_date)%>:</td>
                <td><input name="begin_date" type="text" size="40" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_created_by)%>:</td>
                <td><input name="created_by" type="text" size="40" style="width:100%"></td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_created_on)%>:</td>
                <td><input name="created_on" type="text" size="40" style="width:100%"></td>
            </tr>
        </table>
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
  try {
      query = "{ call QQB_E_SHARTNOMA_SHAVKAT.editBxo(?,?,?,?,?,?,?,?,?)}";
      cs = (OracleCallableStatement) conn.prepareCall(query);
      // cs.setString(1,cods.ConvIso(request.getParameter("name")));
      cs.registerOutParameter(1,Types.VARCHAR);
      cs.setString(2, request.getParameter("branch_id"));
      cs.setString(3, request.getParameter("bxo_name"));
      cs.setString(4, request.getParameter("bxo_min_address"));
      cs.setString(5, request.getParameter("bxo_address"));
      cs.setString(6, request.getParameter("bxo_manager"));
      cs.setString(7, request.getParameter("bxo_accountant"));
      cs.setString(8, request.getParameter("bxo_lawyer"));
      cs.setString(9, request.getParameter("id"));
      cs.execute();
      if (cs.getString(1).equals("OK")){%>
        alert("<%=cods.fixEnter(cs.getString(1))%>");parent.pageLock(false);top.returnValue={};console.log(parent);top.close();<%
      } else {%>
        alert("<%=cods.fixEnter(cs.getString(1))%>" + " \n" + "<%=lang.get(si_error)%>"); parent.pageLock(false);top.returnValue={};top.close();<%}
  } catch (Exception ex) {
      %>alert('<%= Util.quotesEsc(ex.getMessage()) %>');parent.pageLock(false);<%
  } finally {
      cs.close();
  }
%></script>
</t:request>

</t:requests>

<%!
    static final int si_form_title          = SI("БХО параметрларини ўзгартириш");
    static final int si_save                = SI("Са&#1179;лаш");
    static final int si_error               = SI("Хатолик");

    static final int si_barnch_id           = SI("Филиал коди");
    static final int si_bxo_name            = SI("Филиал номи");
    static final int si_bxo_min_address     = SI("Филиал ихчам манзили");
    static final int si_bxo_address         = SI("Филиал манзили");
    static final int si_bxo_manager         = SI("Филиал бош&#1179;арувчиси");
    static final int si_bxo_accountant      = SI("Филиал бош бухгалтери");
    static final int si_bxo_lawyer          = SI("Филиал юристи");

    static final int si_created_by          = SI("Кем изменено", "Ўзгартирган ходим");
    static final int si_created_on          = SI("Дата создание", "Яратилган сана");
    static final int si_begin_date          = SI("Дата активации", "Фаоллашган сана");
//-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>
