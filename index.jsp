<%@ page contentType="text/html;charset=WINDOWS-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*,oracle.sql.*, oracle.jdbc.driver.*" %><%
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
	try{
		storedObj.setConnection(conn, "80201");
	}
	catch (Exception e){
		Util.alertUserMessage(e, out);
	}
	//String user_access = storedObj.execFunction("qqb_kredit.Get_Access_user");

//	String filial_code = (String)session.getValue("filialCode");
//-------------------------------------------------------------------------------------------------
%>
<t:page><%
	String where_condition = "1=1";
	String current_filial_code = stored.execFunction("setup.get_filial_code()");
	String filial_code = (String)session.getValue("filialCode");
%>

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

		function addNew() {
		    if (go({
				url: "add.jsp",
				lock: false,
				target: 'modalE',
				dialogWidth: 500,
				dialogHeight: 300
		    }))
		        go({});

		}

        function previewContract2() {
            if (go({
                url: "preview2.jsp",
                param: {
					id:			        getData(1),
					contract_number:	getData(2),
					contract_date:		getData(3),
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
					remote_service:		getData(16),
					sms_service:		getData(17),
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
					bxo_name: 			getData(30),
					bxo_accountant:		getData(31),
					contract_state:		getData(32),
					bxo_oked:			getData(33),
					bxo_mfo:			getData(34),
					contract_type:		getData(35),
					contract_percent:	getData(36),
					contract_code:      getData(37)
                },
                lock: false,
                target: 'modalE',
                dialogWidth: 1200,
                dialogHeight: 600
            }))
                go({});

        }

		function printContract() {
		    if (go({
				url: "print.jsp",
				param: {
				    id:			        getData(1),
					contract_number:	getData(2),
					contract_date:		getData(3),
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
					remote_service:		getData(16),
					sms_service:		getData(17),
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
                    bxo_name: 			getData(30),
                    bxo_accountant:		getData(31),
					bxo_oked:			getData(33),
					bxo_mfo:			getData(34),
					date_ishonchnoma_accountant:	getData(41),
					number_ishonchnoma_accountant:	getData(42)
				},
				lock: false,
				target: 'modalE',
				dialogWidth: 1000,
				dialogHeight: 800
		    }))
		    	go({});
		}

		function showParams() {
		    if (go({
				url: "main_params.jsp"
				,lock: false
				,target: 'modalE'
				// ,dialogWidth: 1000
				// ,dialogHeight: 800
				,dialogFill: true
		    }))
		    	go({});
		}

		function onSelect() {
			const btn = document.getElementById('delete');
			if (getData(32)!=='D') {
				btn.setAttribute('disabled', '');
			} else {
				btn.removeAttribute('disabled');
			}
			const btn2 = document.getElementById('print');
			if (getData(32)!=='R') {
				btn2.setAttribute('disabled', '');
			} else {
				btn2.removeAttribute('disabled');
			}
			go({
				url: 'rekvizitlar.jsp',
				target: rekvizitlar,
				param: {
					contract_code:	getData(37),
					contract_state:	getData(32)
				},
				lock: false});
		}

		function deleteContract() {
			if (go({
				url: "delete_contract.jsp",
				param: {
					id:			        getData(1),
					contract_type:		getData(35),
                    contract_number:	getData(2),
                    contract_date:		getData(3),
                    bxo_name:		    getData(30),
                    client_name:        getData(14)

				},
				lock: false,
				target: 'modalE',
				dialogWidth: 1000,
				dialogHeight: 800
			})) go({});
		}

	</script>
	<t:form titleText="<%=lang.get(si_title)%>" minWidth="fill" minHeight="fill">
		<iframe name=frm style="display:none"></iframe>
		<table class=formToolbar cellspacing=2>
			<tr>
				<td>
					<input type=button name="addNew" onclick="addNew()" value="<%=lang.get(si_add_new)%>">
					<input type=button name="preview" onclick="previewContract2()" value="<%=lang.get(si_btn_preview_contract)%>">
					<input type=button name="print" id="print" onclick="printContract()" value="<%=lang.get(si_btn_print_contract)%>">
					<input type=button name="delete" id="delete" onclick="deleteContract()" value="<%=lang.get(si_btn_delete_contract)%>">
					<input type=button name="params" onclick="showParams()" value="<%=lang.get(si_btn_params)%>">
				<td align=right id=tableControls>
					<input type=button onclick="go({url:'../../contents.jsp'})" value="о">
		</table>
		<table width="100%" align=center cellspacing=0 cellpadding=0>
			<tr>
				<td>
					<t:table from="QQB_E_SHARTNOMA_V" where="<%=where_condition%>">
						<t:field id="1"  name="ID" 					label="<%=si_id%>"/>
						<t:field id="2"  name="CONTRACT_NUMBER" 	label="<%=si_contract_number%>" type="quote"/>
						<t:field id="3"  name="CONTRACT_DATE" 		label="<%=si_contract_date%>" type="date"/>
						<t:field id="4"  name="DATE_GENERATE" 		label="<%=si_date_generate%>" type="datetime"/>
						<t:field id="5"  name="DATE_MODIFY" 		label="<%=si_date_modify%>" type="datetime"/>
						<t:field id="6"  name="FILIAL_CODE" 		label="<%=si_filial_code%>"/>
						<t:field id="7"  name="LOCAL_CODE" 			label="<%=si_local_code%>"/>
						<t:field id="8"  name="BRANCH_ID" 			label="<%=si_branch_id%>"/>
						<t:field id="9"  name="CLIENT_CODE" 		label="<%=si_client_code%>"/>
						<t:field id="10" name="BXO_MIN_ADDRESS"		label="<%=si_bxo_min_address%>" type="quote"/>
						<t:field id="11" name="DATE_ISHONCHNOMA" 	label="<%=si_date_ishonchnoma%>" type="date"/>
						<t:field id="12" name="NUMBER_ISHONCHNOMA" 	label="<%=si_number_ishonchnoma%>" type="quote"/>
						<t:field id="13" name="BXO_MANAGER" 		label="<%=si_bxo_manager%>" type="quote"/>
						<t:field id="14" name="CLIENT_NAME" 		label="<%=si_client_name%>" type="quote"/>
						<t:field id="15" name="CLIENT_MANAGER" 		label="<%=si_client_manager%>" type="quote"/>
						<t:field id="16" name="REMOTE_SERVICE" 		label="<%=si_remote_service%>"/>
						<t:field id="17" name="SMS_SERVICE" 		label="<%=si_sms_service%>"/>
						<t:field id="18" name="BXO_ADDRESS" 		label="<%=si_bxo_address%>" type="quote"/>
						<t:field id="19" name="CLIENT_ADDRESS" 		label="<%=si_client_address%>" type="quote"/>
						<t:field id="20" name="BXO_SCHET" 			label="<%=si_bxo_schet%>"/>
						<t:field id="21" name="CLIENT_SCHET"		label="<%=si_client_schet%>"/>
						<t:field id="22" name="CLIENT_INN" 			label="<%=si_client_inn%>"/>
						<t:field id="23" name="BXO_INN" 			label="<%=si_bxo_inn%>"/>
						<t:field id="24" name="CLIENT_OKED" 		label="<%=si_client_oked%>"/>
						<t:field id="25" name="BXO_PHONE" 			label="<%=si_bxo_phone%>" type="quote"/>
						<t:field id="26" name="CLIENT_PHONE" 		label="<%=si_client_phone%>" type="quote"/>
						<t:field id="27" name="CLIENT_ACCOUNTANT" 	label="<%=si_client_accountant%>" type="quote"/>
						<t:field id="28" name="CLIENT_LAWYER" 		label="<%=si_client_lawyer%>" type="quote"/>
						<t:field id="29" name="BXO_LAWYER" 			label="<%=si_bxo_lawyer%>" type="quote"/>
						<t:field id="30" name="BXO_NAME" 			label="<%=si_bxo_name%>" type="quote"/>
						<t:field id="31" name="BXO_ACCOUNTANT" 		label="<%=si_bxo_accountant%>" type="quote"/>
						<t:field id="32" name="CONTRACT_STATE" 		label="<%=si_contract_state%>" type="quote"/>
						<t:field id="33" name="BXO_OKED" 			label="<%=si_bxo_oked%>" type="quote"/>
						<t:field id="34" name="BXO_MFO" 			label="<%=si_bxo_mfo%>" type="quote"/>
						<t:field id="35" name="CONTRACT_TYPE" 		label="<%=si_contract_type%>" type="quote"/>
						<t:field id="36" name="CONTRACT_PERCENT" 	label="<%=si_contract_percent%>" type="quote"/>
						<t:field id="37" name="CONTRACT_CODE" 		label="<%=si_contract_code%>" type="quote"/>
						<t:field id="38" name="EMPLOYEE_CODE" 		label="<%=si_employee_code%>" type="quote"/>
						<t:field id="39" name="EMPLOYEE_FILIAL_CODE" label="<%=si_employee_filial_code%>" type="quote"/>
						<t:field id="40" name="SETUP_BRANCH_ID"     label="<%=si_setup_branch_id%>" type="quote"/>
						<t:field id="41" name="DATE_ISHONCHNOMA_ACCOUNTANT" 	label="<%=si_date_ishonchnoma_accountant%>" type="date"/>
						<t:field id="42" name="NUMBER_ISHONCHNOMA_ACCOUNTANT" 	label="<%=si_number_ishonchnoma_accountant%>" type="quote"/>
						<t:grid page="25" numbering="" rowColor="(d(32)=='D'?'red':d(32)=='R'?'green':'blue')">
							<t:column for="1"/>
							<t:column for="2"/>
							<t:column for="3"/>
							<t:column for="5"/>
							<t:column for="8"/>
							<t:column for="9"/>
							<t:column for="14"/>
							<t:column for="15"/>
							<t:column for="17"/>
							<t:column for="16"/>
							<t:column for="21"/>
							<t:column for="22"/>
							<t:column for="32"/>
							<t:column for="35"/>
							<t:column for="37"/>
							<t:foot>
								<t:row>
									<t:cell for="3" size="100%" align="left"/>
									<t:cell for="4" size="100%" align="left"/>
                                    <t:cell for="5" size="100%" align="left"/>
                                    <t:cell for="8" size="100%" align="left"/>
								</t:row>
								<t:row>
									<t:cell for="9" size="100%" align="left"/>
									<t:cell for="10" size="100%" align="left"/>
									<t:cell for="11" size="100%" align="left"/>
									<t:cell for="12" size="100%" align="left"/>
								</t:row>
								<t:row>
									<t:cell for="13" size="100%" align="left"/>
									<t:cell for="14" size="100%" align="left"/>
									<t:cell for="15" size="100%" align="left"/>
									<t:cell for="18" size="100%" align="left"/>
								</t:row>
								<t:row>
									<t:cell for="19" size="100%" align="left"/>
									<t:cell for="20" size="100%" align="left"/>
									<t:cell for="21" size="100%" align="left"/>
									<t:cell for="22" size="100%" align="left"/>
								</t:row>
								<t:row>
									<t:cell for="25" size="100%" align="left"/>
									<t:cell for="26" size="100%" align="left"/>
									<t:cell for="23" size="100%" align="left"/>
									<t:cell for="24" size="100%" align="left"/>
								</t:row>
								<t:row>
									<t:cell for="27" size="100%" align="left"/>
									<t:cell for="28" size="100%" align="left"/>
									<t:cell for="38" size="100%" align="left"/>
									<t:cell for="39" size="100%" align="left"/>
								</t:row>
                                <t:row>
                                    <t:cell for="40" size="100%" align="left"/>
									<t:cell for="41" size="100%" align="left"/>
									<t:cell for="42" size="100%" align="left"/>
                                </t:row>
							</t:foot>

						</t:grid>
					</t:table>
				</td>
			</tr>
			<tr>
				<td>
					<iframe width=100% height=250 name=rekvizitlar></iframe>
				</td>
			</tr>
		</table>
	</t:form>
