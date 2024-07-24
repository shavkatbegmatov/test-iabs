<%@ page contentType="text/html;charset=WINDOWS-1251" language="java"%><%
%><%@ page import="java.sql.*,java.util.*, uz.fido_biznes.cms.*" %><%
%><%@ page import="oracle.sql.*, oracle.jdbc.*" %><%
%><%@ taglib uri="/WEB-INF/cms.tld" prefix="t"%><%
%><jsp:useBean id="cods" class="iabs.oraDBConnection" scope="session" /><%
%><jsp:useBean id="stored" class="uz.fido_biznes.sql.StoredObject" scope="session"/><%
%><jsp:useBean id="user" class="iabs.User" scope="session" /><%
%><jsp:useBean id="util" class="iabs.oraUtil" scope="session" /><%
	Connection conn = cods.getConnection();
	if(conn == null || user.getUserCode() == null) {
		pageContext.setAttribute(Resource.SESSION_EXPIRED, Boolean.TRUE);}
	Language lang = new Language(user.getLanguageIndex(), sentences);
	pageContext.setAttribute(Resource.STR_LANGUAGE, lang);
//-------------------------------------------------------------------------------------------------%>
<t:references>
	<%
		String iWhere = "condition='A' and HEADER_CODE="+user.getHeaderCode();
	%>
	<t:reference name="filials" >
		<t:table from="cib_v_filials" >
			<t:field id="1" name="code" label="<%=si_filial_code%>" >
				<t:filter operator="_search" mask="5|0-9" showInGrid="" />
			</t:field>
			<t:field id="2" name="name" label="<%=si_filial_name%>" type="quote" />
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="dex_corp" >
		<t:table from="CIB_V_DEX_CORP">
			<t:field id="1" name="CORP" label="<%=si_CORP_ID%>" />
			<t:field id="3" name="NAME" label="<%=si_client_name%>" type="quote" />
			<t:field id="2" name="TRANZITACC" label="<%=si_account_number%>" >
				<t:filter operator="_search" mask="acc" />
			</t:field>
			<t:field id="4" name="FILIAL" label="<%=si_filial_code%>" >
				<t:filter operator="_search" mask="5|0-9" />
			</t:field>
			<t:field id="5" name="CLIENT" label="<%=si_client_code%>" >
				<t:filter operator="_search" mask="8|0-9" />
			</t:field>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="3" align="left" />
				<t:column for="2" align="left" />
				<t:column for="4" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="account_dex" >
		<t:table from="cib_v_duet_dex">
			<t:field id="1" name="account_number" label="<%=si_account_number%>" >
				<t:filter operator="_search" mask="acc" showInGrid="" />
			</t:field>
			<t:field id="2" name="client_name" label="<%=si_client_name%>" type="quote" />
			<t:field id="3" name="mfo" label="<%=si_filial_code%>" >
				<t:filter operator="_search" mask="5|0-9" showInGrid="" />
			</t:field>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
				<t:column for="3" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="clients" >
		<t:table from="qqb_e_shartnoma_client_current_v"  where="">
			<t:field id="1" name="code" label="<%=si_client_code%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="2" name="name" label="<%=si_client_name%>" type="quote"/>
			<t:field id="3" name="Director_Name" label="<%=si_director_name%>" type="quote"/>
			<t:field id="4" name="accounter_chief_name" label="<%=si_accounter_chief_name%>" type="quote"/>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
				<t:column for="3" align="left" />
				<t:column for="4" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="clients_contract" >
		<t:table from="qqb_e_shartnoma_client_current_v"  >
			<t:field id="1" name="code" label="<%=si_client_code%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="2" name="name" label="<%=si_client_name%>" type="quote"/>
			<t:field id="3" name="Director_Name" label="<%=si_director_name%>" type="quote"/>
			<t:field id="4" name="accounter_chief_name" label="<%=si_accounter_chief_name%>" type="quote"/>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
				<t:column for="3" align="left" />
				<t:column for="4" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="bxos_name" >
		<t:table from="qqb_e_shartnoma_client_current_v"  >
			<t:field id="1" name="code" label="<%=si_client_code%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="2" name="name" label="<%=si_client_name%>" type="quote"/>
			<t:field id="3" name="Director_Name" label="<%=si_director_name%>" type="quote"/>
			<t:field id="4" name="accounter_chief_name" label="<%=si_accounter_chief_name%>" type="quote"/>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
				<t:column for="3" align="left" />
				<t:column for="4" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="client_datas_ref">
		<t:table from="cib_v_clients_ref_f9" >
			<t:field id="1" name="client_code" label="<%=si_client_code%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="2" name="client_id" label="<%=si_client_id%>" />
			<t:field id="3" name="client_name" label="<%=si_client_name%>" type="quote"/>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="3" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="corp_client_datas_ref">
		<t:table from="cib_v_corp_clients" >
			<t:field id="1" name="client_code" label="<%=si_client_code%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="2" name="client_id" label="<%=si_client_id%>" />
			<t:field id="3" name="client_name" label="<%=si_client_name%>" type="quote"/>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="3" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="routes_ref">
		<t:table from="cib_v_route_ref_f9">
			<t:field id="1" name="route_id" label="<%=si_route_id%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="2" name="name" label="<%=si_route_name%>" type="quote"/>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="roles_ref">
		<t:table from="cib_v_role_ref_f9">
			<t:field id="1" name="role_id" label="<%=si_role_id%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="2" name="name" label="<%=si_role_name%>" type="quote"/>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="roles_act_ref">
		<t:table from="cib_v_rel_role_act_ref_f9">
			<t:field id="1" name="role_id" label="<%=si_role_id%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="3" name="role_name" label="<%=si_role_name%>" type="quote"/>
			<t:field id="2" name="action_id" label="<%=si_action_id%>" >
				<t:filter />
			</t:field>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="3" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="actions_ref" >
		<t:table from="cib_v_action_ref_f9">
			<t:field id="1" name="action_id" label="<%=si_action_id%>" >
				<t:filter operator="_search" showInGrid="" />
			</t:field>
			<t:field id="2" name="name" label="<%=si_action_name%>" type="quote"/>
			<t:grid hideFilterButton="" page="" >
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="for_block_filials">
		<t:table from="v_filials" where=" condition = 'A' and code_type = 'F' ">
			<t:field id="1" name="code_bank"   label="<%=si_filial_code%>">
				<t:filter operator="_like" mask="{5|0-9}"/>
			</t:field>
			<t:field id="2" name="name" label="<%=si_filial_name%>" type="quote">
				<t:filter operator="_search_"  size="40" />
			</t:field>
			<t:grid page="" numbering="">
				<t:column for="1" />
				<t:column for="2" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="primary_account">
		<t:table from="cib_v_relation_accounts_user" where="to_doc = 1">
			<t:field id="1" name="Acc_External" label="<%=si_acc_external%>">
				<t:filter showInGrid="" operator="search_" />
			</t:field>
			<t:field id="2" name="Acc_Name" label="<%=si_acc_name%>" >
				<t:filter showInGrid="" operator="_search_" />
			</t:field>
			<t:grid page="" numbering="">
				<t:column for="1" />
				<t:column for="2" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="account_client">
		<t:table from="cib_v_relation_accounts_user" where="to_doc = 1">
			<t:field id="1" name="Acc_External" label="<%=si_acc_external%>">
				<t:filter showInGrid="" operator="search_" />
			</t:field>
			<t:field id="2" name="Acc_Name" label="<%=si_acc_name%>" >
				<t:filter showInGrid="" operator="_search_" />
			</t:field>
			<t:grid page="" numbering="">
				<t:column for="1" />
				<t:column for="2" />
			</t:grid>
		</t:table>
	</t:reference>
	<t:reference name="locals">
		<t:table from="cib_v_list_locals">
			<t:field id="1" name="code" label="<%=si_local_code%>">
				<t:filter mask="5|0-9" showInGrid="" operator="like_" />
			</t:field>
			<t:field id="2" name="FILIAL_CODE" label="<%=si_f_code%>">
				<t:filter operator="_like" mask="{5|0-9}"/>
			</t:field>
			<t:field id="3" name="name" label="<%=si_name%>" type="quote">
				<t:filter operator="_search_" showInGrid="" />
			</t:field>
			<t:grid page="" hideFilterButton="">
				<t:column for="1" align="left" />
				<t:column for="2" align="left" />
				<t:column for="3" align="left" />
			</t:grid>
		</t:table>
	</t:reference>
