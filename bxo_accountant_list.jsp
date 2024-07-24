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
  String id = request.getParameter("id");
//-------------------------------------------------------------------------------------------------
  String view_name = "qqb_hl_index_info_v";
  String where_name = "index_id='"+id+"'";
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
        if (go({url:'index_info_add.jsp', param:{index_id: fm.code.value}, target:'modalE', dialogWidth:700, dialogHeight:300}))
            go({});
    }
    function edit()
    {
        if (go({url:'index_info_ed.jsp', param:{id: getData(1)}, target:'modalE', dialogWidth:700, dialogHeight:300}))
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
      <td><input type="hidden" name=code value=<%=id%>>
          <input id="add_button"  type="button" value="<%=lang.get(si_add_button)%>"  onclick="add()">
          <input id="edit_button" type="button" value="<%=lang.get(si_edit_button)%>" onclick="edit()">
      </td>
      <td colspan=3 align="left"><span id="filterControls"></span>
      <td align=right id=tableControls>
  </table>
  </form>
  <table width="100%" align=center cellspacing=0 cellpadding=0>
    <tr>
      <td>
        <t:table from="<%=view_name%>" where="<%=where_name%>">
          <t:field id="1" name="id" label="<%=si_id%>"></t:field>
          <t:field id="2" name="index_id" label="<%=si_index_id%>"></t:field>
          <t:field id="3" name="index_name" label="<%=si_name%>" type="quote"></t:field>
          <t:field id="4" name="begin_date" label="<%=si_begin_date%>" type="date"></t:field>
          <t:field id="5" name="end_date" label="<%=si_end_date%>" type="date"></t:field>
          <t:field id="6" name="procent" label="<%=si_procent%>" type="sum"></t:field>
          <t:field id="7" name="is_invalid_date" type="sum"></t:field>
          <t:grid page="25" numbering="" rowColor="(d(7)==1?'red':'blue')">
            <t:column for="1"/>
            <t:column for="2"/>
            <t:column for="3"/>
            <t:column for="4"/>
            <t:column for="5"/>
            <t:column for="6"/>
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
    Test2
  </div>
</t:form>
</t:page>
<%!
  static final int si_title            = SI("Кўрсаткичлари маълумотлари");
  static final int si_id               = SI("ID");
  static final int si_index_id         = SI("Кўрсаткич ID");
  static final int si_name             = SI("Кўрсаткич номи");
  static final int si_begin_date       = SI("Кўрсаткич бошланиш санаси");
  static final int si_end_date         = SI("Кўрсаткич тугаш санаси");
  static final int si_procent          = SI("Кўрсаткич фоиз ставкаси");
  static final int si_add_button       = SI("&#1178ўшиш");
  static final int si_edit_button      = SI("Ўзгартириш");
  //-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>

