<%@ page contentType="text/html;charset=WINDOWS-1251" language="java" %><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*, uz.fido_biznes.sql.Direction, oracle.sql.*, oracle.jdbc.*,iabs.oraDBConnection" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t" %><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session"/><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session"/><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/><%!
    String formatCurrency(String org){
        return org+org;
    }
%><%
    Connection conn = cods.getConnection();
    if (conn == null || user.getUserCode() == null)
        pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
    Language lang = new Language(user.getLanguageIndex(), sentences);
    pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
    request.setCharacterEncoding("WINDOWS-1251");
%><t:page><%
    String id = request.getParameter("id");
    String inn = null,reg_nom = null,reg_data = null,name = null,address = null,street = null,phone = null,email = null,opf_code_with_title = null,oked_code_with_title = null,namu_1 = null,namu_2 = null,namu_3 = null,namu_4 = null,namu_5 = null,dol_1 = null,dol_2 = null,dol_3 = null,dol_4 = null,dol_5 = null,uf_1 = null,uf_2 = null,uf_3 = null,uf_4 = null,uf_5 = null,uf_sum = null,get_datatime = null;
    String navNext=null, navPrev=null;
    try{
        CallableStatement cs = conn.prepareCall("{ Call qqb_e_stat.get_data(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ");
        cs.setString(1,id);
        cs.registerOutParameter(2, OracleTypes.VARCHAR);
        cs.registerOutParameter(3, OracleTypes.VARCHAR);
        cs.registerOutParameter(4, OracleTypes.VARCHAR);
        cs.registerOutParameter(5, OracleTypes.VARCHAR);
        cs.registerOutParameter(6, OracleTypes.VARCHAR);
        cs.registerOutParameter(7, OracleTypes.VARCHAR);
        cs.registerOutParameter(8, OracleTypes.VARCHAR);
        cs.registerOutParameter(9, OracleTypes.VARCHAR);
        cs.registerOutParameter(10, OracleTypes.VARCHAR);
        cs.registerOutParameter(11, OracleTypes.VARCHAR);
        cs.registerOutParameter(12, OracleTypes.VARCHAR);
        cs.registerOutParameter(13, OracleTypes.VARCHAR);
        cs.registerOutParameter(14, OracleTypes.VARCHAR);
        cs.registerOutParameter(15, OracleTypes.VARCHAR);
        cs.registerOutParameter(16, OracleTypes.VARCHAR);
        cs.registerOutParameter(17, OracleTypes.VARCHAR);
        cs.registerOutParameter(18, OracleTypes.VARCHAR);
        cs.registerOutParameter(19, OracleTypes.VARCHAR);
        cs.registerOutParameter(20, OracleTypes.VARCHAR);
        cs.registerOutParameter(21, OracleTypes.VARCHAR);
        cs.registerOutParameter(22, OracleTypes.VARCHAR);
        cs.registerOutParameter(23, OracleTypes.VARCHAR);
        cs.registerOutParameter(24, OracleTypes.VARCHAR);
        cs.registerOutParameter(25, OracleTypes.VARCHAR);
        cs.registerOutParameter(26, OracleTypes.VARCHAR);
        cs.registerOutParameter(27, OracleTypes.VARCHAR);
        cs.registerOutParameter(28, OracleTypes.VARCHAR);
        cs.execute();
        inn = cs.getNString(2);
        reg_nom = cs.getNString(3);
        reg_data = cs.getNString(4);
        name = cs.getNString(5);
        address = cs.getNString(6);
        street = cs.getNString(7);
        phone = cs.getNString(8);
        email = cs.getNString(9);
        opf_code_with_title = cs.getNString(10);
        oked_code_with_title = cs.getNString(11);
        namu_1 = cs.getNString(12);
        namu_2 = cs.getNString(13);
        namu_3 = cs.getNString(14);
        namu_4 = cs.getNString(15);
        namu_5 = cs.getNString(16);
        dol_1 = cs.getNString(17);
        dol_2 = cs.getNString(18);
        dol_3 = cs.getNString(19);
        dol_4 = cs.getNString(20);
        dol_5 = cs.getNString(21);
        uf_1 = cs.getNString(22);
        uf_2 = cs.getNString(23);
        uf_3 = cs.getNString(24);
        uf_4 = cs.getNString(25);
        uf_5 = cs.getNString(26);
        uf_sum = cs.getNString(27);
        get_datatime = cs.getNString(28);
        cs.close();
    }catch (Throwable ignored){}

    try{
        CallableStatement cs = conn.prepareCall("{ CALL qqb_e_stat.get_nav(?,?,?)}");
        cs.setString(1,id);
        cs.registerOutParameter(2,OracleTypes.VARCHAR);
        cs.registerOutParameter(3,OracleTypes.VARCHAR);
        cs.execute();
        navPrev = cs.getString(2);
        navNext = cs.getString(3);
        cs.close();
    }catch (Throwable ignored){}
