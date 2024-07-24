<%@ page contentType="text/html;charset=WINDOWS-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
%><jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/><%
	Connection conn = cods.getConnection();
	if (conn == null || user.getUserCode() == null)
		pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
	Language lang = new Language(user.getLanguageIndex(), sentences);
	pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
//-------------------------------------------------------------------------------------------------
%><t:page><%
	String filial = (String)session.getValue("filialCode");
	String contract_code = request.getParameter("contract_code");
//	String user_type = storedObj.execFunction("QQB_KREDIT.Get_Access");
//	if(id !=null ) session.putValue("S_zv_Id", id);
//	String status    = request.getParameter("status");
//	session.putValue("status", status);
	String view = "QQB_E_SHARTNOMA_ADDITIONAL_V";
	String where = "contract_code=" + Util.quotesSQL(contract_code);
//	String Javob;
%><t:form title="<%= si_formTitle %>" minHeight="fill" minWidth="fill"  >
	<link href="../../util/css/font.css" rel=stylesheet type="text/css">
	<!--[if !IE]><!-->
	<script>
		try {
			var bc = new BroadcastChannel('preview:compiled');
			bc.onmessage = function (message) {
				if (message.data == 'Refresh') {
					getAjaxTDD();
				}
			};
		}catch (e) {}
	</script>
	<![endif]-->
	<script>
		function addContract () {
			if (go({
				url: "add_additional_contract.jsp",
				param: {
					contract_code:		<%=contract_code%>,
					contract_type:		'A',
				},
				lock: false,
				target: 'modalE',
				dialogWidth: 500,
				dialogHeight: 200
			})) go({});
		}

		function previewContract() {
		  if (go({
			  url: "preview2.jsp",
			  param: {
				  id:			        getData(1),
				  contract_number:		getData(2),
				  contract_date:		getData(3),
				  contract_code:		getData(38),

				  sms_service:			getData(17),
				  remote_service:		getData(16),

				  contract_type:		'A',
				  contract_percent:		getData(36),

				  client_code:			getData(9),
				  client_name:			getData(14),
				  client_schet:			getData(21),
				  client_inn:			getData(22),
				  client_oked:			getData(24),
				  client_phone:			getData(26),
				  client_manager:		getData(15),
				  client_accountant:	getData(27),
				  client_lawyer:		getData(28),
				  client_address:		getData(19),

				  branch_id:		    getData(8),
				  bxo_name: 			getData(30),
				  bxo_schet:		    getData(20),
				  bxo_inn:				getData(23),
				  bxo_oked:				getData(33),
				  bxo_phone:		    getData(25),
				  bxo_manager:			getData(13),
				  bxo_accountant:		getData(31),
				  bxo_lawyer:			getData(29),
				  date_ishonchnoma:		getData(11),
				  number_ishonchnoma:	getData(12),
				  bxo_address:			getData(18),
				  bxo_min_address:		getData(10),
			  },
			  lock: false,
			  target: 'modalE',
			  dialogWidth: 1200,
			  dialogHeight: 600
		  })) go({});
	  }

		function printContract() {
			if (go({
				url: "print_additional.jsp",
				param: {
					id:			        getData(1), // ok
					contract_number:	getData(2), // ok
					contract_date:		getData(3), // ok
					date_generate:		getData(4),
					date_modify:		getData(5),
					filial_code:		getData(6),
					local_code:			getData(7),
					branch_id:		    getData(8),
					client_code:		getData(9),
					bxo_min_address:	getData(10),
					date_ishonchnoma:	getData(11),
					number_ishonchnoma:	getData(12),
					bxo_manager:		getData(13),
					client_name:		getData(14),
					client_manager:		getData(15),
					remote_service:		getData(16), // ok
					sms_service:		getData(17), // ok
					bxo_address:		getData(18),
					client_address:		getData(19),
					bxo_schet:		    getData(20),
					client_schet:		getData(21),
					client_inn:			getData(22),
					bxo_inn:			getData(23),
					client_oked:		getData(24),
					bxo_phone:		    getData(25),
					client_phone:		getData(26),
					client_accountant:	getData(27),
					client_lawyer:		getData(28),
					bxo_lawyer:			getData(29),
					bxo_name: 			getData(30), // ok
					bxo_accountant:		getData(31),
					bxo_oked:			getData(33),
					bxo_mfo:			getData(34),
					contract_type:		getData(35), // ok
					service_procent:	getData(36),
					contract_number_ai:	getData(37),
					contract_code:		getData(38)
				},
				lock: false,
				target: 'modalE',
				dialogWidth: 1000,
				dialogHeight: 800
			})) go({});
		}

		function deleteContract() {
			if (go({
				url: "delete_contract.jsp",
				param: {
					id:			        getData(1),
					contract_type:		getData(35),
				},
				lock: false,
				target: 'modalE',
				dialogWidth: 1000,
				dialogHeight: 800
			})) go({});
		}

		function onSelect() {
			const btn = document.getElementById('delete');
			if (getData(32)!=='D') {
				btn.setAttribute('disabled', '');
			} else {
				btn.removeAttribute('disabled');
			}
		}

	</script>
	<iframe name=dblink width=0 height=0></iframe>
	<table class=formToolbar cellspacing=2>
		<tr><td>
			<button id=btnAdd onclick="addContract()"><%= lang.get(si_btn_add) %></button>
			<button id=btnPreview onclick="previewContract()"><%= lang.get(si_btn_preview) %></button>
			<input type=button name="print" onclick="printContract()" value="<%=lang.get(si_btn_print_contract)%>">
			<% if (filial.equals("09009")){ %>
				<input type=button name="delete" id="delete" onclick="deleteContract()" value="<%=lang.get(si_btn_delete_contract)%>">
			<% } %>
			<td id=tableControls align=right>
	</table>
	<t:table from="<%=view%>"  where="<%=where%>">
		<t:field id="1"  name="ID" 					label="<%=si_id%>"/>
		<t:field id="2"  name="CONTRACT_NUMBER" 	label="<%=si_contract_number%>" type="quote"/>
		<t:field id="3"  name="CONTRACT_DATE" 		label="<%=si_contract_date%>" type="date"/>
        <t:field id="32" name="CONTRACT_STATE" 		label="<%=si_contract_state%>" type="quote"/>
        <t:field id="37" name="CONTRACT_NUMBER_AI" 	label="<%=si_contract_number_ai%>" type="quote"/>
        <t:field id="38" name="CONTRACT_CODE" 		label="<%=si_contract_code%>" type="quote"/>
        <t:field id="4"  name="DATE_GENERATE" 		label="<%=si_date_generate%>" type="datetime"/>
        <t:field id="5"  name="DATE_MODIFY" 		label="<%=si_date_modify%>" type="datetime"/>

        <t:field id="17" name="SMS_SERVICE" 		label="<%=si_sms_service%>"/>
        <t:field id="16" name="REMOTE_SERVICE" 		label="<%=si_remote_service%>"/>
        <t:field id="35" name="CONTRACT_TYPE" 		label="<%=si_contract_type%>" type="quote"/>
        <t:field id="36" name="CONTRACT_PERCENT" 	label="<%=si_contract_percent%>" type="quote"/>

        <t:field id="9"  name="CLIENT_CODE" 		label="<%=si_client_code%>"/>
        <t:field id="14" name="CLIENT_NAME" 		label="<%=si_client_name%>" type="quote"/>
        <t:field id="21" name="CLIENT_SCHET"		label="<%=si_client_schet%>"/>
        <t:field id="22" name="CLIENT_INN" 			label="<%=si_client_inn%>"/>
        <t:field id="24" name="CLIENT_OKED" 		label="<%=si_client_oked%>"/>
        <t:field id="26" name="CLIENT_PHONE" 		label="<%=si_client_phone%>" type="quote"/>
        <t:field id="15" name="CLIENT_MANAGER" 		label="<%=si_client_manager%>" type="quote"/>
        <t:field id="27" name="CLIENT_ACCOUNTANT" 	label="<%=si_client_accountant%>" type="quote"/>
        <t:field id="28" name="CLIENT_LAWYER" 		label="<%=si_client_lawyer%>" type="quote"/>
        <t:field id="19" name="CLIENT_ADDRESS" 		label="<%=si_client_address%>" type="quote"/>

        <t:field id="8"  name="BRANCH_ID" 			label="<%=si_branch_id%>"/>
        <t:field id="34" name="BXO_MFO" 			label="<%=si_bxo_mfo%>" type="quote"/>
        <t:field id="30" name="BXO_NAME" 			label="<%=si_bxo_name%>" type="quote"/>
        <t:field id="20" name="BXO_SCHET" 			label="<%=si_bxo_schet%>"/>
        <t:field id="23" name="BXO_INN" 			label="<%=si_bxo_inn%>"/>
        <t:field id="33" name="BXO_OKED" 			label="<%=si_bxo_oked%>" type="quote"/>
        <t:field id="25" name="BXO_PHONE" 			label="<%=si_bxo_phone%>" type="quote"/>
        <t:field id="13" name="BXO_MANAGER" 		label="<%=si_bxo_manager%>" type="quote"/>
        <t:field id="31" name="BXO_ACCOUNTANT" 		label="<%=si_bxo_accountant%>" type="quote"/>
        <t:field id="29" name="BXO_LAWYER" 			label="<%=si_bxo_lawyer%>" type="quote"/>
        <t:field id="11" name="DATE_ISHONCHNOMA" 	label="<%=si_date_ishonchnoma%>" type="date"/>
        <t:field id="12" name="NUMBER_ISHONCHNOMA" 	label="<%=si_number_ishonchnoma%>" type="quote"/>
        <t:field id="18" name="BXO_ADDRESS" 		label="<%=si_bxo_address%>" type="quote"/>
        <t:field id="10" name="BXO_MIN_ADDRESS"		label="<%=si_bxo_min_address%>" type="quote"/>
		<t:field id="6"  name="FILIAL_CODE" 		label="<%=si_filial_code%>"/>
		<t:field id="7"  name="LOCAL_CODE" 			label="<%=si_local_code%>"/>

		<t:grid page="25" numbering="" rowColor="(d(32)=='D'?'red':d(32)=='R'?'green':'blue')">
			<t:column for="1" />
			<t:column for="2" />
			<t:column for="3" />
			<t:column for="9" />
			<t:column for="14" />
			<t:column for="15" />
			<t:column for="19" />
			<t:column for="26" />
			<t:column for="36" />
			<t:column for="32" />
			<t:column for="38" />
		</t:grid>
	</t:table>
