<%@ page contentType="text/html;charset=WINDOWS-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*, com.aspose.words.*, java.io.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
	Connection conn = cods.getConnection();
	if(conn == null || user.getUserCode() == null)
		pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
	Language lang = new Language(user.getLanguageIndex(), sentences);
	pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
	request.setCharacterEncoding("WINDOWS-1251");
//	request.setCharacterEncoding("UTF-8");
//	response.setContentType("text/html;charset=WINDOWS-1251");



//-------------------------------------------------------------------------------------------------
%><t:page>
	<script src="he.js"></script>
	<script>
		alert('45454554');
		top.close();
		top.returnValue = 'R';
		parent.pageLock(false);
	</script>
	<%!
	static String replace(String s) {
		if (s != null) {
			if (s.contains("&#1179;"))
				s = s.replace("&#1179;", "?");
			if (s.contains("&#1171;"))
				s = s.replace("&#1171;", "?");
			if (s.contains("&#1178;"))
				s = s.replace("&#1178;", "?");
			if (s.contains("&#1203;"))
				s = s.replace("&#1203;", "?");
			if (s.contains("&#1202;"))
				s = s.replace("&#1202;", "?");
			if (s.contains("&#1170;"))
				s = s.replace("&#1170;", "?");
			if (s.contains("&#34;"))
				s = s.replace( "&#34;","\"");
		}
		return s;
	}
	static String replace_ins(String s) {
		if (s != null) {
			if (s.contains("?"))
				s = s.replace("?", "&#1179;");
			if (s.contains("?"))
				s = s.replace("?", "&#1171;");
			if (s.contains("?"))
				s = s.replace("?", "&#1178;");
			if (s.contains("?"))
				s = s.replace("?", "&#1203;");
			if (s.contains("?"))
				s = s.replace("?", "&#1202;");
			if (s.contains("?"))
				s = s.replace("?", "&#1170;");
			if (s.contains("\""))
				s = s.replace("\"", "&#34;");
		}
		return s;
	}
	%>
	<%
	String id = request.getParameter("id");
	String contract_number = request.getParameter("contract_number");
	String contract_date = request.getParameter("contract_date");
	String date_generate = request.getParameter("date_generate");
	String date_modify = request.getParameter("date_modify");
	String filial_code = request.getParameter("filial_code");
	String local_code = request.getParameter("local_code");
	String branch_id = request.getParameter("branch_id");
	String client_id = request.getParameter("client_id");
	String bxo_min_address = request.getParameter("bxo_min_address");
	String date_ishonchnoma = request.getParameter("date_ishonchnoma");
	String number_ishonchnoma = request.getParameter("number_ishonchnoma");
	String bxo_manager = request.getParameter("bxo_manager");
	String client_name = request.getParameter("client_name");
	String client_manager = request.getParameter("client_manager");
	String remote_service = request.getParameter("remote_service");
	String sms_service = request.getParameter("sms_service");
	String bxo_address = request.getParameter("bxo_address");
	String client_address = request.getParameter("client_address");
	String bxo_schet = request.getParameter("bxo_schet");
	String client_schet = request.getParameter("client_schet");
	String client_inn = request.getParameter("client_inn");
	String bxo_inn = request.getParameter("bxo_inn");
	String client_oked = request.getParameter("client_oked");
	String bxo_phone = request.getParameter("bxo_phone");
	String client_phone = request.getParameter("client_phone");
	String client_accountant = request.getParameter("client_accountant");
	String client_lawyer = request.getParameter("client_lawyer");
	String bxo_name = cods.ConvIso(request.getParameter("bxo_name"));
	String bxo_lawyer = request.getParameter("bxo_lawyer");
	String bxo_accountant = request.getParameter("bxo_accountant");
	String bxo_oked = request.getParameter("bxo_oked");
	String bxo_mfo = request.getParameter("bxo_mfo");
	String date_ishonchnoma_accountant = request.getParameter("date_ishonchnoma_accountant");
	String number_ishonchnoma_accountant = request.getParameter("number_ishonchnoma_accountant");

	String sms_service_yes = "+";
	String sms_service_no = "-";
	String remote_service_yes = "+";
	String remote_service_no = "-";

	if (sms_service.equals("1")) {
		sms_service_yes = "+";
		sms_service_no = "-";
	} else {
		sms_service_yes = "-";
		sms_service_no = "+";
	}

	if (remote_service.equals("1")) {
		remote_service_yes = "+";
		remote_service_no = "-";
	} else {
		remote_service_yes = "-";
		remote_service_no = "+";
	}
	%>
	<script>
		alert('<%=sms_service%>');
		alert('<%=remote_service%>');
	</script>
	<%

	%><script>
	alert('45454554');
	top.close();
	top.returnValue = 'R';
	parent.pageLock(false);
