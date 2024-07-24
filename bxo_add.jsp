<%@ page contentType="text/html;charset=windows-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
%><jsp:useBean id="util" class="iabs.oraUtil" scope="session"/><%
    Connection conn = cods.getConnection();
    if (conn == null || user.getUserCode() == null)
        pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
    Language lang = new Language(user.getLanguageIndex(), sentences);
    pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
//-------------------------------------------------------------------------------------------------

    String branch_id = "";//request.getParameter("branch_id");
    String ss1 = (String) session.getValue ("branch3");
    if (ss1 != null) {
        branch_id=ss1;
    }else branch_id="00000";
    String created_by = user.getUserCode();
    String begin_date = stored.execFunction("setup.get_operday");
    String user_name = stored.execFunction("setup.get_operday");


    String where_manager  = "branch_id='" +branch_id+ "' order by begin_date desc";
    String where_bxo_name = "branch_id='"+10892+"' order by begin_date desc";
//-------------------------------------------------------------------------------------------------
%><t:page><%
%><t:form title="<%= si_form_title %>" minHeight="fill" minWidth="fill">
<script>
    function bxoEmpAdd()
    {
        if (go({url:'bxo_emp_add.jsp', param:{branch_id: fm.branch_id.value}, target:'modalE', dialogWidth:700, dialogHeight:420}))
            go({});
    }
    function bxoEmpEdit()
    {
        if (go({url:'bxo_emp_edit.jsp', param:{
                id: getData(1),
                first_name: getData(2),
                last_name: getData(3),
                middle_name: getData(4),
                position: getData(5),
                date_ishonchnoma: getData(6),
                number_ishonchnoma: getData(7),
                emp_code: getData(8),
                created_by: getData(9),
                created_on: getData(10),
                begin_date: getData(11),
                end_date: getData(12)

            }, target:'modalE', dialogWidth:700, dialogHeight:400}))
            go({});
    }

    function bxoNameAdd()
    {
        if (go({url:'bxo_emp_add.jsp', param:{branch_id: fm.branch_id.value}, target:'modalE', dialogWidth:700, dialogHeight:420}))
            go({});
    }
    function bxoNameEdit()
    {
        if (go({url:'bxo_emp_edit.jsp', param:{
                id: getData(1),
                first_name: getData(2),
                last_name: getData(3),
                middle_name: getData(4),
                position: getData(5),
                date_ishonchnoma: getData(6),
                number_ishonchnoma: getData(7),
                emp_code: getData(8),
                created_by: getData(9),
                created_on: getData(10),
                begin_date: getData(11),
                end_date: getData(12)

            }, target:'modalE', dialogWidth:700, dialogHeight:400}))
            go({});
    }
</script>
<div id=basepanel>
    <iframe name=frm style="display:none"></iframe>
    <form name=fm target=frm>
        <input name=request type=hidden value=save>
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
                <td align="right"><%=lang.get(si_branch_id)%><span style="color: red;"> *</span></td>
                <td>
                    <input name="branch_id" mask={5|0-9}
                           size=5 maxLength=8 r=1
                           reference="{name: 'filials', put: [fm.branch_id, fm.bxo_name2]}"
                           request="{name: 'branch2', get: {filial_code: fm.branch_id}, put: [fm.bxo_name2]}"
                           >
                    <input name="bxo_name2" size=35 readonly tabindex=-1>
                    <code>(F9)</code>
                </td>
            </tr>
