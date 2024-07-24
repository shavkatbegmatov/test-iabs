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

//	String client_id = request.getParameter("client_id");
//	String filial_code = (String)session.getValue("filialCode");

%>
<t:page>
<%--	<link rel="stylesheet" href="bootstrap.min.css">--%>
<%
	String id = request.getParameter("id");
	String contract_number = request.getParameter("contract_number");
	String contract_date = request.getParameter("contract_date");

	String branch_id = request.getParameter("branch_id");
	String client_code = request.getParameter("client_code");
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
	String client_oked = request.getParameter("client_oked");
	String bxo_phone = request.getParameter("bxo_phone");
	String client_phone = request.getParameter("client_phone");


	String client_accountant = request.getParameter("client_accountant");
	String client_lawyer = request.getParameter("client_lawyer");





	String bxo_inn = request.getParameter("bxo_inn");


	String bxo_lawyer = request.getParameter("bxo_lawyer");
	String bxo_name = request.getParameter("bxo_name");
	String bxo_oked = request.getParameter("bxo_oked");
	String bxo_accountant = request.getParameter("bxo_accountant");

	String filial_code = request.getParameter("filial_code");
	String local_code = request.getParameter("local_code");
	String date_generate = request.getParameter("date_generate");
	String date_modify = request.getParameter("date_modify");

    String sms_service_checked = sms_service.equals("1") ? "checked" : "";
    String remote_service_checked = remote_service.equals("1") ? "checked" : "";
    String contract_type = request.getParameter("contract_type");
    String contract_percent = request.getParameter("contract_percent");
    String contract_number_ai = request.getParameter("contract_number_ai");
    String contract_state = request.getParameter("contract_state");

    String contract_number_readonly = "";
    if (contract_type.equals("A")) {
		contract_number = contract_number + "/" + (contract_number_ai + 1).toString();
		contract_number_readonly = "readonly";
		contract_date = stored.execFunction("setup.get_operday");
	}