</script><%

	String file_name="asosiy---inn-" + client_inn + "---" + contract_date;
	OutputStream output = response.getOutputStream();
	License license = new License();
	// license.setLicense(new FileInputStream("/u01/app/oracle/webapp/iabs/ibs/zv_new/e-shartnoma/documents/Aspose.Total.Java.lic"));

	// REAL
	license.setLicense(new FileInputStream("/u01/webapp/iabs/ibs/qqb/contracts/documents/Aspose.Total.Java.lic"));

	// TEST
	// license.setLicense(new FileInputStream("/u01/app/oracle/webapp/iabs/ibs/qqb/contracts/documents/Aspose.Total.Java.lic"));

	InputStream stream = null;
	Document doc = null;

	// REAL
	if (branch_id.equals("11207")) {
		stream = new FileInputStream("/u01/webapp/iabs/ibs/qqb/contracts/documents/asosiy-20230412-yakkasaroy.docx");
	} else {
		stream = new FileInputStream("/u01/webapp/iabs/ibs/qqb/contracts/documents/asosiy-20230412---.docx");
	}


	// TEST
	// stream = new FileInputStream("/u01/app/oracle/webapp/iabs/ibs/qqb/contracts/documents/asosiy-20230412.docx");

	doc = new Document(stream);
//	doc.getRange().replace(rs.getString("key1"),rs.getString("value1"),new FindReplaceOptions(FindReplaceDirection.FORWARD));
//	String s1=client_name;

//	request.setCharacterEncoding("WINDOWS-1251");
//	request.setCharacterEncoding("UTF-8");

	doc.getRange().replace("{/contract_number/}",	contract_number,	new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/contract_date/}",		contract_date,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_name/}",			bxo_name,			new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_manager/}",		bxo_manager,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/date_ishonchnoma/}",	date_ishonchnoma,	new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/number_ishonchnoma/}",number_ishonchnoma,	new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_address/}",		bxo_address,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_min_address/}",	bxo_min_address,	new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_phone/}",			bxo_phone,			new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_accountant/}",	bxo_accountant,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_lawyer/}",		bxo_lawyer,			new FindReplaceOptions(FindReplaceDirection.FORWARD));

	doc.getRange().replace("{/bxo_mfo/}",			bxo_mfo,			new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_oked/}",			bxo_oked,			new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_inn/}",			bxo_inn,			new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/bxo_schet/}",			bxo_schet,			new FindReplaceOptions(FindReplaceDirection.FORWARD));

	doc.getRange().replace("{/client_name/}",		client_name,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_manager/}",	client_manager,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_phone/}",		client_phone,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_accountant/}",	client_accountant,	new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_lawyer/}",		client_lawyer,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_schet/}",		client_schet,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_inn/}",		client_inn,			new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_oked/}",		client_oked,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_inn/}",		client_inn,			new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/client_address/}",	client_address,		new FindReplaceOptions(FindReplaceDirection.FORWARD));

	doc.getRange().replace("{/sms_service_yes/}",	sms_service_yes,	new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/sms_service_no/}",	sms_service_no,		new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/remote_service_yes/}",remote_service_yes,	new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/remote_service_no/}",	remote_service_no,	new FindReplaceOptions(FindReplaceDirection.FORWARD));

	doc.getRange().replace("{/date_ishonchnoma_accountant/}",	date_ishonchnoma_accountant,	new FindReplaceOptions(FindReplaceDirection.FORWARD));
	doc.getRange().replace("{/number_ishonchnoma_accountant/}",	number_ishonchnoma_accountant,	new FindReplaceOptions(FindReplaceDirection.FORWARD));


	stream.close();
	ByteArrayOutputStream dstStream = new ByteArrayOutputStream();
	doc.save(dstStream, SaveFormat.DOC);
	response.setContentType("application/msword");
	response.setHeader("Content-Disposition", "filename=\""+file_name+".doc\"");

	%><script>
		alert('45454554');
		top.close();
		top.returnValue = 'R';
		parent.pageLock(false);
	</script><%

	output.write(dstStream.toByteArray());