</t:references>
<t:requests>
	<t:request name="get_coa"><%
		try {
			String code = request.getParameter("code");
			String name = stored.execSelect("select name from v_coa where code='" + Util.quotesSQL(code) + "'");
			if(name.equalsIgnoreCase("")) {
				throw new Exception(lang.get(si_error_code));
			}
			JArray result = new JArray();
			result.push(name);
			out.print(result.toString());
		} catch (Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="filials"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("Cib_Util.Bank_Name");
			cs.setStringParameter("i_Code","filial_code");
			// cs.setStringParameter("i_raise", "raise");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="bank">
		<%
			String bankCode = request.getParameter("filial_code");
			if (bankCode == "")	{
				bankCode = user.getFilialCode();
			}
			try {
				String bankName = stored.execFunction("Bank.Get_Bank_Name('" + bankCode + "','Y')");
				out.print("['"+Util.quotesEsc(bankName)+"']");
			} catch (Exception ex) {
				response.setHeader("RT", "alert");
				out.print(ex.getMessage());
			}
		%>
	</t:request>
	<t:request name="get_route_name"><%
		String route_id = request.getParameter("route_id");
		String route_name = stored.execSelect("select name from cib_v_route_ref_f9 where route_id='" + route_id +"'" );
		out.print("['"+route_name+"']");
	%></t:request>
	<t:request name="clients"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("cib_adm_util.Select_Client_Current");
			cs.setStringParameter("i_Client_Code","client_code");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="clients_contract"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("QQB_E_SHARTNOMA_SHAVKAT.getClientInfo");
			cs.setStringParameter("iClientCode", "client_code");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>


	<t:request name="client_datas_req"><%
		String route = request.getParameter("route");
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("cib_adm_util.Client_Datas");
			cs.setStringParameter("i_Client_Code","client_code");
			if (route != null)
				cs.setString("i_route",route);

			cs.execute();
			out.print(cs.getStringResult());
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="corp_client_datas_req"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("cib_adm_util.Corp_Client_Datas_Ref");
			cs.setStringParameter("i_Client_Code","client_code");
			cs.execute();
			out.print(cs.getStringResult());
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="routes_req"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("cib_adm_util.Select_Route_Name");
			cs.setNumberParameter("i_route_id","route_id");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="roles_req"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("Cib_Adm_Util.Select_Role_Name");
			cs.setNumberParameter("i_Role_Id","role_id");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="route_act_role"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("Cib_Adm_Util.Select_Role_Act_Role_Name");
			cs.setNumberParameter("i_Role_Id","role_id");
			cs.setNumberParameter("i_Action_Id","action_id");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="actions_req"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("cib_adm_util.Select_action_Name");
			cs.setNumberParameter("i_action_id","action_id");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="FIO_client">
		<% // получить ФИО сотрудника из реквизитов клиента по коду должности
			String client_id = request.getParameter("client_id");
			String post_id     = request.getParameter("post_id");
			try {
				String FIO_user = stored.execFunction("cib_adm_api.get_FIO_Client_Data(" + client_id + "," + post_id + ")");
				FIO_user = (FIO_user == null || "null".equals(FIO_user)) ? "" : FIO_user;
				out.print("['"+Util.quotesEsc(FIO_user)+"']");
			}
			catch (Exception ex) {
				response.setHeader("RT", "alert");
				out.print(ex.getMessage());
			}
		%>
	</t:request>
	<t:request name="list_account_dex"><%
		String state = request.getParameter("state");
		try {
			String stateName = stored.execSelect("select name from cib_v_duet_dex t where t.code = "+state);
			JArray result = new JArray();
			result.push(stateName);
			out.print(result.toString());
		} catch (Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>

	<t:request name="for_block_filials"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("cib_util.Select_filial");
			cs.setStringParameter("i_Filial_Code","filial_code");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>

	<t:request name="last_login"><%
		try {
			ServletCallableStatement cs = new ServletCallableStatement(stored, request);
			cs.setFunction("cib_adm_util.Get_Last_Id_Of_User");
			cs.setStringParameter("i_Type","t_user");
			cs.execute();
			JArray result = new JArray();
			result.push(cs.getStringResult());
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>
	<t:request name="locals"><%
		String code = request.getParameter("local_code");
		try {
			String name = stored.execSelect("select name from cib_v_list_locals t where code = '" + code+ "'");
			JArray result = new JArray();
			result.push(name);
			out.print(result);
		} catch(Exception ex) {
			response.setHeader("RT", "error");
			out.print(Util.getUserMessage(ex));
		}
	%></t:request>

</t:requests>
<%!
	static final int si_code			= SI("Код клиента");
	static final int si_code_filial		= SI("Код филиала");
	static final int si_name			= SI("Наименование клиента");
	static final int si_client_code		= SI("Код клиента");
	static final int si_client_name		= SI("Наименование клиента");
	static final int si_director_name		= SI("Директор");
	static final int si_accounter_chief_name		= SI("Бухгалтер");
	static final int si_filial_name		= SI("Наименование филиала");
	static final int si_filial_code		= SI("Код филиала");
	static final int si_client_id		= SI("ID клиента");
	static final int si_post_id			= SI("Код должности");
	static final int si_post_name		= SI("Наименование должности");
	static final int si_route_id		= SI("Код маршрута");
	static final int si_route_name		= SI("Наименование маршрута");
	static final int si_action_id		= SI("Код действия");
	static final int si_action_name		= SI("Наименование действия");
	static final int si_role_id			= SI("Код роли");
	static final int si_acc_external			= SI("Счет");
	static final int si_acc_name			= SI("Наименование");
	static final int si_role_name		= SI("Наименование роли");
	static final int si_account_number		= SI("Счет");
	static final int si_CORP_ID     	= SI("Корпаративный ID","Корпаративный ID","Корпаративный ID","Корпаративный ID");
	static final int si_error_code = SI("Код ошибки");
	static final int si_f_code      = SI("Филиал","Филиал","Filial","Filial");
	static final int si_local_code      = SI("Подразделение");
//-------------------------------------------------------------------------------------------------
%><%@ include file="/language.jsp" %>