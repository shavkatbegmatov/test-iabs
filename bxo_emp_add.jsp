<%@ page contentType="text/html;charset=windows-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
    Connection conn = cods.getConnection();
    if (conn == null || user.getUserCode() == null)
        pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
    Language lang = new Language(user.getLanguageIndex(), sentences);
    pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
//-------------------------------------------------------------------------------------------------
    String branch_id    = request.getParameter("branch_id");
    String created_by   = user.getUserCode();
    String begin_date   = stored.execFunction("setup.get_operday");
    String bxo_name     = stored.execFunction("QQB_E_SHARTNOMA_SHAVKAT.getCurrentBxoName("+branch_id+")");
//-------------------------------------------------------------------------------------------------
%><t:page>
    <style>
        .hide {
            display: none;
        }
    </style>
    <script>
        function changeEmpPosition(iID) {
            var e1 = document.getElementById("date_ishonchnoma");
            var e2 = document.getElementById("number_ishonchnoma");
            if (iID === '1' || iID === '2') {

                e1.classList ? e1.classList.remove('hide') : e1.className += '';
                e2.classList ? e2.classList.remove('hide') : e2.className += '';
            } else {
                e1.classList ? e1.classList.add('hide') : e1.className += ' hide';
                e2.classList ? e2.classList.add('hide') : e2.className += ' hide';
            }
        }
    </script>
<t:form title="<%= si_form_title %>" minHeight="fill" minWidth="fill">
    <script>
    </script>
    <div id=basepanel>
        <iframe name=frm style="display:none"></iframe>
        <form name=fm target=frm>
            <input name=request type=hidden value=save>
            <input type=hidden name=branch_id value=<%=branch_id%>>
            <table width=100% align=center class=formToolbar cellpadding=0>
                <tr>
                    <td>
                        <input id=btnAuthorization type=submit value="<%= lang.get(si_btn_save) %>">
                    </td>
                </tr>
            </table>
            <table width="100%" border="0">
                <colgroup>
                    <col width="25%"/>
                    <col width="75%"/>
                </colgroup>
                <tr>
                    <td align="right"><%=lang.get(si_branch_id)%></td>
                    <td>
                        <input name="branch_id" type="text" size="5"  value="<%=branch_id%>" readonly />
                        <input name="bxo_name"  type="text" size="40" value="<%=bxo_name%>"  readonly />
                    </td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_position)%><span style="color: red;"> *</span></td>
                    <td>
                        <select r="1" name="position" onchange="changeEmpPosition(this.value)">
                            <option value="0"></option>
                            <t:options from="QQB_E_SHARTNOMA_BXO_EMP_POSITION_T" code="pos_code" name="pos_name" where="1=1 order by id"/>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_emp_code)%><span style="color: red;"> *</span></td>
                    <td><input r="1" name="emp_code" type="text" size="40" style="width:100%"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_first_name)%><span style="color: red;"> *</span></td>
                    <td><input r="1" name="first_name" type="text" size="40" style="width:100%"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_last_name)%><span style="color: red;"> *</span></td>
                    <td><input r="1" name="last_name" type="text" size="40" style="width:100%"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_middle_name)%><span style="color: red;"> *</span></td>
                    <td><input r="1" name="middle_name" type="text" size="40" style="width:100%"></td>
                        <%--                <input name="proc" mask="number(5,2)" size="24">--%>
                </tr>