%>
    <script>
    function goToDetails(id) {
        if (go({
            url: "details.jsp",
            param: {
                id: id
            }
        })) go({});
    }
    function toCurrency2(n) {
        return new Intl.NumberFormat().format(n);
    }
    </script>
    <t:form title="1" minWidth="fill" minHeight="fill">
        <iframe name=frm style="display:none"></iframe>
        <form name=fm target=frm>
            <input type="hidden" name="request" value="add_new">
            <div id=basepanel class=panel>
                <style>
                    .my_title {
                        border-collapse: collapse;
                        border: 1px solid #E0E3E6;
                        font-weight: bold;
                        margin: 3px;
                        padding: 3px;
                        margin-top: 8px;
                        background-color: #EBF0FE;
                        border-radius: 3px;
                        display: flex;
                        justify-content: space-between;
                    }
                </style>
                <div class="my_title">
                    <div><%=get_datatime%></div>
                    <div><%=id%></div>
                </div>


                <table style=" margin-left: 25px;" style="width:100%">
                    <col width="50%">
                    <col width="50%">
                    <tr>
                        <td style="width:50%">
                        <% if(navPrev!=null){%>
                            <input type="button" onclick="goToDetails('<%=Util.quotesEsc(navPrev)%>')" id="prev" name="prev"  value="���������">
                        <%}%>
                        </td>
                        <td style="width:50%" align="right">
                        <% if(navNext!=null){%>
                            <input type="button" onclick="goToDetails('<%=Util.quotesEsc(navNext)%>')" name="next" value="���������">
                        <%}%>
                        </td>
                </table>
                <div id="main">
                    <fieldset class="info">
                        <legend style="font-size:12.5px; text-align: center">���������� � ����������� ���� (�� ������ stat.uz)</legend>
                        <style>
                            .td_border {
                                border-collapse: collapse;
                                border: 1px solid #E0E3E6;
                                font-weight: bold;
                            }
                            .stat_info_h3 {
                                margin: 3px 0;
                                padding: 3px;
                                margin-top: 8px;
                                background-color: #EBF0FE;
                                border-radius: 3px;
                            }
                            .name_company {
                                background-color: #1A1A8A;
                                color: #EBF0FE;
                                font-weight: bold;
                            }
                        </style>
                        <table cellpadding="3" border="0" style="width:100%!important;"><tbody>
                            <tr><td width="700" colspan="4"><h3 class="stat_info_h3"><%=0 %></h3></td></tr>
                            <tr><td width="250" colspan="1"><%=si_clientInn%></td><td class="td_border" width="450" colspan="3">&nbsp;<%=inn%></td></tr>
                            <tr><td width="250" colspan="1">�������������� �����:</td><td class="td_border" width="450" colspan="3">&nbsp;�������� ������ (������)</td></tr>
                            <tr><td width="250" colspan="1">���� �����������:</td><td width="450" class="td_border" colspan="3">&nbsp;<%=reg_data%></td></tr>
                            <tr><td width="250" colspan="1">����� �����������:</td><td width="450" colspan="3" class="td_border">&nbsp;<%=reg_nom%></td></tr>
                            <tr><td width="250" colspan="1">������������ ������������ ����:</td><td class="name_company" width="450" colspan="3" class="td_border"><%=name%></td></tr>
                            <tr><td width="250" colspan="1">��� ���:</td><td width="450" colspan="3" class="td_border"><%=opf_code_with_title%></td></tr>
                            <tr><td width="250" colspan="1">��� ���� (���(�) �������������� ���-��):</td><td width="450" colspan="3" class="td_border"><%=oked_code_with_title%></td></tr>
                            <tr><td width="250" colspan="1">��� �����:</td><td width="450" colspan="3" class="td_border">01011 - ����������� ����, ����������� �������� ������ �� ������</td></tr>
