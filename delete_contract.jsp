<%--
  Created by Shavkat Begmatov.
  Date: 04.05.2023
  Time: 12:24
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page contentType="text/html;charset=WINDOWS-1251" language="java" %>
<%@ taglib uri="/WEB-INF/cms.tld" prefix="t" %>

<%@ page import="java.sql.*" %>
<%@ page import="uz.fido_biznes.cms.*" %>
<%@ page import="java.util.*" %>
<%@ page import="uz.fido_biznes.sql.Direction" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="oracle.jdbc.*" %>
<%@ page import="iabs.oraDBConnection" %>

<jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session"/>
<jsp:useBean id="user" class="iabs.User" scope="session"/>
<jsp:useBean id="util" class="iabs.oraUtil" scope="session"/>
<jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/>
<jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/>
<%
    Connection conn = cods.getConnection();
    if (conn == null || user.getUserCode() == null)
        pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
    Language lang = new Language(user.getLanguageIndex(), sentences);
    pageContext.setAttribute(Resource.STR_LANGUAGE, lang);

    request.setCharacterEncoding("WINDOWS-1251");

    String id                       = request.getParameter("id");
    String contract_type            = request.getParameter("contract_type");
    String contract_number          = request.getParameter("contract_number");

    String contract_date            = request.getParameter("contract_date");
    String bxo_name                 = request.getParameter("bxo_name");

    String client_name              = request.getParameter("client_name");


%>
<t:page>
    <style>
        .mytitle {
            font-family: "Arial narrow", Arial, Helvetica, Geneva, sans-serif;
            font-size: 2em;
        }
        .main-contract-color {
            color: #0d6efd;
        }
        .additional-contract-color {
            color: darkgreen;
        }
    </style>
    <t:form title="<%=si_form_title %>" minWidth="fill" minHeight="fill">
        <script>

        </script>
        <iframe name="frm" style="display:none"></iframe>
        <form name="fm" target="frm">
            <input type="hidden" name="request" value="preview_update">
            <input type="hidden" name="contract_id" value="<%=id%>">
            <input type="hidden" name="contract_type" value="<%=contract_type%>">
            <div style="
				padding: 5px;
				margin-bottom: 10px;
				box-shadow: 0 5px 5px rgb(86,139,191);
			">
                <table style=" margin-left:25px; width:85%;">
                    <col width="15%">
                    <col width="15%">
                    <col width="170%">
                    <tr>
                        <td>
                            <input type="submit" id="save"  name="save" value="<%=lang.get(si_btn_delete)%>">
                        </td>
                        <td>
                            <input onclick="window.close()" type="button" name="exit" value="<%=lang.get(si_btn_exit)%>">
                        </td>
                        <% if(contract_type.equals("M")) { %>
                        <td align="right">
                            <span class="mytitle main-contract-color"><%=lang.get(si_contract_main)%></span>
                        </td>
                        <% } else { %>
                        <td align="right">
                            <span class="mytitle additional-contract-color"><%=lang.get(si_contract_additional)%></span>
                        </td>
                        <% } %>
                    </tr>
                </table>
            </div>
            <div id="basepanel" class=panel>
                <div id="main">
                    <fieldset><legend><%= lang.get(si_field_title_1)%>:</legend>
                        <table cellpadding="2" cellspacing="2" style="padding: 15px !important; border-collapse: separate !important; width:100%;">
                            <col text-align="right" width="16%" style="font-weight:bolder; text-align:right;" />
                            <col width="10%" />
                            <col text-align="right" width="16%" style="font-weight:bolder" />
                            <col width="10%" style="font-weight:bolder" />
                            <col text-align="right" width="16%" />
                            <col width="32%" style="font-weight:bolder" />
                            <tr>
                                <td style="text-align: right;"><%= lang.get(si_contract_number)%>:</td>
                                <td>
                                    <input readonly name="contract_number" style="width:100%"  value="<%=contract_number%>" />
                                </td>
                                <td style="text-align: right;"><%= lang.get(si_contract_date)%>:</td>
                                <td>
                                    <input name="contract_date" style="width:100%" readOnly value="<%=contract_date%>" />
                                </td>
                                <td style="text-align: right;"><%= lang.get(si_bxo_name)%>:</td>
                                <td>
                                    <input name="bxo_name" style="width:100%" readOnly value="<%=bxo_name%>" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;"><%= lang.get(si_client_name)%>:</td>
                                <td colspan="5">
                                    <input readonly name="contract_number" style="width:100%"  value="<%=client_name%>" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
        </form>
    </t:form>
</t:page>
<t:requests>
    <t:request name="preview_update">
        <script><%
            String oResult = "Test3";
            String contractId = request.getParameter("contract_id");
            String contractType = request.getParameter("contract_type");
            %>
                //alert("<%=contractId%>");
                //alert("<%=contractType%>");
            <%
            try {
                CallableStatement cs = conn.prepareCall("Call QQB_E_SHARTNOMA_SHAVKAT.deleteContractById(?,?,?)");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setString(2,  contractId);
                cs.setString(3,  contractType);
                cs.execute();
                oResult = cs.getString(1); %>
                parent.pageLock(false);
                top.returnValue={};<%
            } catch (Exception ex) {%>
                alert("<%= Util.quotesEsc(ex.getMessage()) %>");
                parent.pageLock(false);<%
            } finally {%>
                alert("<%=oResult%>");
                parent.pageLock(false);
                top.returnValue={};<%
            }%>
        </script>
        <!--[if !IE]><!-->
        <script>
            try {
                var bc = new BroadcastChannel('preview:compiled');
                bc.postMessage('Refresh');
            } catch (e) {}
        </script>
        <![endif]-->
        <script>
            top.close();
            top.returnValue = 'R';
            parent.pageLock(false);
        </script>
    </t:request>
</t:requests>
<%!
    static final int si_form_title 		    = SI("Удалить доп. договор","&#1178;&#1118;шимча шартномани ўчириш","","");
    static final int si_btn_delete 		    = SI("Удалить","&#1038;чириш","","");
    static final int si_btn_exit			= SI("Закрыть","Чи&#1179;иш","","");

    static final int si_contract_main		= SI("Первоначальный договор","Дастлабки шартнома","Dastlabki shartnoma","");
    static final int si_contract_additional	= SI("Дополнительный договор","&#1178;&#1118;шимча шартнома","Qo'shimcha shartnoma","");
    static final int si_field_title_1		= SI("Номер и дата договора", "Шартнома ра&#1179;ами ва санаси","","");
    static final int si_contract_number 	= SI("Номер договора","Шартнома ра&#1179;ами","","");

    static final int si_client_name			= SI("Имя организации","Ташкилот номи","","");

    static final int si_contract_date   	= SI("Дата договора","Шартнома санаси","","");
    static final int si_bxo_name			= SI("Название БХО","БХО номи","","");



//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>