</t:page>

<%!
	static final int si_title           	= SI("Управление договора","Шартномаларни &#1203;исобини юритиш","","");
	static final int si_id              	= SI("ID","ID","","");
	static final int si_contract_number 	= SI("Номер договора","Шартнома ра&#1179;ами","","");
	static final int si_contract_date   	= SI("Дата договора","Шартнома санаси","","");
	static final int si_date_generate   	= SI("Дата генерации договора","Шартнома генерация &#1179;илинган ва&#1179;т","","");
	static final int si_date_modify     	= SI("Дата модификации договора","Шартнома &#1118;згартирилган ва&#1179;т","","");
	static final int si_filial_code     	= SI("Код филиала","Филиал коди","","");
	static final int si_local_code     		= SI("Локольный код","Локал код","","");
	static final int si_branch_id    		= SI("Филиал ID","Филиал ID","","");
	static final int si_client_code       	= SI("Код клиента","Мижоз коди","","");
	static final int si_bxo_min_address 	= SI("Адрес БХО","БХО манзили","","");
	static final int si_date_ishonchnoma 	= SI("Дата доверенности управляющего","Бош&#1179;арувчининг ишончнома санаси","","");
	static final int si_number_ishonchnoma 	= SI("Номер доверенности","Ишончнома номери","","");
	static final int si_bxo_manager 		= SI("Управляюший БХО","БХО бош&#1179;арувчиси","","");
	static final int si_client_name			= SI("Имя организации","Ташкилот номи","","");
	static final int si_client_manager		= SI("Директор организации","Ташкилот ра&#1203;бари","","");
	static final int si_remote_service		= SI("Дистанционные услуги","Масофавий хизматлар","","");
	static final int si_sms_service			= SI("СМС услуги","СМС хизмати","","");
	static final int si_bxo_address			= SI("Полный адрес БХО","БХО т&#1118;лик манзили","","");
	static final int si_client_address		= SI("Адрес организации","Ташкилот манзили","","");
	static final int si_bxo_schet			= SI("Расчётный счёт БХО","БХО &#1203;исобра&#1179;ами","","");
	static final int si_client_schet		= SI("Расчётный счёт организации","Ташкилот &#1203;исобра&#1179;ами","","");
	static final int si_client_inn			= SI("ИНН организации","Ташкилот ИНН","","");
	static final int si_bxo_inn				= SI("ИНН БХО","БХО ИНН","","");
	static final int si_client_oked			= SI("ОКЭД организации","Ташкилот ОКЭД","","");
	static final int si_bxo_phone			= SI("БХО тел.","БХО тел.","","");
	static final int si_client_phone		= SI("Тел. организации","Ташкилот тел.","","");
	static final int si_client_accountant	= SI("Глав.бух. организации","Ташкилот бош бухгалтери","","");
	static final int si_client_lawyer		= SI("Юрист организации","Ташкилот юристи","","");
	static final int si_bxo_lawyer			= SI("Юрист БХО","БХО юристи","","");
	static final int si_bxo_name			= SI("Имя БХО","БХО номи","","");
	static final int si_bxo_accountant		= SI("Глав. бух. БХО","БХО бош бухгалтери","","");
	static final int si_contract_state		= SI("Статус","Холати","","");
	static final int si_bxo_oked			= SI("ОКЭД БХО","БХО ОКЭД","","");
	static final int si_bxo_mfo				= SI("МФО БХО","БХО МФО","","");
	static final int si_contract_type		= SI("Тип договора","Шартнома тури","","");
	static final int si_contract_percent	= SI("Процент услуги (%)","Хизмат ми&#1179;дори (%)","","");
	static final int si_contract_code		= SI("Код гл. договора","Асосий шартноманинг коди","","");
	static final int si_employee_code		= SI("Код работника","Ишчининг коди","","");
	static final int si_employee_filial_code= SI("Код филиала работника","Ишчининг филиал коди","","");
	static final int si_setup_branch_id     = SI("BranchID (Setup)","Ишчининг филиал коди","","");

	static final int si_date_ishonchnoma_accountant     = SI("Дата доверенности бухгалтера","Бухгалтернинг ишончнома санаси","","");
	static final int si_number_ishonchnoma_accountant   = SI("Номер доверенности бухгалтера","Бухгалтернинг ишончнома номери","","");


	static final int si_add_new					= SI("Создание основного контракта","Асосий шартномани яратиш","","");
	static final int si_btn_details1			= SI("Подробно1...","Батафсил1...","","");
	static final int si_btn_print_contract		= SI("Печать","Чоп этиш","","");
	static final int si_btn_preview_contract 	= SI("Предварительный просмотр документа","Чоп этишга тайёрлаш","","");
	static final int si_btn_details3			= SI("Подробно3...","Батафсил3...","","");
	static final int si_btn_params				= SI("Параметры","Параметрлар","Parametrlar","Options");
	static final int si_btn_delete_contract		= SI("Удалить","&#1038;чириш","","");



%>
<%
	//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>