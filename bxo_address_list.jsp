<%@ page contentType="text/html;charset=WINDOWS-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.driver.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
%><jsp:useBean id="util" class="iabs.oraUtil" scope="session" /><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/><%
	Connection conn = cods.getConnection();
	if (conn == null || user.getUserCode() == null) 
		pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
	Language lang = new Language(user.getLanguageIndex(), sentences);
	pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
//-------------------------------------------------------------------------------------------------
  String branch_id = request.getParameter("branch_id");
//-------------------------------------------------------------------------------------------------
  String view_name = "QQB_E_SHARTNOMA_BXO_ADDRESS_V";
  String where_name = "branch_id='"+branch_id+"' order by begin_date desc";
//  String where_name = "1=1";
//-------------------------------------------------------------------------------------------------
%><t:page><%
%><t:form title="<%=si_title%>" minWidth="fill" minHeight="fill">
  <link href="../../util/css/font.css" rel=stylesheet type="text/css">
<script>
    function onLoad()
    {
        if ( typeof(parent._oc_) == 'object')
            parent._oc_.focus();
    }
    function onSelect() {
    }
    function onAction()
    {
        edit();
    }
    function add()
    {
        if (go({url:'bxo_address_add.jsp', param:{branch_id: fm.branch_id.value}, target:'modalE', dialogWidth:700, dialogHeight:250}))
            go({});
    }
    function edit()
    {
        if (go({url:'bxo_address_edit.jsp', param:{
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
    // function is_lesser(end_date)
    // {
    //     var d1 = new Date(
    //         parseInt(end_date.substr(6)),
    //         parseInt(end_date.substr(3,2)),
    //         parseInt(end_date.substr(0,2))
    //     );
    //
    //     var vOper = 'cods.getOperDay()';
    //     var d2 = new Date(
    //         parseInt(vOper.substr(6)),
    //         parseInt(vOper.substr(3,2)),
    //         parseInt(vOper.substr(0,2))
    //     );
    //     return d1<d2?1:0;
    // }
</script>
<iframe name=dblink width=0 height=0></iframe>
  <form name=fm target=frm>
    <table class=formToolbar cellspacing=2>
      <tr>
        <td><input type="hidden" name=branch_id value=<%=branch_id%>>
          <input id="add_button"  type="button" value="<%=lang.get(si_add_button)%>"  onclick="add()">
          <input id="edit_button" type="button" value="<%=lang.get(si_edit_button)%>" onclick="edit()">
        </td>
        <td>
          <span style="border-bottom: #9EC2E4 solid 2px">
            <span style="color: #67ADD9; font-weight: bold;">
              Филиал:
            </span>
            <span style="color: #00ad00; font-weight: bold;">
              <%=branch_id%>
            </span>
          </span>
        </td>
        <td colspan=3 align="left"><span id="filterControls"></span>
        <td align=right id=tableControls>
      </tr>
    </table>
  </form>
  <table width="100%" align=center cellspacing=0 cellpadding=0>
    <tr>
      <td>
        <t:table from="<%=view_name%>" where="<%=where_name%>">
          <t:field id="1" name="id" label="<%=si_id%>"></t:field>
          <t:field id="2" name="branch_id" label="<%=si_branch_id%>"></t:field>
          <t:field id="3" name="address" label="<%=si_address%>" type="quote"></t:field>
          <t:field id="4" name="min_address" label="<%=si_min_address%>" type="quote"></t:field>
          <t:field id="8" name="bxo_phone" label="<%=si_min_address%>" type="quote"></t:field>
          <t:field id="5" name="begin_date" label="<%=si_begin_date%>" type="date"></t:field>
          <t:field id="6" name="created_by" label="<%=si_created_by%>" type="quote"></t:field>
          <t:field id="7" name="created_on" label="<%=si_created_on%>" type="datetime"></t:field>
          <t:grid page="25" numbering="" rowColor="(d(7)==1?'red':'blue')">
            <t:column for="1"/>
            <t:column for="2"/>
            <t:column for="3"/>
            <t:column for="4"/>
            <t:column for="8"/>
            <t:column for="5"/>
            <t:column for="6"/>
            <t:column for="7"/>
          </t:grid>
        </t:table>
      </td>
    </tr>
  </table>
  <style>
    .indexDate {
      background-color: antiquewhite;
    }
  </style>
  <div class="indexDate">
<%--    Test2--%>
  </div>
</t:form>
</t:page>
<%!
  static final int si_title            = SI("БХО манзили тарихи маълумотлари");

  static final int si_id                  = SI("ID");
  static final int si_first_name          = SI("Имя");
  static final int si_last_name           = SI("Фамилия");
  static final int si_middle_name         = SI("Отчество");
  static final int si_position            = SI("Позиция");
  static final int si_date_ishonchnoma    = SI("Дата доверенности");
  static final int si_number_ishonchnoma  = SI("Номер доверенности");
  static final int si_emp_code            = SI("Код сотрудника");

  static final int si_created_by      = SI("Кем изменено", "Ўзгартирган ходим");
  static final int si_created_on      = SI("Дата создание", "Яратилган сана");
  static final int si_begin_date      = SI("Дата активации", "Фаоллашган сана");

  static final int si_end_date            = SI("Дата увольнения");

  static final int si_branch_id           = SI("Код филиала");
  static final int si_address             = SI("Адрес", "Манзил");
  static final int si_min_address         = SI("Короткий адрес", "&#1178;ис&#1179;а манзил");


  static final int si_name             = SI("Кўрсаткич номи");
  static final int si_procent          = SI("Кўрсаткич фоиз ставкаси");
  static final int si_add_button       = SI("&#1178ўшиш");
  static final int si_edit_button      = SI("Ўзгартириш");
  //-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>

