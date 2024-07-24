<%--
  Created by Shavkat Begmatov.
  Date: 25.04.2023
  Time: 12:02
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page contentType="text/html;charset=WINDOWS-1251" language="java" %>
<%@ taglib uri="/WEB-INF/cms.tld" prefix="t" %>

<%@ page import="java.sql.*" %>
<%@ page import="uz.fido_biznes.cms.*" %>
<%@ page import="java.util.*" %>
<%@ page import="uz.fido_biznes.sql.Direction" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="oracle.jdbc.*" %>
<%@ page import="iabs.oraDBConnection" %>

<jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session"/>
<jsp:useBean id="user" class="iabs.User" scope="session"/>
<jsp:useBean id="util" class="iabs.oraUtil" scope="session"/>
<jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/>
<jsp:useBean id="storedObj" class="iabs.StoredObject" scope="session"/>
<%

    Connection conn = cods.getConnection();
    if (conn == null || user.getUserCode() == null)
        pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);
    Language lang = new Language(user.getLanguageIndex(), sentences);
    pageContext.setAttribute(Resource.STR_LANGUAGE, lang);

    request.setCharacterEncoding("WINDOWS-1251");

    String id                       = request.getParameter("id"); // ok
    String contract_number          = request.getParameter("contract_number"); // ok
    String contract_date            = request.getParameter("contract_date"); // ok
    String contract_code            = request.getParameter("contract_code"); // ok


    String sms_service              = request.getParameter("sms_service"); // ok
    String remote_service           = request.getParameter("remote_service"); // ok

    String sms_service_checked      = (sms_service != null && sms_service.equals("1"))       ? "checked" : "";
    String remote_service_checked   = (remote_service != null && remote_service.equals("1")) ? "checked" : "";

    String contract_type            = request.getParameter("contract_type"); // ok
    String contract_percent         = request.getParameter("contract_percent");

    String client_code              = request.getParameter("client_code");
    String client_name              = request.getParameter("client_name");
    String client_schet             = request.getParameter("client_schet");
    String client_inn               = request.getParameter("client_inn");
    String client_oked              = request.getParameter("client_oked");
    String client_phone             = request.getParameter("client_phone");
    String client_manager           = request.getParameter("client_manager");
    String client_accountant        = request.getParameter("client_accountant");
    String client_lawyer            = request.getParameter("client_lawyer");
    String client_address           = request.getParameter("client_address");

    String branch_id                = request.getParameter("branch_id");
    String bxo_name                 = request.getParameter("bxo_name"); // ok
    String bxo_schet                = request.getParameter("bxo_schet");
    String bxo_inn                  = request.getParameter("bxo_inn");
    String bxo_oked                 = request.getParameter("bxo_oked");
    String bxo_phone                = request.getParameter("bxo_phone");
    String bxo_manager              = request.getParameter("bxo_manager");
    String bxo_accountant           = request.getParameter("bxo_accountant");
    String bxo_lawyer               = request.getParameter("bxo_lawyer");
    String date_ishonchnoma         = request.getParameter("date_ishonchnoma");
    String number_ishonchnoma       = request.getParameter("number_ishonchnoma");
    String bxo_address              = request.getParameter("bxo_address");
    String bxo_min_address          = request.getParameter("bxo_min_address");

    String contract_number_ai       = request.getParameter("contract_number_ai");

    String contract_number_readonly = "";
    if (contract_type != null && contract_type.equals("A")) {
        if (contract_type.equals("A")) {
            // A - Additional contract. Qo'shimcha shartnoma
            contract_number = contract_number + "/" + (contract_number_ai + 1).toString();
            contract_number_readonly = "readonly";
            contract_date = stored.execFunction("setup.get_operday");
        } else if (contract_type.equals("M")) {
            // M - Main contract. Asosiy shartnoma
            contract_number_readonly = "";
        } else {
            // Boshqa turdagi shartnoma.
        }
    }