<%--                            <tr><td width="300" colspan="1">�������������� � c�������� ������ �������������������:</td><td width="400" colspan="3" class="td_border">���</td></tr>--%>
<%--                            <tr><td width="300" colspan="1">��������� ����������:</td><td width="400" colspan="3" class="td_border">����������� �����������</td></tr>--%>

                            <tr><td width="250" colspan="1">�������� ����:</td><td width="450" colspan="3" class="td_border">
                                <script>
                                    document.write(toCurrency2("<%=uf_sum%>"));
                                </script>
                                ���. ���.</td></tr>
                            <tr><td width="700" colspan="4"><h3 class="stat_info_h3">���������� �� ����������� � �� ���� � �������� �����</h3></td></tr>
                            <% if(namu_1!=null){%>
                            <tr><td colspan="2" width="470" class="td_border">1.&nbsp;<%=namu_1%></td><td class="td_border" style="text-align:right;" width="165">
                                <script>
                                    document.write(toCurrency2("<%=uf_1%>"));
                                </script>
                                ���. ���.</td><td class="td_border" style="text-align:right;" width="65"><%=dol_1%>&nbsp;%</td></tr>
                            <%}%>
                            <% if(namu_2!=null){%>
                            <tr><td colspan="2" width="470" class="td_border">2.&nbsp;<%=namu_2%></td><td class="td_border" style="text-align:right;" width="165">
                                <script>
                                    document.write(toCurrency2("<%=uf_2%>"));
                                </script>
                                ���. ���.</td><td class="td_border" style="text-align:right;" width="65"><%=dol_2%>&nbsp;%</td></tr>
                            <%}%>
                            <% if(namu_3!=null){%>
                            <tr><td colspan="2" width="470" class="td_border">3.&nbsp;<%=namu_3%></td><td class="td_border" style="text-align:right;" width="165">
                                <script>
                                    document.write(toCurrency2("<%=uf_3%>"));
                                </script>
                                ���. ���.</td><td class="td_border" style="text-align:right;" width="65"><%=dol_3%>&nbsp;%</td></tr>
                            <%}%>
                            <% if(namu_4!=null){%>
                            <tr><td colspan="2" width="470" class="td_border">4.&nbsp;<%=namu_4%></td><td class="td_border" style="text-align:right;" width="165">
                                <script>
                                    document.write(toCurrency2("<%=uf_4%>"));
                                </script>
                                ���. ���.</td><td class="td_border" style="text-align:right;" width="65"><%=dol_4%>&nbsp;%</td></tr>
                            <%}%>
                            <% if(namu_5!=null){%>
                            <tr><td colspan="2" width="470" class="td_border">5.&nbsp;<%=namu_5%></td><td class="td_border" style="text-align:right;" width="165">
                                <script>
                                    document.write(toCurrency2("<%=uf_5%>"));
                                </script>
                                ���. ���.</td><td class="td_border" style="text-align:right;" width="65"><%=dol_5%>&nbsp;%</td></tr>
                            <%}%>
                            <tr><td width="700" colspan="4"><h3 class="stat_info_h3">���������� ������</h3></td></tr>
                            <tr><td width="250" colspan="1">����� ����������� �����:</td><td width="450" colspan="3" class="td_border"><%=email!=null?email:"-"%></td></tr>
                            <tr><td width="250" colspan="1">���������� ��������:</td><td colspan="3" width="450" class="td_border">&nbsp;<%=phone%></td></tr>
                            <tr><td width="250" colspan="1">��� �����:</td><td width="450" class="td_border" colspan="3">&nbsp;<%=address%></td></tr>
                            <tr><td width="250" colspan="1">�����, �����, ���:</td><td colspan="3" width="450" class="td_border">&nbsp;<%=street%></td></tr>
                            <tr><td width="700" colspan="4"><h3 class="stat_info_h3">���������� � ������������</h3></td></tr>
                            <tr><td width="250" colspan="1">��� ������������:</td><td width="450" colspan="3" class="td_border">&nbsp;</td></tr>
                        </tbody></table>
                    </fieldset>
                </div>
            </div>
        </form>
    </t:form>