%>


	<script>
		alert('45454554');
		top.close();
		top.returnValue = 'R';
		parent.pageLock(false);
	</script>


	<script src="util/js/passport_reader.js"></script>

	<script>
		function onLoad() {
			if (top.location.toString()) {
				if (top.location.toString().indexOf("modal") > -1) {
					showDOM("btnFill");
					if (getDOM("btnFill")) {
						getDOM("btnFill").disabled = true;
					}
				}
			}
		}
		function getObj(v) {
			window.returnValue = [ht.getObject(), ht.getAllKeys()];
			top.close();
		}
	</script>

	<style>
		#loader{
			margin-top:20px;
			position:absolute;
			left:40%;
			top:25%;
			z-index:10;
			background:transparent;
		}
		#bar{
			width:0;
			height:15px;
			margin-left:0;
			z-index:9;
			position:relative;
		}
		#outBar{
			width:155px;
			border:1px solid gray;
			height:15px;
			vertical-align:top;
			margin-left:5px;
			color:black;
			position:relative;
		}
		#forTxt{
			position:absolute;
			width:20px;
			height:10px;
			margin-left:5px;
			font-size:10pt;
			left:110px;
			top:0px;
		}
		.btn{
			padding:0 3px 0 3px;
			width:0;
			overflow:visible;
			margin-left:15px;
		}
		#barTXT{
			position:absolute;
			z-index:11;
			width:100%;
		}
		.personPhoto,.icone{
			margin-left:2px;
			width: 155px;
			height: 190px;
		}
		table{
			border-collapse: collapse;
			font-size:12pt;
		}
		form{
			vertical-align: top;
		}
		.inputSecund{
			border-top:none !important;
			border-left:none !important;
			border-right:none !important;
		}
		fieldset {
			margin-top: 15px !important;
		}
	</style>
	<t:form titleText="Данные из считывателя" minWidth="fill" minHeight="fill">
		<img id="loader"  style="display:none" src='util/img/5.gif'>
		<form method="POST" name="fm" target="frm">
			<table cellpadding="2" cellspacing="2" class="formToolbar">
				<col align="right" width="30%" style="font-weight:bolder">
				<col width="60%">
				<col width="10%" align="right">
				<tr>
<%--					<td>--%>
<%--						<input type="button" id="btnFromServ" onclick="FromServer()" class="btn" value="Считать данные">--%>
<%--						<input type="button" id="btnFromService" onclick="readFromService()" class="btn" value="Данные из сервиса">--%>
<%--					</td>--%>
					<td>
						<input type="button" id="btnCompareFaces" onclick="FormCompareFace()" class="btn" value="Шартнома яратиш">
						<input type="button" id="btnFill" style="display:none" onclick="getObj()" class="btn" value="Вставить">
					</td>
					<td>
						<input type="button" id="btnRefresh" onclick="javascript:go({})" value="Обновить">
					</td>
					<td align=right>
						<input type=button value='Закрыть' onclick="window.close();">
					</td>
				</tr>
			</table>
			<div id="basepanel" class="panel">
				<fieldset><legend>Ташкилот реквизитлари</legend>
					<table cellpadding="2" cellspacing="2" style="padding: 15px !important; border-collapse: separate !important;">
						<col align="right" width="12%" style="font-weight:bolder" />
						<col width="6%" />
						<col width="32%" style="font-weight:bolder" />
						<col align="right" width="12%" style="font-weight:bolder" />
						<col width="6%" />
						<col width="32%" style="font-weight:bolder" />

						<tr>
							<td><%= lang.get(si_contract_number)%>:</td>
							<td colspan="3">
								<input name="Name" style="width:100%"  />
							</td>
							<td><%= lang.get(si_contract_date)%>:</td>
							<td colspan="3">
								<input name="Name" style="width:100%" readOnly value="<%=contract_date%>" />
							</td>
						</tr>

					</table>
				</fieldset>
				<fieldset><legend>Ташкилот реквизитлари</legend>
					<table cellpadding="2" cellspacing="2" style="padding: 15px !important; border-collapse: separate !important;">
						<col align="right" width="25%" style="font-weight:bolder" />
						<col width="10%" />
						<col width="65%" style="font-weight:bolder" />

						<tr>
							<td><%= lang.get(si_client_name)%>:</td>
							<td colspan="3">
								<input name="Name" style="width:100%" readOnly value="<%=client_name.replaceAll("\"", "&quot;")%>" />
							</td>
						</tr>
						<tr>
							<td><%= lang.get(si_client_schet)%>:</td>
							<td colspan="3">
								<input name="Issuer" style="width:100%" readOnly value="<%=client_schet%>" />
							</td>
						</tr>
						<tr>
							<td><%= lang.get(si_client_inn)%>:</td>
							<td colspan="3">
								<input name="Surname" style="width:100%" readOnly value="<%=client_inn%>"/>
							</td>
						</tr>
						<tr>
							<td><%= lang.get(si_client_manager)%>:</td>
							<td colspan="3">
								<input name="BirthDate" style="width:100%" readOnly value="<%=client_manager%>"/>
							</td>
						</tr>
						<tr>
							<td><%= lang.get(si_client_accountant)%>:</td>
							<td colspan="3">
								<input name="Nationality" style="width:100%" readOnly value="<%=client_accountant%>" />
							</td>
						</tr>
						<tr>
							<td><%= lang.get(si_client_oked)%>:</td>
							<td colspan="3">
								<input name="ExpiryDate" style="width:100%" readOnly value="<%=client_oked%>" />
							</td>

						</tr>
						<tr>
							<td><%= lang.get(si_client_phone)%>:</td>
							<td colspan="3">
								<input name="ExpiryDate" style="width:100%" readOnly value="<%=client_phone%>" />
							</td>

						</tr>
						<tr>
							<td><%= lang.get(si_client_address)%>:</td>
							<td colspan="3">
								<input name="ExpiryDate" style="width:100%" readOnly value="<%=client_address.replaceAll("\"", "&quot;")%>" />
							</td>

						</tr>
					</table>
				</fieldset>
				<fieldset><legend>БХО (БХМК) реквизитлари</legend>
					<table cellpadding="2" cellspacing="2" style="padding: 15px !important; border-collapse: separate !important;">
						<col align="right" width="25%" style="font-weight:bolder" />
						<col width="10%" />
						<col width="65%" style="font-weight:bolder" />
					<tr>
						<td><%= lang.get(si_bxo_name)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_name%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_bxo_address)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_address.replaceAll("\"", "&quot;")%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_branch_id)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=branch_id%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_bxo_schet)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_schet%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_bxo_inn)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_inn%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_bxo_oked)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_oked%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_bxo_phone)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_phone%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_bxo_manager)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_manager%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_bxo_accountant)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_accountant%>" />
						</td>
					</tr>
					<tr>
						<td><%= lang.get(si_bxo_lawyer)%>:</td>
						<td colspan="3">
							<input name="Line1" style="width:100%" readOnly value="<%=bxo_lawyer%>" />
						</td>
					</tr>
				</table>

		</fieldset>
			</div>
		</form>
		<form name="fromService">
			<fieldset><legend>Предварительный просмотр</legend>

			</fieldset>
		</form>
		</div>
	</t:form>