<%--            <tr>--%>
<%--                <td align="right"><%=lang.get(si_bxo_name)%></td>--%>
<%--                <td>--%>
<%--                    <div style="display:flex">--%>
<%--                        <select name="bxo_name">--%>
<%--                            <options></options>--%>
<%--                            <t:options from="QQB_E_SHARTNOMA_BXO_NAME_V" code="id" name="bxo_name" where="<%= where_bxo_name %>"/>--%>
<%--                        </select>--%>
<%--                        <input id="bxo_name_add"  type="button" value="<%= lang.get(si_bxo_name_add) %>"  onclick="bxoNameAdd()">--%>
<%--                        <input id="bxo_name_edit" type="button" value="<%= lang.get(si_bxo_name_edit) %>" onclick="bxoNameEdit()">--%>
<%--                    </div>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td align="right"><%=lang.get(si_bxo_min_address)%></td>--%>
<%--                <td><input name="bxo_min_address" type="text" size="40" style="width:100%"></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td align="right"><%=lang.get(si_bxo_address)%></td>--%>
<%--                <td><input name="bxo_address" type="text" size="40" style="width:100%"></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td align="right"><%=lang.get(si_bxo_manager)%></td>--%>
<%--                <td>--%>
<%--                    <input id="bxo_emp_add" type="button" value="<%= lang.get(si_bxo_emp_add) %>" onclick="bxoEmpAdd()">--%>
<%--                    <select name="bxo_manager_emp_code" >--%>
<%--                        <options selected=""></options>--%>
<%--                        <t:options from="QQB_E_SHARTNOMA_BXO_EMP_V" code="emp_code" name="full_name" where="<%= where_manager %>"/>--%>

<%--                    </select>--%>
<%--                    <input id="bxo_emp_edit" type="button" value="<%= lang.get(si_bxo_emp_edit) %>" onclick="bxoEmpEdit()">--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td align="right"><%=lang.get(si_bxo_accountant)%></td>--%>
<%--                <td><input name="bxo_accountant" type="text" size="40" style="width:100%"></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td align="right"><%=lang.get(si_bxo_lawyer)%></td>--%>
<%--                <td><input name="bxo_lawyer" type="text" size="40" style="width:100%"></td>--%>
<%--            </tr>--%>
            <tr>
                <td align="right"><%=lang.get(si_begin_date)%><span style="color: red;"> *</span></td>
                <td>
                    <input name="begin_date" mask='date' size="12"  value="<%=begin_date%>">
                    <code>(DD.MM.YYYY)</code>
                </td>
            </tr>
            <tr>
                <td align="right"><%=lang.get(si_created_by)%></td>
                <td><input name="created_by" type="text" size="40"  value="<%=created_by%>" readonly style="width:100%"></td>
            </tr>
        </table>
    </form>
</div>
</t:form>
</t:page>
<t:references>
    <%
        String iWhere = "condition='A' and HEADER_CODE="+user.getHeaderCode();
    %>
    <t:reference name="filials" >
        <t:table from="BANK_DESC_QQB" >
            <t:field id="1" name="branch_id_new" label="<%=si_filial_code%>" >
                <t:filter operator="_search" mask="5|0-9" showInGrid="" />
            </t:field>
            <t:field id="2" name="name_new" label="<%=si_filial_name%>" type="quote" />
            <t:grid hideFilterButton="" page="" >
                <t:column for="1" align="left" />
                <t:column for="2" align="left" />
            </t:grid>
        </t:table>
    </t:reference>
</t:references>