</t:page>
<t:requests>
    <t:request name="add_new">
        <%
            String res = null;
            try {
                iabs.HttpRequest req = new iabs.HttpRequest(request);
                String inn = req.getParam("rInn");
                CallableStatement cs = conn.prepareCall("{Call qqb_e_stat.get_data(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                cs.setString(1, inn);
                cs.registerOutParameter(2, OracleTypes.VARCHAR);
                cs.registerOutParameter(3, OracleTypes.VARCHAR);
                cs.registerOutParameter(4, OracleTypes.VARCHAR);
                cs.registerOutParameter(5, OracleTypes.VARCHAR);
                cs.registerOutParameter(6, OracleTypes.VARCHAR);
                cs.registerOutParameter(7, OracleTypes.VARCHAR);
                cs.registerOutParameter(8, OracleTypes.VARCHAR);
                cs.registerOutParameter(9, OracleTypes.VARCHAR);
                cs.registerOutParameter(10, OracleTypes.VARCHAR);
                cs.registerOutParameter(11, OracleTypes.VARCHAR);
                cs.registerOutParameter(12, OracleTypes.VARCHAR);
                cs.registerOutParameter(13, OracleTypes.VARCHAR);
                cs.registerOutParameter(14, OracleTypes.VARCHAR);
                cs.registerOutParameter(15, OracleTypes.VARCHAR);
                cs.registerOutParameter(16, OracleTypes.VARCHAR);
                cs.registerOutParameter(17, OracleTypes.VARCHAR);
                cs.registerOutParameter(18, OracleTypes.VARCHAR);
                cs.registerOutParameter(19, OracleTypes.VARCHAR);
                cs.registerOutParameter(20, OracleTypes.VARCHAR);
                cs.registerOutParameter(21, OracleTypes.VARCHAR);
                cs.registerOutParameter(22, OracleTypes.VARCHAR);
                cs.registerOutParameter(23, OracleTypes.VARCHAR);
                cs.registerOutParameter(24, OracleTypes.VARCHAR);
                cs.registerOutParameter(25, OracleTypes.VARCHAR);
                cs.registerOutParameter(26, OracleTypes.VARCHAR);
                cs.execute();
                res = cs.getString(2);
            }catch (Throwable e){
                res = e.getMessage();
            }
        %>
        <script>
            alert('<%=Util.quotesEsc(res)%>');
            top.close();
            top.returnValue='R';
        </script>
    </t:request>
</t:requests>
<%!
    /*
    *       o'  -   &#1118;      *
    *       O'  -   &#1038;      *
    *       q   -   &#1179;      *
    *       Q   -   &#1178;      *
    *       g'  -   &#1171;      *
    *       G'  -   &#1170;      *
    *       h   -   &#1203;      *
    *       H   -   &#1202;      *
    * */
    static final int si_clientDetail2 = SI("��������� �����������:", "�������� ������������:", "", "");
    static final int si_clientInn = SI("���:", "���:", "", "");
    static final int si_registration_region = SI("��� ������� ��������", "", "", "");
    static final int si_registration_region_n = SI("������������ ������� ��������", "", "", "");
    static final int si_registration_district = SI("��� ������ ��������", "", "", "");
    static final int si_registration_district_n = SI("������������ ������ ��������", "", "", "");
    static final int si_formTitle = SI("��������� ���������� �� �����������", "�������� &#1203;�&#1179;��� �������� ��������", "", "");
    static final int si_Title = SI("����������� ������");
    static final int si_currencyCode = SI("���", "Code");
    static final int si_currencyName = SI("���", "Name");
    static final int si_success = SI("������� ���������!", "����������� �������&#1179;����� ��&#1179;�����!", "Ma`lumotlar muvaffaqiyatli saqlandi!", "Successfully");
    static final int si_exception = SI("����������� ���������!");
    static final int si_Titlekr = SI("������ ����");
//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>


