<%@ page contentType="text/html;charset=WINDOWS-1251" language="java" %><%
%><%@ page import="java.sql.*, java.util.*, uz.fido_biznes.cms.*, uz.fido_biznes.sql.Direction,oracle.sql.*, oracle.jdbc.*, iabs.oraDBConnection" %><%

%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t" %><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session"/><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session"/><%
%><jsp:useBean id="util" class="iabs.oraUtil" scope="session"/><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/>
<%
	Connection conn = cods.getConnection();
	if (conn == null || user.getUserCode() == null)
		pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
	Language lang = new Language(user.getLanguageIndex(), sentences);
	pageContext.setAttribute(Resource.STR_LANGUAGE, lang);

	request.setCharacterEncoding("WINDOWS-1251");

	String client_code2 = request.getParameter("client_code");
	String filial_code = (String)session.getValue("filialCode");

%>
<t:page>
	<script>

	</script>
	<t:form title="<%=si_formTitle %>" minWidth="fill" minHeight="fill">
		<iframe name="frm" style="display:none"></iframe>
		<form name="fm" target="frm">
			<input type="hidden" name="request" value="add_new3">
			<input type="hidden" name=client_code2>
			<div id="basepanel" class=panel>
				<table style=" margin-left: 25px;">
					<col width="80%">
					<col width="10%">
					<col width="10%">
					<tr>
						<td>
							<input type="submit" id="saq"  name="ExBtn" value="Са&#1179;лаш2">
						</td>
						<td>
							<input type="hidden" name="id" value="">
						</td>
						<td align="right">
							<input onclick="window.close()" type="button" name="exit" value="Чи&#1179;иш">
						</td>
					</tr>
				</table>
				<div id="main">
					<fieldset class="info">
						<legend style="font-size:12.5px; text-align: center">Код клиента (уникалный код)</legend>
						<table style="margin-left: 25px;">
							<tr>
								<td>
									<input name="client_code"
										<%=(!"".equals(Util.nvl(client_code2)))?"readonly":"" %>
										size=8 maxLength=8 r=1
										reference="{name:'clients',get:{f1:fm.client_code}, put:[fm.client_code,fm.client_name,fm.director,fm.accountant], url:'ref.jsp'}"
										request="{name:'clients',get:{client_code:fm.client_code}, put:[fm.client_name],url:'ref.jsp'}">
									<input name="client_name" size=35 readonly tabindex=-1>
									<code>(F9)</code>
								</td>
							</tr>
<%--							<tr>--%>
<%--								<td>Уникалный код:--%>
<%--									<input name="nClientCode"--%>
<%--												 saveValue="1"--%>
<%--												 maxlength="9"--%>
<%--												 required size="10"--%>
<%--												 onkeydown="showClients(e);"--%>
<%--												 onblur="getClientInfo2()"--%>
<%--												 ondblclick="showClients(e)">--%>
<%--									<input type="submit"--%>
<%--												 id="saq222"--%>
<%--												 name="submitBtn222"--%>
<%--												 value="&#1178;идириш">--%>
<%--									<input type="button"--%>
<%--												 name="bSearchClientCode"--%>
<%--												 onclick="getByClientCode();"--%>
<%--												 value="<%=lang.get(si_search_code)%>">--%>
<%--								</td>--%>
<%--							</tr>--%>
						</table>
					</fieldset>
					<div id="result">

					</div>
				</div>
			</div>
		</form>
	</t:form>
</t:page>
<t:requests>

	<t:request name="add_new3"><%
		String res = null;
		try {
			iabs.HttpRequest req = new iabs.HttpRequest(request);
			String clientCode = req.getParam("client_code");
			CallableStatement cs = conn.prepareCall("{Call QQB_E_SHARTNOMA_SHAVKAT.getClientNameById(?,?)}");
			cs.registerOutParameter(1, OracleTypes.VARCHAR);
			cs.setString(2, clientCode);
			cs.execute();
			res = cs.getString(1);
		} catch (Throwable e) {
			res = e.getMessage();
		} finally {

		}%>
		<script>
            alert("<%=res%>");
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

	<t:request name="add_new2">
		<%
			try {
			    ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			    cs.setProcedure("QQB_E_SHARTNOMA_SHAVKAT.Save_Client");
			    cs.setAllParameters("i_Params");
			    cs.execute();%>
					<script>
							alert('<%=lang.get(si_success)%>');
							window.returnValue = parent.fm.client_code.value;
							top.close();
					</script><%
			} catch (SQLException err) {
			    %><%=util.alert(util.getMessage(err.toString()))%><%
					%><script>parent.pageLock(false);</script><%
			}%>
	</t:request>

	<t:request name="add_new"><%
		String res = null;
			try {
				iabs.HttpRequest req = new iabs.HttpRequest(request);
				String clientCode = req.getParam("nClientCode");
				CallableStatement cs = conn.prepareCall("{Call QQB_E_SHARTNOMA_SHAVKAT.getClientNameById(?,?)}");
				cs.registerOutParameter(1, OracleTypes.VARCHAR);
				cs.setString(2, clientCode);
				cs.execute();
				res = cs.getString(1);
			}catch (Throwable e) {
				res = e.getMessage();
			}%>
		<script>
				<%--alert('<%=lang.get(si_success)%>');--%>
				//top.close();
				//top.returnValue = 'R';
				//parent.pageLock(false);
		</script>
	</t:request>

	<t:request name="get_client_data" responseType="text" ><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("Cam_Http.Get_String_From_Hashmap");
			cs.setStringParameter("i_Doc_Serial", "PASSPORT_SERIAL");
			cs.setStringParameter("i_Doc_Number", "PASSPORT_NUMBER");
			cs.setNumberParameter("i_Pinfl", "PINFL");
			cs.setStringParameter("i_Inn", "INN");
			cs.setDateParameter("i_birth_date", "BIRTHDAY");
			cs.registerStringResult();
			cs.execute();
			out.print(cs.getStringResult());
		} catch (Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
</t:requests>
<%!
	static final int si_registration_region = SI("Код области прописки", "", "", "");
	static final int si_registration_region_n = SI("Наименование области прописки", "", "", "");
	static final int si_registration_district = SI("Код района прописки", "", "", "");
	static final int si_registration_district_n = SI("Наименование района прописки", "", "", "");
	static final int si_formTitle = SI("Янги киритиш");
	static final int si_Title = SI("Закрепление счетов");
	static final int si_currencyCode = SI("Код", "Code");
	static final int si_currencyName = SI("Имя", "Name");
	static final int si_success = SI("Успешно выполнено!", "Маълумотлар муваффа&#1179;иятли са&#1179;ланди!", "Ma`lumotlar muvaffaqiyatli saqlandi!", "Successfully");
	static final int si_exception = SI("Маълумотлар топилмади!");
	static final int si_Titlekr = SI("Кредит тури");
	static final int si_btn_client_code = SI("Код клиента (уникалный код)");
	static final int si_search_code = SI("Кидириш", "Поиск", "Search", "Qidirish");


//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>
<script>window.returnValue="Refresh";history.back();</script>