<t:requests>
    <t:request name="save"><script><%
        response.setContentType("text/html;charset=WINDOWS-1251");
        OracleCallableStatement cs = null;
        String query = "";
        String mBaranchId = "1";
        String mBxoName = "1";
        String mMinAddress = "1";
        String mAddress = "1";
        String mManager = "1";
        String mAccountant = "1";
        String mLawyer = "1";
        try {
            query = "{call QQB_E_SHARTNOMA_SHAVKAT.addBXO(?,?,?)}";
            cs = (OracleCallableStatement) conn.prepareCall(query);
            // cs.setString(1,cods.ConvIso(request.getParameter("name")));
            cs.registerOutParameter(1,Types.VARCHAR);
            cs.setString(2, request.getParameter("branch_id"));
            cs.setString(3, cods.ConvIso(request.getParameter("bxo_name2")));
            /*
            cs.setString(4, request.getParameter("bxo_min_address"));
            cs.setString(5, request.getParameter("bxo_address"));
            cs.setString(6, request.getParameter("bxo_manager_emp_code"));
            cs.setString(7, request.getParameter("bxo_accountant"));
            cs.setString(8, request.getParameter("bxo_lawyer"));
            cs.setString(9,request.getParameter("begin_date"));
            cs.setString(10,request.getParameter("created_by"));
            cs.setString(11,request.getParameter("created_on"));
            */
            cs.execute();
            if (cs.getString(1).equals("OK")){%>
                alert("<%=cods.fixEnter(cs.getString(1))%>");parent.pageLock(false);top.returnValue={};top.close();<%
            } else {%>
                alert("<%=lang.get(si_error)%>");parent.pageLock(false);top.returnValue={};<%
            }
        } catch (Exception ex) {
            %>alert('<%= Util.quotesEsc(ex.getMessage()) %>');parent.pageLock(false);<%
        } finally {
            cs.close();
        }%></script>

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
    
    <t:request name="branch">
        <%
            String bankCode = request.getParameter("filial_code");
            %><script>alert('<%=bankCode%>')</script><%
            if (bankCode == "")	{
                bankCode = user.getFilialCode();
            }
            %><script>alert('<%=bankCode%>')</script><%
            try {
                String bankName = stored.execFunction("Bank.Get_Bank_Name('" + bankCode + "','Y')");
                out.print("['"+Util.quotesEsc(bankName)+"']");
            } catch (Exception ex) {
                response.setHeader("RT", "alert");
                out.print(ex.getMessage());
            }
        %>
    </t:request>
    <t:request name="branch2"><%
        try {
            ServletCallableStatement cs = new ServletCallableStatement(stored, request);
            cs.setFunction("QQB_E_SHARTNOMA_SHAVKAT.getBranchInfo");
            cs.setStringParameter("iBranchId","filial_code");
            session.putValue("branch3", request.getParameter("branch_id"));
            cs.execute();
            JArray result = new JArray();
            result.push(cs.getStringResult());
            out.print(result);
        } catch(Exception ex) {
            response.setHeader("RT", "error");
            out.print(Util.getUserMessage(ex));
        }
    %></t:request>
</t:requests>
<%!
    static final int si_form_title      = SI("Янги БХО &#1179;ўшиш");
    static final int si_save            = SI("Са&#1179;лаш");
    static final int si_error           = SI("Кўрсаткич номи мавжуд!!!");

    static final int si_branch_id       = SI("Branch ID", "Branch ID");
    static final int si_bxo_name        = SI("Название филиала", "Филиал номи");
    static final int si_bxo_min_address = SI("Кор. адрес", "Мин. манзил");
    static final int si_bxo_address     = SI("Адрес", "Манзил");
    static final int si_bxo_manager     = SI("Управляющий", "Бош&#1179;арувчи");
    static final int si_bxo_accountant  = SI("Глав. бухгалтер", "Бош &#1203;исобчи");
    static final int si_bxo_lawyer      = SI("Юрист", "Юрист");

    static final int si_created_by      = SI("Кем изменено", "Ўзгартирган ходим");
    static final int si_created_on      = SI("Дата создание", "Яратилган сана");
    static final int si_begin_date      = SI("Дата активации", "Фаоллашган сана");

    static final int si_bxo_emp_add     = SI("+");
    static final int si_bxo_emp_edit    = SI("/");

    static final int si_bxo_name_add    = SI("+");
    static final int si_bxo_name_edit   = SI("/");

    static final int si_filial_name		= SI("Наименование филиала");
    static final int si_filial_code		= SI("Код филиала");


    static final int si_name            = SI("Номи:");
    static final int si_type            = SI("Либор/Еврибор кўрсаткичи:");
//-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>
