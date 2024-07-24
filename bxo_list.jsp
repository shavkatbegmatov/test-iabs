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
  String view_name = "QQB_E_SHARTNOMA_BXO_V";
  String where_condition = "1=1";
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
      parent.onSelect(getData(2));
    }
    function onAction()
    {
      edit();
    }
    function add()
    {
      // if (go({url:'bxo_add.jsp', target:'modalE', dialogWidth:750, dialogHeight:350}))
      //     go({});

      if (go({
        url: "bxo_add.jsp",
        lock: false,
        target: 'modalE',
        dialogWidth: 550,
        dialogHeight: 200
      })){
        go({});
        showDetails2()
      }
    }
    function edit()
    {
      if (go({url:'bxo_edit.jsp', param:{
          id: getData(1),
          branch_id: getData(2),
          bxo_name_id: getData(3),
          bxo_min_address_id: getData(4),
          bxo_address_id: getData(5),
          bxo_manager_id: getData(6),
          bxo_accountant_id: getData(7),
          bxo_lawyer_id: getData(8)
        }, target:'modalE', dialogWidth:700, dialogHeight:300}))
        go({});
    }
  </script>
  <iframe name=dblink width=0 height=0></iframe>
  <form name=fm target=frm>
    <table class=formToolbar cellspacing=2>
      <tr>
        <td>
          <input id="add_button"  type="button" value="<%=lang.get(si_add_button)%>"  onclick="add()">
          <input id="edit_button" type="button" value="<%=lang.get(si_edit_button)%>" onclick="edit()">
        </td>
        <td colspan=3 align="left"><span id="filterControls"></span></td>
        <td align=right id=tableControls></td>
      </tr>
    </table>
  </form>
  <table width="100%" align=center cellspacing=0 cellpadding=0>
    <tr>
      <td>
        <t:table from="<%=view_name%>" >
          <t:field id="1"  name="id"              label="<%=si_id%>"></t:field>
          <t:field id="2"  name="branch_id"       label="<%=si_branch_id%>"></t:field>
          <t:field id="3"  name="bxo_name"        label="<%=si_bxo_name%>"           type="quote"></t:field>
          <t:field id="4"  name="bxo_min_address" label="<%=si_bxo_min_address%>"    type="quote"></t:field>
          <t:field id="5"  name="bxo_address"     label="<%=si_bxo_address%>"        type="quote"></t:field>
          <t:field id="6"  name="bxo_manager"     label="<%=si_bxo_manager%>"        type="quote"></t:field>
          <t:field id="7"  name="bxo_accountant"  label="<%=si_bxo_accountant_id%>"  type="quote"></t:field>
          <t:field id="8"  name="bxo_lawyer"      label="<%=si_bxo_lawyer_id%>"      type="quote"></t:field>
          <t:field id="9"  name="created_by"      label="<%=si_created_by%>"         type="quote"></t:field>
          <t:field id="10" name="created_on"      label="<%=si_created_on%>"         type="datetime"></t:field>
          <t:field id="11" name="begin_date"      label="<%=si_begin_date%>"         type="date"></t:field>
          <t:field id="12" name="bxo_phone"       label="<%=si_bxo_phone%>"          type="quote"></t:field>
          <t:grid >
            <t:column for="1"/>
            <t:column for="2"/>
            <t:column for="3"/>
            <t:column for="6"/>
            <t:column for="12"/>
          </t:grid>
        </t:table>
      </td>
    </tr>
  </table>
</t:form>
</t:page>
<%!
  static final int si_id                  = SI("ID", "ID");
  static final int si_branch_id           = SI("Branch ID", "Branch ID");
  static final int si_bxo_name            = SI("Названия", "Номи");
  static final int si_bxo_min_address     = SI("Кор. адрес", "Мин. манзил");
  static final int si_bxo_address         = SI("Адрес", "Манзил");
  static final int si_bxo_phone           = SI("Тел.", "Тел.");
  static final int si_bxo_manager         = SI("Управляющий", "Бош&#1179;арувчи");
  static final int si_bxo_accountant_id   = SI("Глав. бухгалтер", "Бош &#1203;исобчи");
  static final int si_bxo_lawyer_id       = SI("Юрист", "Юрист");

  static final int si_created_by          = SI("Кем изменено", "Ўзгартирган ходим");
  static final int si_created_on          = SI("Дата создание", "Яратилган сана");
  static final int si_begin_date          = SI("Дата активации", "Фаоллашган сана");

  static final int si_title               = SI("Список БХО", "БХОлар рўйхати");

  static final int si_add_button          = SI("Добавить", "&#1178ўшиш");
  static final int si_edit_button         = SI("Изменить", "Ўзгартириш");
  static final int si_delete_button       = SI("Удалить", "Ўчириш");

  //-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>

