<%@ page contentType="text/html;charset=WINDOWS-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.driver.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%

	Connection conn = cods.getConnection();

	if (conn == null || user.getUserCode() == null)
		pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);

	Language lang = new Language(user.getLanguageIndex(), sentences);
	pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
//-------------------------------------------------------------------------------------------------
%>
<t:references>
	<t:reference name="sv_contract_clients" title="<%= si_clients %>" >
		<t:table from="ln_v_sv_contract_clients">
			<t:field id="1" name="code" label="<%= si_code %>">
				<t:filter showInGrid="" mask="8|0-9" size="8" operator="like_"/>
			</t:field>
			<t:field id="2" name="name" label="<%= si_name %>" type="quote">
				<t:filter showInGrid="" operator="_search_"/>
			</t:field>
			<t:field id="3" name="inn" label="<%= si_inn %>"/>
			<t:grid page="" hideFilterButton="" withoutCursor="" >
				<t:column for="1" />
				<t:column for="2" align="left"/>
				<t:column for="3" />
			</t:grid>
		</t:table>
	</t:reference>
</t:references>