<%--                <tr>--%>
<%--                    <td align="right"><%=lang.get(si_end_date)%></td>--%>
<%--                    <td><input name="end_date" type="text" size="40" style="width:100%"></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td align="right"><%=lang.get(si_position)%>:</td>--%>
<%--                    <td><input name="position" type="text" size="40" style="width:100%"></td>--%>
<%--                </tr>--%>
                <tr class="hide" id="date_ishonchnoma">
                    <td align="right"><%=lang.get(si_date_ishonchnoma)%><span style="color: red;"> *</span></td>
                    <td><input name="date_ishonchnoma" type="text" size="40" style="width:100%"></td>
                </tr>
                <tr class="hide" id="number_ishonchnoma">
                    <td align="right"><%=lang.get(si_number_ishonchnoma)%><span style="color: red;"> *</span></td>
                    <td><input name="number_ishonchnoma" type="text" size="40" style="width:100%"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_begin_date)%><span style="color: red;"> *</span></td>
                    <td><input r="1" name="begin_date" mask='date' size="12"  value="<%=begin_date%>"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_created_by)%>:</td>
                    <td><input name="created_by" type="text" size="40"  value="<%=created_by%>" readonly style="width:100%"></td>
                </tr>
<%--                <tr>--%>
<%--                    <td align="right"><%=lang.get(si_created_on)%>:</td>--%>
<%--                    <td><input name="created_on" type="text" size="40" style="width:100%"></td>--%>
<%--                </tr>--%>
            </table>
        </form>
    </div>
</t:form>
</t:page>
<t:requests>
    <t:request name="save"><script><%
          response.setContentType("text/html;charset=WINDOWS-1251");
          OracleCallableStatement cs = null;
          String query = "";
          try {
              query = "{call QQB_E_SHARTNOMA_SHAVKAT.addBxoEmp(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
              cs = (OracleCallableStatement) conn.prepareCall(query);
              cs.registerOutParameter(1,Types.VARCHAR);
              cs.setString(2,cods.ConvIso(request.getParameter("first_name")));
              cs.setString(3,cods.ConvIso(request.getParameter("last_name")));
              cs.setString(4,cods.ConvIso(request.getParameter("middle_name")));
              cs.setString(5,request.getParameter("position"));
              cs.setString(6,request.getParameter("date_ishonchnoma"));
              cs.setString(7,request.getParameter("number_ishonchnoma"));
              cs.setInt(8,Integer.parseInt(request.getParameter("emp_code")));
              cs.setString(9,request.getParameter("created_by"));
              cs.setString(10,request.getParameter("created_on"));
              cs.setString(11,request.getParameter("begin_date"));
              cs.setString(12,request.getParameter("end_date"));
              cs.setString(13,request.getParameter("branch_id"));
              cs.execute();
              if (cs.getString(1).equals("OK")){%>
                alert("<%=cods.fixEnter(cs.getString(1))%>");parent.pageLock(false);top.returnValue={};top.close();<%
              } else {%>
                alert("<%=lang.get(si_error)%>");parent.pageLock(false);top.returnValue={};<%}
          } catch (Exception ex) {
              %>alert('<%= Util.quotesEsc(ex.getMessage()) %>');parent.pageLock(false);<%
          } finally {
              cs.close();
          }
    %></script>
    </t:request>
</t:requests>
<%!
    static final int si_form_title          = SI("Добавить нового сотрудника", "Янги ходим &#1179;ўшиш");
    static final int si_btn_save            = SI("Сохранить", "Са&#1179;лаш");

    static final int si_id                  = SI("ID");
    static final int si_first_name          = SI("Имя", "Исми");
    static final int si_last_name           = SI("Фамилия", "Фамилияси");
    static final int si_middle_name         = SI("Отчество", "Отасининг исми");
    static final int si_position            = SI("Должность", "Лавозими");
    static final int si_date_ishonchnoma    = SI("Дата доверенности", "Ишончнома санаси");
    static final int si_number_ishonchnoma  = SI("Номер доверенности", "Ишончнома ра&#1179;ами");
    static final int si_emp_code            = SI("Код сотрудника", "Ходим коди");
    static final int si_created_by          = SI("Кем изменено", "Ўзгартирган ходим");
    static final int si_created_on          = SI("Дата создание", "Яратилган сана");
    static final int si_begin_date          = SI("Дата активации", "Фаоллашган сана");
    static final int si_end_date            = SI("Дата увольнения");
    static final int si_branch_id           = SI("Branch ID", "Branch ID");

    static final int si_error               = SI("Хатолик!!!");
//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>
