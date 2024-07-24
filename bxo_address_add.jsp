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
    String branch_id = request.getParameter("branch_id");
    String created_by = user.getUserCode();
    String begin_date = stored.execFunction("setup.get_operday");
//    String user_name = stored.execFunction("setup.get_operday");
//-------------------------------------------------------------------------------------------------
%><t:page><%
%><t:form title="<%= si_form_title %>" minHeight="fill" minWidth="fill">
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
                        <input id=btnAuthorization type=submit value="<%= lang.get(si_save) %>">
                    </td>
                </tr>
            </table>
            <table width="100%" border="0">
                <colgroup>
                    <col width="21%"/>
                    <col width="79%"/>
                </colgroup>
                <tr>
                    <td align="right"><%=lang.get(si_branch_id)%></td>
                    <td><input name="branch_id" type="text" size="40" value="<%=branch_id%>" readonly style="width:100%"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_address)%><span style="color: red;"> *</span></td>
                    <td><input name="address" type="text" size="40" style="width:100%"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_min_address)%><span style="color: red;"> *</span></td>
                    <td><input name="min_address" type="text" size="40" style="width:100%"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_bxo_phone)%><span style="color: red;"> *</span></td>
                    <td><input name="bxo_phone" type="text" size="40" style="width:100%"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_begin_date)%><span style="color: red;"> *</span></td>
                    <td><input name="begin_date" mask='date' size="12"  value="<%=begin_date%>"></td>
                </tr>
                <tr>
                    <td align="right"><%=lang.get(si_created_by)%></td>
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
              query = "{call QQB_E_SHARTNOMA_SHAVKAT.addBxoAddress(?,?,?,?,?,?,?,?)}";
              cs = (OracleCallableStatement) conn.prepareCall(query);
              cs.registerOutParameter(1,Types.VARCHAR);
              cs.setString(2,request.getParameter("branch_id"));
              cs.setString(3,cods.ConvIso(request.getParameter("address")));
              cs.setString(4,cods.ConvIso(request.getParameter("min_address")));
              cs.setString(5,cods.ConvIso(request.getParameter("bxo_phone")));
              cs.setString(6,request.getParameter("begin_date"));
              cs.setString(7,request.getParameter("created_by"));
              cs.setString(8,request.getParameter("created_on"));


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
    static final int si_form_title = SI("���������� ���� ��������� &#1179;����");
    static final int si_save = SI("��&#1179;���");

    static final int si_id                  = SI("ID");
    static final int si_bxo_name            = SI("�������� �������", "������ ����");
    static final int si_branch_id           = SI("Branch ID", "Branch ID");
    static final int si_created_by          = SI("��� ��������", "����������� �����");
    static final int si_created_on          = SI("���� ��������", "��������� ����");
    static final int si_begin_date          = SI("���� ���������", "���������� ����");

    static final int si_address             = SI("�����", "������");
    static final int si_min_address         = SI("�������� �����", "&#1178;��&#1179;� ������");
    static final int si_bxo_phone			= SI("��� ���.","��� ���.","","");
    static final int si_bxo_inn				= SI("��� ���","��� ���","","");
    static final int si_bxo_schet			= SI("��������� ���� ���","��� &#1203;������&#1179;���","","");

    static final int si_error = SI("�������!!!");
//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>
