<%--
  Created by Shavkat Begmatov.
  Date: 27.04.2023
  Time: 17:58
--%>
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

    String contract_code = request.getParameter("contract_code");
    String contract_type = request.getParameter("contract_type");

%>
<t:page>
    <t:form title="<%=si_form_title %>" minWidth="fill" minHeight="fill">
        <script>
            <%--alert("<%=contract_type%>");--%>
        </script>
        <iframe name="frm" style="display:none"></iframe>
        <form name="fm" target="frm">
            <input type="hidden" name="request" value="preview_update">
            <input type="hidden" name="contract_code" value="<%=contract_code%>">
            <div style="
        padding: 5px;
        margin-bottom: 10px;
        box-shadow: 0 5px 5px rgb(86,139,191);
        ">
                <table style=" margin-left: 25px;">
                    <col width="80%">
                    <col width="10%">
                    <col width="10%">
                    <tr>
                        <td>
                            <input type="submit" id="save"  name="save" value="<%=lang.get(si_btn_save)%>">
                        </td>
                        <td align="right">
                            <input onclick="window.close()" type="button" name="exit" value="<%=lang.get(si_btn_close)%>">
                        </td>
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
                                <td style="text-align: right;"><%= lang.get(si_contract_type)%>:</td>
                                <td>
                                    <input readonly name="contract_type" style="width:100%"  value="<%=contract_type%>" />
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
                String oResult;
                String contractCode = request.getParameter("contract_code");
            try {
                CallableStatement cs = conn.prepareCall("Call QQB_E_SHARTNOMA_SHAVKAT.addAdditionalContract(?,?)");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setString(2,  contractCode);
                cs.execute();
                oResult = cs.getString(1);
                %>
                alert("<%=oResult%>");
                parent.pageLock(false);
                top.returnValue={};
                //top.close();<%
            } catch (Exception ex) {%>
                alert('<%= Util.quotesEsc(ex.getMessage()) %>');
                parent.pageLock(false);
                //top.close();<%
            } finally {%>
                parent.pageLock(false);
                top.returnValue={};
                //top.close();<%
            }%>
        </script>
        <!--[if !IE]><!-->
        <script>
            try {
                var bc = new BroadcastChannel('preview:compiled');
                bc.postMessage('Refresh');
            }catch (e) {}
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
    static final int si_form_title 		    = SI("�������� �������������� �������","���� &#1179;&#1118;����� �������� &#1179;&#1118;���","","");
    static final int si_success 		    = SI("������� ���������!", "����������� �������&#1179;����� ��&#1179;�����!", "Ma`lumotlar muvaffaqiyatli saqlandi!", "Successfully");
    static final int si_exception 		    = SI("����������� ���������!");
    static final int si_btn_client_code     = SI("��� ������� (��������� ���)");
    static final int si_search_code 	    = SI("�������", "�����", "Search", "Qidirish");

    static final int si_field_title_1		= SI("����� � ���� ��������", "�������� ��&#1179;��� �� ������","","");
    static final int si_field_title_2		= SI("������ �����", "���� ����������","","");
    static final int si_field_title_3		= SI("��������� �����������", "�������� ������������","","");
    static final int si_field_title_4		= SI("��������� ��� (����)", "��� (����) ������������","","");

    static final int si_id              	= SI("��.","��.","","");
    static final int si_contract_number 	= SI("����� ��������","�������� ��&#1179;���","","");
    static final int si_contract_date   	= SI("���� ��������","�������� ������","","");
    static final int si_date_generate   	= SI("���� ��������� ��������","�������� ��������� &#1179;������� ��&#1179;�","","");
    static final int si_date_modify     	= SI("���� ����������� ��������","�������� &#1118;������������ ��&#1179;�","","");
    static final int si_filial_code     	= SI("��� �������","������ ����","","");
    static final int si_local_code     		= SI("��������� ���","����� ���","","");
    static final int si_branch_id    		= SI("������ ID","������ ID","","");
    static final int si_client_id       	= SI("��� �������","����� ����","","");
    static final int si_bxo_min_address 	= SI("�������� �����","&#1178;��&#1179;� ������","","");
    static final int si_date_ishonchnoma 	= SI("���� ������������","��������� ������","","");
    static final int si_number_ishonchnoma 	= SI("����� ������������","��������� ������","","");
    static final int si_bxo_manager 		= SI("�����������","���&#1179;������","","");
    static final int si_client_name			= SI("��� �����������","�������� ����","","");
    static final int si_client_manager		= SI("��������","��&#1203;���","","");
    static final int si_remote_services		= SI("������������� ������","��������� ���������","","");
    static final int si_sms_services		= SI("��� ������","��� �������","","");
    static final int si_bxo_address			= SI("�����","������","","");
    static final int si_client_address		= SI("����� �����������","�������� �������","","");
    static final int si_bxo_schet			= SI("��������� ����","&#1202;������&#1179;��","","");
    static final int si_client_schet		= SI("��������� ����","&#1202;������&#1179;��","","");
    static final int si_client_inn			= SI("���","���","","");
    static final int si_bxo_inn				= SI("���","���","","");
    static final int si_client_oked			= SI("����","����","","");
    static final int si_bxo_phone			= SI("���.","���.","","");
    static final int si_client_phone		= SI("���.","���.","","");
    static final int si_client_accountant	= SI("����.���.","��� ���������","","");
    static final int si_client_lawyer		= SI("�����","�����","","");
    static final int si_bxo_lawyer			= SI("�����","�����","","");
    static final int si_add_new				= SI("������� ����� �������","���� �������� ������","","");


    static final int si_bxo_name			= SI("�������� ���","��� ����","","");
    static final int si_bxo_oked			= SI("����","����","","");
    static final int si_bxo_accountant		= SI("����.���.","��� �������","","");
    static final int si_client_code			= SI("���������� ��� �������","����� ������ ����","","");
    static final int si_btn_update			= SI("��������","�������","","");
    static final int si_btn_save			= SI("��������/���������","��&#1179;���","","");
    static final int si_btn_close			= SI("�������","��&#1179;��","","");
    static final int si_contract_type		= SI("��� ��������","�������� ����","","");
//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>