</t:page><%!
	static final int si_title           	= SI("Создать договор3","Шартнома яратиш2","","");
	static final int si_id              	= SI("Ид.","Ид.","","");
	static final int si_contract_number 	= SI("Номер договора","Шартнома ра&#1179;ами","","");
	static final int si_contract_date   	= SI("Дата договора","Шартнома санаси","","");
	static final int si_date_generate   	= SI("Дата генерации договора","Шартнома генерация &#1179;илинган ва&#1179;т","","");
	static final int si_date_modify     	= SI("Дата модификации договора","Шартнома &#1118;згартирилган ва&#1179;т","","");
	static final int si_filial_code     	= SI("Код филиала","Филиал коди","","");
	static final int si_local_code     		= SI("Локольный код","Локал код","","");
	static final int si_branch_id    		= SI("Филиал Ид.","Филиал Ид.","","");
	static final int si_client_id       	= SI("Код клиента","Мижоз коди","","");
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
	static final int si_add_new				= SI("Создать новый договор","Янги шартнома яратиш","","");
	static final int si_btn_details1		= SI("Подробно1...","Батафсил1...","","");
	static final int si_btn_details2		= SI("Подробно2...","Батафсил2...","","");
	static final int si_btn_details3		= SI("Подробно3...","Батафсил3...","","");

	static final int si_bxo_name			= SI("Название БХО","БХО номи","","");
	static final int si_bxo_oked			= SI("ОКЭД БХО","БХО ОКЭД","","");
	static final int si_bxo_accountant		= SI("Глав.бух. БХО","БХО бош хисобчиси","","");


	static final int si_surname			= SI("Фамилия","","","");
	static final int si_birthdate		= SI("Дата рождения","","","");
	static final int si_nationality		= SI("Национальность","","","");
	static final int si_document_type	= SI("Тип документа","","","");
	static final int si_sex				= SI("Пол","","","");
	static final int si_additional		= SI("Дополнительный","","","");
	static final int si_pinpp			= SI("Пинпп","","","");
	static final int si_date			= SI("Дата","","","");

//----------------------------------------------------------------------------------------------------	
%><%@ include file="/language.jsp" %>