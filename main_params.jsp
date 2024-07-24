<%@ page contentType="text/html;charset=WINDOWS-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/><%
    Connection conn = cods.getConnection();
    if (conn == null || user.getUserCode() == null)
        pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
    Language lang = new Language(user.getLanguageIndex(), sentences);
    pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
    try
    {storedObj.setConnection(conn, "50615");}
    catch (Exception e)
    {Util.alertUserMessage(e, out);}
//-------------------------------------------------------------------------------------------------
%><t:page><%
%><t:form title="<%=si_form_title%>" minWidth="fill" minHeight="fill">

<style>
    iframe {
        border-width: 0 !important;
    }
</style>
<script>
    function onLoad() {
        go({url:'bxo_list.jsp', target:bxo_list, lock:false});
    }

    function onSelect(id) {
        // go({url:'bxo_list.jsp?branch_id='+id,               target:bxo_list,            lock:false});
        go({url:'bxo_name_list.jsp?branch_id='+id,          target:bxo_name_list,       lock:false});
        go({url:'bxo_address_list.jsp?branch_id='+id,       target:bxo_address_list,    lock:false});
        go({url:'bxo_emp_list.jsp?branch_id='+id,           target:bxo_emp_list,        lock:false});
        // go({url:'bxo_accountant_list.jsp?branch_id='+id,    target:bxo_accountant_list, lock:false});
        // go({url:'bxo_lawyers.jsp?branch_id='+id,            target:bxo_lawyers,         lock:false});

    }
</script>
<iframe name=frm style="display:none"></iframe>
    <table width="100%" class=formToolbar cellspacing=2>
        <tr>
            <td align=right id=tableControls>
                <input
                        type=button
                        onclick="top.close()"
                        onclick2="go({url:'/ibs/zv_new/e-shartnoma/index.jsp'})"
                        value="<%= lang.get(si_exit_button)%>"
                        style="background-color: #A30000 !important;"
                >
            </td>
        </tr>
    </table>
<div id=basepanel>
<table width=100% height=100% id=tbl style="border:0">
  <col width=35% >
  <col width=65% >
    <tr>
        <td height=100% style="vertical-align: top;">
            <iframe width=100% height=100% name=bxo_list></iframe>
        </td>
        <td height=100% style="vertical-align: top;">
            <div style="/*overflow: scroll;*/">
                <div style="height: 280px;">
                    <iframe width=100% height=100% name=bxo_name_list></iframe>
                </div>
                <div style="height: 280px;">
                    <iframe width=100% height=100% name=bxo_address_list></iframe>
                </div>
                <div style="height: 280px;">
                    <iframe width=100% height=100% name=bxo_emp_list></iframe>
                </div>
<%--                <div style="height: 300px;">--%>
<%--                    <iframe width=100% height=100% name=bxo_accountant_list></iframe>--%>
<%--                </div>--%>
<%--                <div style="height: 300px;">--%>
<%--                    <iframe width=100% height=100% name=bxo_lawyers></iframe>--%>
<%--                </div>--%>
            </div>
        </td>
    </tr>
</table>
</div>
</t:form>
</t:page>
<%!
static final int si_form_title  = SI("Параметры договора", "Шартнома параметрлари", "", "");
static final int si_exit_button = SI("Закрыть", "Ёпиш", "", "");
//-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>