%>
<t:page>
    <style>
        .mytitle {
            font-family: "Arial narrow", Arial, Helvetica, Geneva, sans-serif;
            font-size: 2em;
        }
        .main-contract-color {
            color: #0d6efd;
        }
        .additional-contract-color {
            color: darkgreen;
        }
    </style>
    <t:form title="<%=si_form_title %>" minWidth="fill" minHeight="fill">
        <script>
            <%--alert("<%=contract_type%>");--%>
            function test2() {
                alert("\"<%=contract_type%>\"");
            }
        </script>
        <%
        %><script><%
            if (request.getParameter("contract_number_ai") != null) {%>
                alert("contract_number_ai is null!");<%
                if (request.getParameter("contract_number_ai").equals("")) {%>
                    alert("contract_number_ai is not empty!");<%
                }
            } else {%>
                alert("contract_number_ai is not null!");
                alert("<%request.getParameter("contract_number_ai");%>");<%
            }
        %></script><%
        %>
        <iframe name="frm" style="display:none"></iframe>
        <form name="fm" target="frm">
            <input type="hidden" name="request" value="preview_update">
            <input type="hidden" name="contract_id" value="<%=id%>">
            <input type="hidden" name="contract_type" value="<%=contract_type%>">
            <input type="hidden" name="contract_code" value="<%=contract_code%>">
            <input type="hidden" name="contract_number_ai" value="<%=contract_number_ai%>">

            <div style="
				padding: 5px;
				margin-bottom: 10px;
				box-shadow: 0 5px 5px rgb(86,139,191);
			">
                <table style=" margin-left:25px; width:85%;">
                    <col width="15%">
                    <col width="15%">
                    <col width="170%">
                    <tr>
                        <td>
                            <input type="submit" id="save"  name="save" value="<%=lang.get(si_btn_save)%>">
                        </td>
                        <td>
                            <input onclick="window.close()" type="button" name="exit" value="<%=lang.get(si_btn_exit)%>">
                        </td>
                        <% if(contract_type.equals("M")) { %>
                            <td align="right">
                                <span class="mytitle main-contract-color"><%=lang.get(si_contract_main)%></span>
                            </td>
                        <% } else { %>
                            <td align="right">
                                <span class="mytitle additional-contract-color"><%=lang.get(si_contract_additional)%></span>
                            </td>
                        <% } %>
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
                                    <label for="sms_service" style="user-select: none;"><%=lang.get(si_sms_service)%></label>
                                    <input id="sms_service" name="sms_service" type="checkbox" <%=sms_service_checked%> style="" />
                                </td>
                                <td>
                                    <label for="remote_service" style="user-select: none;"><span style="vertical-align: text-top;"><%=lang.get(si_remote_service)%></span></label>
                                    <input id="remote_service" name="remote_service" type="checkbox" <%=remote_service_checked%> style="" />
                                </td>
                                <% if(!contract_type.equals("M")) { %>
                                <td>
                                    <label for="percent" style="user-select: none;"><%=lang.get(si_percent)%></label>
                                    <input id="percent" name="contract_percent" mask="5|{0-9,.}" size="5" type="text" value="<%=contract_percent%>" style="" />
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
                </div>
            </div>
        </form>
    </t:form>
</t:page>
<t:requests>
    <t:request name="preview_update">
        <script><%
            //iabs.HttpRequest req = new iabs.HttpRequest(request);
//            String id2 				= request.getParameter("id");
            String test2 = "For testing...";
            String oResult = "Test3";
            String contractId = request.getParameter("contract_id");
            String contractNumber = request.getParameter("contract_number");
            String contractCode = request.getParameter("contract_code");
            String xxx = request.getParameter("contract_number_ai");
            if (xxx == null) {
                %>
                    alert(<%=xxx%>);
                <%
            }
//            String contractNumberAi = request.getParameter("contract_number_ai") != null ? request.getParameter("contract_number_ai") : "";
            String contractNumberAi = "";

            String smsService    = (request.getParameter("sms_service") == null)    ? "0" : "1";
            String remoteService = (request.getParameter("remote_service") == null) ? "0" : "1";

            String contractType = request.getParameter("contract_type");
            String contractPercent = request.getParameter("contract_percent");
            String contractState = "R";
            try {
                CallableStatement cs = conn.prepareCall("Call QQB_E_SHARTNOMA_SHAVKAT.updateContractNumberById(?,?,?,?,?,?,?,?,?,?)");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setString(2,  contractId);
                cs.setString(3,  contractNumber);
                cs.setString(4,  smsService );
                cs.setString(5,  remoteService );
                cs.setString(6,  contractType );
                cs.setString(7,  contractPercent );
                cs.setString(8,  contractCode );
                cs.setString(9,  contractNumberAi );
                cs.setString(10, contractState );
                cs.execute();
                oResult = cs.getString(1);
//                out.print(oResult);
                %>
                alert("<%=oResult%>");
                alert("smsService: " + "<%=smsService%>" + "; remoteService: "+ "<%=remoteService%>");
                parent.pageLock(false);
                top.returnValue={};
                //top.close();<%
            } catch (Exception ex) {%>
                alert('<%= Util.quotesEsc(ex.getMessage()) %>');
                parent.pageLock(false);
                //top.close();<%
            } finally {%>
                <%--alert("<%=test2%>");--%>
                parent.pageLock(false);
                top.returnValue={};
                //top.close();<%
            }%>
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
</t:requests>
<%!
    static final int si_form_title 		    = SI("Предварительный просмотр документа","Чоп этишга тайёрлаш","","");
    static final int si_success 		    = SI("Успешно выполнено!", "Маълумотлар муваффа&#1179;иятли са&#1179;ланди!", "Ma`lumotlar muvaffaqiyatli saqlandi!", "Successfully");
    static final int si_exception 		    = SI("Маълумотлар топилмади!");
    static final int si_btn_client_code     = SI("Код клиента (уникалный код)");
    static final int si_search_code 	    = SI("Кидириш", "Поиск", "Search", "Qidirish");

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

    static final int si_bxo_name			= SI("Название БХО","БХО номи","","");
    static final int si_bxo_oked			= SI("ОКЭД","ОКЭД","","");
    static final int si_bxo_accountant		= SI("Глав.бух.","Бош хисобчи","","");
    static final int si_client_code			= SI("Уникальный код клиента","Мижоз уникал коди","","");
    static final int si_btn_update			= SI("Обновить","Янгилаш","","");
    static final int si_btn_save			= SI("Сохранить","Са&#1179;лаш","","");
    static final int si_btn_exit			= SI("Закрыть","Чи&#1179;иш","","");

    static final int si_remote_service		= SI("Дистанционные услуги","Масофадан хизмат кўрсатиш тизими","","");
    static final int si_sms_service		    = SI("SMS-банкинг","SMS-банкинг","","");
    static final int si_percent		        = SI("Процент (%)","Дебет айланма учун олинадиган &#1203;а&#1179; ми&#1179;дори (%)","","");

    static final int si_contract_main		= SI("Первоначальный договор","Дастлабки шартнома","Dastlabki shartnoma","");
    static final int si_contract_additional	= SI("Дополнительный договор","&#1178;&#1118;шимча шартнома","Qo'shimcha shartnoma","");
//-------------------------------------------------------------------------------------------------
%>
<%@ include file="/language.jsp" %>