</t:form>
</t:page>
<%!
	static final int si_formTitle			= SI("���. ��������", "&#1178;&#1118;����� �����������");
	static final int si_title           	= SI("�������� ������","","","");
	static final int si_id              	= SI("ID","ID","","");
	static final int si_contract_number 	= SI("����� ��������","�������� ��&#1179;���","","");
	static final int si_contract_date   	= SI("���� ��������","�������� ������","","");
	static final int si_date_generate   	= SI("���� ��������� ��������","�������� ��������� &#1179;������� ��&#1179;�","","");
	static final int si_date_modify     	= SI("���� ����������� ��������","�������� &#1118;������������ ��&#1179;�","","");
	static final int si_filial_code     	= SI("��� �������","������ ����","","");
	static final int si_local_code     		= SI("��������� ���","����� ���","","");
	static final int si_branch_id    		= SI("������ ID","������ ID","","");
	static final int si_client_code       	= SI("��� �������","����� ����","","");
	static final int si_bxo_min_address 	= SI("����� ���","��� �������","","");
	static final int si_date_ishonchnoma 	= SI("���� ������������ ������������","���&#1179;���������� ��������� ������","","");
	static final int si_number_ishonchnoma 	= SI("����� ������������","��������� ������","","");
	static final int si_bxo_manager 		= SI("����������� ���","��� ���&#1179;��������","","");
	static final int si_client_name			= SI("��� �����������","�������� ����","","");
	static final int si_client_manager		= SI("�������� �����������","�������� ��&#1203;����","","");
	static final int si_remote_service		= SI("������������� ������","��������� ���������","","");
	static final int si_sms_service			= SI("��� ������","��� �������","","");
	static final int si_bxo_address			= SI("������ ����� ���","��� �&#1118;��� �������","","");
	static final int si_client_address		= SI("����� �����������","�������� �������","","");
	static final int si_bxo_schet			= SI("��������� ���� ���","��� &#1203;������&#1179;���","","");
	static final int si_client_schet		= SI("��������� ���� �����������","�������� &#1203;������&#1179;���","","");
	static final int si_client_inn			= SI("��� �����������","�������� ���","","");
	static final int si_bxo_inn				= SI("��� ���","��� ���","","");
	static final int si_client_oked			= SI("���� �����������","�������� ����","","");
	static final int si_bxo_phone			= SI("��� ���.","��� ���.","","");
	static final int si_client_phone		= SI("���. �����������","�������� ���.","","");
	static final int si_client_accountant	= SI("����.���. �����������","�������� ��� ����������","","");
	static final int si_client_lawyer		= SI("����� �����������","�������� ������","","");
	static final int si_bxo_lawyer			= SI("����� ���","��� ������","","");
	static final int si_bxo_name			= SI("��� ���","��� ����","","");
	static final int si_bxo_accountant		= SI("����. ���. ���","��� ��� ����������","","");
	static final int si_contract_state		= SI("������","������","","");
	static final int si_bxo_oked			= SI("���� ���","��� ����","","");
	static final int si_bxo_mfo				= SI("��� ���","��� ���","","");
	static final int si_contract_type		= SI("��� ��������","�������� ����","","");
	static final int si_contract_percent	= SI("������� ������ (%)","������ ��&#1179;���� (%)","","");
	static final int si_contract_number_ai	= SI("����� ���. ��������","&#1178;&#1118;����� �������� ��&#1179;���","","");
	static final int si_contract_code		= SI("��� ��. ��������","������ ������������ ����","","");

	static final int si_add_new      		= SI("���� �������� ������","","","");
	static final int si_btn_details 		= SI("��������...","","","");
	static final int si_btn_add 			= SI("�������� ��������������� ��������","?������ ���������� ������","","");
	static final int si_btn_print_contract	= SI("������","��� ����","","");
	static final int si_btn_preview			= SI("��������������� �������� ���������","��� ������ �������","","");
	static final int si_btn_delete_contract	= SI("�������","&#1038;�����","","");

//-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>