%>
	<script>
        function getObj(v) {
            window.returnValue = [ht.getObject(), ht.getAllKeys()];
            top.close();
        }
	</script>
	<style>

	</style>
	<t:form title="<%=si_form_title %>" minWidth="fill" minHeight="fill">
		<iframe name="frm" style="display:none"></iframe>
		<form name="fm" target="frm">
			<input type="hidden" name="request" value="preview_update">
			<input type="hidden" name=client_id>
			<input type="hidden" name=id value="<%=id%>">
			<input type="hidden" name=contract_type value="<%=contract_type%>">
			<input type="hidden" name=contract_number_ai value="<%=contract_number_ai%>">
			<input type="hidden" name=contract_state value="<%=contract_state%>">
			<div style="
				padding: 5px;
				margin-bottom: 10px;
				box-shadow: 0 5px 5px rgb(86,139,191);
			">
				<table style=" margin-left: 25px;">
					<col width="80%">
					<col width="10%">
					<col width="10%">
					<tr>
						<td>
							<input type="submit" id="save"  name="save" value="Са&#1179;лаш">
						</td>
						<td align="right">
							<input onclick="window.close()" type="button" name="exit" value="Чи&#1179;иш">
						</td>
					</tr>
				</table>
			</div>

			<div id="basepanel" class=panel>
				<div id="main">

					<fieldset><legend><%= lang.get(si_field_title_1)%>:</legend>
						<table cellpadding="2" cellspacing="2" style="padding: 15px !important; border-collapse: separate !important; width:100%;">
							<col text-align="right" width="16%" style="font-weight:bolder; text-align:right;" />
							<col width="10%" />
							<col text-align="right" width="16%" style="font-weight:bolder" />
							<col width="10%" style="font-weight:bolder" />
							<col text-align="right" width="16%" />
							<col width="32%" style="font-weight:bolder" />
							<tr>
								<td style="text-align: right;"><%= lang.get(si_contract_number)%>:</td>
								<td>
									<input <%=contract_number_readonly%> name="contract_number" style="width:100%"  value="<%=contract_number%>" />
								</td>
								<td style="text-align: right;"><%= lang.get(si_contract_date)%>:</td>
								<td>
									<input name="contract_date" style="width:100%" readOnly value="<%=contract_date%>" />
								</td>
								<td style="text-align: right;"><%= lang.get(si_bxo_name)%>:</td>
								<td>
									<input name="bxo_name" style="width:100%" readOnly value="<%=bxo_name%>" />
								</td>
							</tr>
						</table>
					</fieldset>
					<fieldset class="info">
						<legend><%= lang.get(si_field_title_2)%></legend>
						<table style="margin-left: 25px;">
							<tr>
								<td>
									<label for="sms_service" style="user-select: none;">SMS-банкинг</label>
									<input id="sms_service" name="sms_service" type="checkbox" <%=sms_service_checked%> style="" />
								</td>
								<td>
									<label for="remote_service" style="user-select: none;">Масофадан хизмат кўрсатиш тизими</label>
									<input id="remote_service" name="remote_service" type="checkbox" <%=remote_service_checked%> style="" />
								</td>
                                <% if(!contract_type.equals("M")) { %>
								<td>
									<label for="percent" style="user-select: none;">Дебет айланма учун олинадиган &#1203;а&#1179; ми&#1179;дори</label>
									<input id="percent" name="contract_percent" mask="3|{0-9,.}" size="3" type="text" <%=contract_percent%> style="" />%
								</td>
                                <% } %>
							</tr>
						</table>
					</fieldset>
					<fieldset><legend><%= lang.get(si_field_title_3)%></legend>
						<table cellpadding="2" cellspacing="2" style="padding: 15px !important; border-collapse: separate !important; width:100%;">
							<colgroup>
								<col width="12%" />
								<col width="0.3%" />
								<col width="15%" />
								<col width="1%" />

								<col width="8%" />
								<col width="0.3%" />
								<col width="11%" />
								<col width="1%" />

								<col width="10%" />
								<col width="0.3%" />
								<col width="13%" />
							</colgroup>
							<tr>
								<td style="text-align: right;"><%= lang.get(si_client_name)%>:</td>
								<td></td>
								<td colspan="13">
									<input name="client_name" style="width:100%" readOnly value="<%=client_name.replaceAll("\"", "&quot;")%>" />
								</td>
								<td></td>
							</tr>
							<tr>
								<td style="text-align: right;"><%= lang.get(si_client_schet)%>:</td>
								<td></td>
								<td>
									<input name="client_schet" style="width:100%" readOnly value="<%=client_schet%>" />
								</td>
								<td></td>

								<td style="text-align: right;"><%= lang.get(si_client_inn)%>:</td>
								<td></td>
								<td>
									<input name="client_inn" style="width:100%" readOnly value="<%=client_inn%>"/>
								</td>
								<td></td>

								<td style="text-align: right;"><%= lang.get(si_client_oked)%>:</td>
								<td></td>
								<td>
									<input name="client_oked" style="width:100%" readOnly value="<%=client_oked%>" />
								</td>
								<td></td>

								<td style="text-align: right;"><%= lang.get(si_client_phone)%>:</td>
								<td></td>
								<td>
									<input name="client_phone" style="width:100%" readOnly value="<%=client_phone%>" />
								</td>
							</tr>
							<tr>
								<td style="text-align: right;"><%= lang.get(si_client_manager)%>:</td>
								<td></td>
								<td colspan="3">
									<input name="client_manager" style="width:100%" readOnly value="<%=client_manager%>"/>
								</td>
								<td></td>

								<td style="text-align: right;"><%= lang.get(si_client_accountant)%>:</td>
								<td></td>
								<td colspan="3">
									<input name="client_accountant" style="width:100%" readOnly value="<%=cods.ConvIso(client_accountant)%>" />
								</td>
								<td></td>

								<td style="text-align: right;"><%= lang.get(si_client_lawyer)%>:</td>
								<td></td>
								<td colspan="1">
									<input name="client_lawyer" style="width:100%" readOnly value="<%=cods.ConvIso(client_lawyer)%>" />
								</td>
							</tr>
							<tr>
								<td style="text-align: right;"><%= lang.get(si_client_address)%>:</td>
								<td></td>
								<td colspan="13">
									<input name="client_address" style="width:100%" readOnly value="<%=client_address.replaceAll("\"", "&quot;")%>" />
								</td>
								<td></td>
							</tr>
						</table>
					</fieldset>
					<fieldset><legend><%= lang.get(si_field_title_4)%></legend>
