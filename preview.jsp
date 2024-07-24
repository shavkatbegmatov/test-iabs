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
							<input type="submit" id="save"  name="save" value="��&#1179;���">
						</td>
						<td align="right">
							<input onclick="window.close()" type="button" name="exit" value="��&#1179;��">
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
									<label for="sms_service" style="user-select: none;">SMS-�������</label>
									<input id="sms_service" name="sms_service" type="checkbox" <%=sms_service_checked%> style="" />
								</td>
								<td>
									<label for="remote_service" style="user-select: none;">��������� ������ ������� ������</label>
									<input id="remote_service" name="remote_service" type="checkbox" <%=remote_service_checked%> style="" />
								</td>
                                <% if(!contract_type.equals("M")) { %>
								<td>
									<label for="percent" style="user-select: none;">����� ������� ���� ���������� &#1203;�&#1179; ��&#1179;����</label>
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
<%--                        ��� (����) ������������--%>
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
	static final int si_form_title 			= SI("��������������� �������� ���������","��� ������ �������","","");
	static final int si_success 			= SI("������� ���������!", "����������� �������&#1179;����� ��&#1179;�����!", "Ma`lumotlar muvaffaqiyatli saqlandi!", "Successfully");
	static final int si_exception 			= SI("����������� ���������!");
	static final int si_btn_client_code 	= SI("��� ������� (��������� ���)");
	static final int si_search_code 		= SI("�������", "�����", "Search", "Qidirish");

	static final int si_field_title_1		= SI("����� � ���� ��������", "�������� ��&#1179;��� �� ������","","");
	static final int si_field_title_2		= SI("������ �����", "���� ����������","","");
	static final int si_field_title_3		= SI("��������� �����������", "�������� ������������","","");
	static final int si_field_title_4		= SI("��������� ��� (����)", "��� (����) ������������","","");

	static final int si_id              	= SI("��.","��.","","");
	static final int si_contract_number 	= SI("����� ��������","�������� ��&#1179;���","","");
	static final int si_contract_date   	= SI("���� ��������","�������� ������","","");
	static final int si_date_generate   	= SI("���� ��������� ��������","�������� ��������� &#1179;������� ��&#1179;�","","");
	static final int si_date_modify     	= SI("���� ����������� ��������","�������� &#1118;������������ ��&#1179;�","","");
	static final int si_filial_code     	= SI("��� �������","������ ����","","");
	static final int si_local_code     		= SI("��������� ���","����� ���","","");
	static final int si_branch_id    		= SI("������ ID","������ ID","","");
	static final int si_client_id       	= SI("��� �������","����� ����","","");
	static final int si_bxo_min_address 	= SI("�������� �����","&#1178;��&#1179;� ������","","");
	static final int si_date_ishonchnoma 	= SI("���� ������������","��������� ������","","");
	static final int si_number_ishonchnoma 	= SI("����� ������������","��������� ������","","");
	static final int si_bxo_manager 		= SI("�����������","���&#1179;������","","");
	static final int si_client_name			= SI("��� �����������","�������� ����","","");
	static final int si_client_manager		= SI("��������","��&#1203;���","","");
	static final int si_remote_services		= SI("������������� ������","��������� ���������","","");
	static final int si_sms_services		= SI("��� ������","��� �������","","");
	static final int si_bxo_address			= SI("�����","������","","");
	static final int si_client_address		= SI("����� �����������","�������� �������","","");
	static final int si_bxo_schet			= SI("��������� ����","&#1202;������&#1179;��","","");
	static final int si_client_schet		= SI("��������� ����","&#1202;������&#1179;��","","");
	static final int si_client_inn			= SI("���","���","","");
	static final int si_bxo_inn				= SI("���","���","","");
	static final int si_client_oked			= SI("����","����","","");
	static final int si_bxo_phone			= SI("���.","���.","","");
	static final int si_client_phone		= SI("���.","���.","","");
	static final int si_client_accountant	= SI("����.���.","��� ���������","","");
	static final int si_client_lawyer		= SI("�����","�����","","");
	static final int si_bxo_lawyer			= SI("�����","�����","","");
	static final int si_add_new				= SI("������� ����� �������","���� �������� ������","","");
	static final int si_btn_details1		= SI("��������1...","��������1...","","");
	static final int si_btn_details2		= SI("��������2...","��������2...","","");
	static final int si_btn_details3		= SI("��������3...","��������3...","","");

	static final int si_bxo_name			= SI("�������� ���","��� ����","","");
	static final int si_bxo_oked			= SI("����","����","","");
	static final int si_bxo_accountant		= SI("����.���.","��� �������","","");
	static final int si_client_code			= SI("���������� ��� �������","����� ������ ����","","");
	static final int si_btn_update			= SI("��������","�������","","");

//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>
<script>window.returnValue="Refresh";history.back();</script>