<%--                        БХО (БХМК) реквизитлари--%>
						<table cellpadding="2" cellspacing="2" style="padding: 15px !important; border-collapse: separate !important; width:100%;">
							<colgroup>
								<col width="8%" />
								<col width="0.3%" />
								<col width="15%" />
								<col width="1%" />

								<col width="10%" />
								<col width="0.3%" />
								<col width="13%" />
								<col width="1%" />

								<col width="10%" />
								<col width="0.3%" />
								<col width="15%" />
							</colgroup>
							<tr>
								<td style="text-align: right;"><%= lang.get(si_bxo_name)%>:</td>
								<td></td>
								<td>
									<input name="bxo_name" style="width:100%" readOnly value="<%=bxo_name%>" />
								</td>
								<td></td>

                                <td style="text-align: right;"><%= lang.get(si_bxo_schet)%>:</td>
                                <td></td>
                                <td>
                                    <input name="bxo_schet" style="width:100%" readOnly value="<%=bxo_schet%>" />
                                </td>
                                <td></td>

                                <td style="text-align: right;"><%= lang.get(si_bxo_inn)%>:</td>
                                <td></td>
                                <td>
                                    <input name="bxo_inn" style="width:100%" readOnly value="<%=bxo_inn%>" />
                                </td>

							</tr>
							<tr>
                                <td style="text-align: right;"><%= lang.get(si_bxo_phone)%>:</td>
                                <td></td>
                                <td>
                                    <input name="bxo_phone" style="width:100%" readOnly value="<%=bxo_phone%>" />
                                </td>
                                <td></td>


                                <td style="text-align: right;"><%= lang.get(si_branch_id)%>:</td>
                                <td></td>
                                <td>
                                    <input name="branch_id" style="width:100%" readOnly value="<%=branch_id%>" />
                                </td>
                                <td></td>


								<td style="text-align: right;"><%= lang.get(si_bxo_oked)%>:</td>
								<td></td>
								<td>
									<input name="bxo_okid" style="width:100%" readOnly value="<%=bxo_oked%>" />
								</td>
							</tr>
							<tr>
                                <td style="text-align: right;"><%= lang.get(si_bxo_manager)%>:</td>
                                <td></td>
                                <td>
                                    <input name="bxo_manager" style="width:100%" readOnly value="<%=bxo_manager%>" />
                                </td>
                                <td></td>

                                <td style="text-align: right;"><%= lang.get(si_bxo_accountant)%>:</td>
                                <td></td>
                                <td>
                                    <input name="bxo_accountant" style="width:100%" readOnly value="<%=bxo_accountant%>" />
                                </td>
                                <td></td>

                                <td style="text-align: right;"><%= lang.get(si_bxo_lawyer)%>:</td>
                                <td></td>
                                <td>
                                    <input name="bxo_lawyer" style="width:100%" readOnly value="<%=bxo_lawyer%>" />
                                </td>
							</tr>
                            <tr>
                                <td style="text-align: right;"><%= lang.get(si_date_ishonchnoma)%>:</td>
                                <td></td>
                                <td>
                                    <input name="date_ishonchnoma" style="width:100%" readOnly value="<%=date_ishonchnoma.replaceAll("\"", "&quot;")%>" />
                                </td>
                                <td></td>

                                <td style="text-align: right;"><%= lang.get(si_number_ishonchnoma)%>:</td>
                                <td></td>
                                <td>
                                    <input name="number_ishonchnoma" style="width:100%" readOnly value="<%=number_ishonchnoma.replaceAll("\"", "&quot;")%>" />
                                </td>
                                <td></td>
                            </tr>
							<tr>
								<td style="text-align: right;"><%= lang.get(si_bxo_address)%>:</td>
								<td></td>
								<td colspan="5">
									<input name="bxo_address" style="width:100%" readOnly value="<%=bxo_address.replaceAll("\"", "&quot;")%>" />
								</td>
								<td></td>

								<td style="text-align: right;"><%= lang.get(si_bxo_min_address)%>:</td>
								<td></td>
								<td>
									<input name="bxo_min_address" style="width:100%" readOnly value="<%=bxo_min_address.replaceAll("\"", "&quot;")%>" />
								</td>
							</tr>
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
	<t:request name="preview_update"><%
		try {
			String sss = "Salom";
		} catch (Exception ex) {

		}
	%></t:request>

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
	static final int si_form_title 			= SI("Предварительный просмотр документа","Чоп этишга тайёрлаш","","");
	static final int si_success 			= SI("Успешно выполнено!", "Маълумотлар муваффа&#1179;иятли са&#1179;ланди!", "Ma`lumotlar muvaffaqiyatli saqlandi!", "Successfully");
	static final int si_exception 			= SI("Маълумотлар топилмади!");
	static final int si_btn_client_code 	= SI("Код клиента (уникалный код)");
	static final int si_search_code 		= SI("Кидириш", "Поиск", "Search", "Qidirish");

	static final int si_field_title_1		= SI("Номер и дата договора", "Шартнома ра&#1179;ами ва санаси","","");
	static final int si_field_title_2		= SI("Услуги банка", "Банк хизматлари","","");
	static final int si_field_title_3		= SI("Реквизиты организации", "Ташкилот реквизитлари","","");
	static final int si_field_title_4		= SI("Реквизиты БХО (БХМК)", "БХО (БХМК) реквизитлари","","");

	static final int si_id              	= SI("Ид.","Ид.","","");
	static final int si_contract_number 	= SI("Номер договора","Шартнома ра&#1179;ами","","");
	static final int si_contract_date   	= SI("Дата договора","Шартнома санаси","","");
	static final int si_date_generate   	= SI("Дата генерации договора","Шартнома генерация &#1179;илинган ва&#1179;т","","");
	static final int si_date_modify     	= SI("Дата модификации договора","Шартнома &#1118;згартирилган ва&#1179;т","","");
	static final int si_filial_code     	= SI("Код филиала","Филиал коди","","");
	static final int si_local_code     		= SI("Локольный код","Локал код","","");
	static final int si_branch_id    		= SI("Филиал ID","Филиал ID","","");
	static final int si_client_id       	= SI("Код клиента","Мижоз коди","","");
	static final int si_bxo_min_address 	= SI("Короткий адрес","&#1178;ис&#1179;а манзил","","");
	static final int si_date_ishonchnoma 	= SI("Дата доверенности","Ишончнома санаси","","");
	static final int si_number_ishonchnoma 	= SI("Номер доверенности","Ишончнома номери","","");
	static final int si_bxo_manager 		= SI("Управляюший","Бош&#1179;арувчи","","");
	static final int si_client_name			= SI("Имя организации","Ташкилот номи","","");
	static final int si_client_manager		= SI("Директор","Ра&#1203;бар","","");
	static final int si_remote_services		= SI("Дистанционные услуги","Масофавий хизматлар","","");
	static final int si_sms_services		= SI("СМС услуги","СМС хизмати","","");
	static final int si_bxo_address			= SI("Адрес","Манзил","","");
	static final int si_client_address		= SI("Адрес организации","Ташкилот манзили","","");
	static final int si_bxo_schet			= SI("Расчётный счёт","&#1202;исобра&#1179;ам","","");
	static final int si_client_schet		= SI("Расчётный счёт","&#1202;исобра&#1179;ам","","");
	static final int si_client_inn			= SI("ИНН","ИНН","","");
	static final int si_bxo_inn				= SI("ИНН","ИНН","","");
	static final int si_client_oked			= SI("ОКЭД","ОКЭД","","");
	static final int si_bxo_phone			= SI("Тел.","Тел.","","");
	static final int si_client_phone		= SI("Тел.","Тел.","","");
	static final int si_client_accountant	= SI("Глав.бух.","Бош бухгалтер","","");
	static final int si_client_lawyer		= SI("Юрист","Юрист","","");
	static final int si_bxo_lawyer			= SI("Юрист","Юрист","","");
	static final int si_add_new				= SI("Создать новый договор","Янги шартнома яратиш","","");
	static final int si_btn_details1		= SI("Подробно1...","Батафсил1...","","");
	static final int si_btn_details2		= SI("Подробно2...","Батафсил2...","","");
	static final int si_btn_details3		= SI("Подробно3...","Батафсил3...","","");

	static final int si_bxo_name			= SI("Название БХО","БХО номи","","");
	static final int si_bxo_oked			= SI("ОКЭД","ОКЭД","","");
	static final int si_bxo_accountant		= SI("Глав.бух.","Бош хисобчи","","");
	static final int si_client_code			= SI("Уникальный код клиента","Мижоз уникал коди","","");
	static final int si_btn_update			= SI("Обновить","Янгилаш","","");

//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>
<script>window.returnValue="Refresh";history.back();</script>