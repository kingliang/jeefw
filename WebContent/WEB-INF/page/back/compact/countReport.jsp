<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery.gritter.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/select2.css" />

<div class="row">
	<div class="col-xs-12">
		<div class="well well-sm">
			<select class="select2 col-xs-2 " id="lyxx" onchange="getAchievementMsgxx()">
			</select>
		</div>
		
		<table id="repoert-table"></table>
			
		<div id="grid-pager"></div>

		<script type="text/javascript">
			var $path_base = "${contextPath}/static";//in Ace demo this will be used for editurl parameter
		</script>

		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<div id="modal-table" class="modal fade" data-backdrop="static">
    <div class="modal-dialog" style="min-width: 1000px;">
        <form id="bulidingForm" class="form-horizontal">
            <div class="modal-content">
                <div class="modal-header no-padding">
                    <div class="table-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <span class="white">&times;</span>
                        </button>
                        月租金曲线图
                    </div>
                </div>
                <div class="modal-body" style="height: 600px;">
                    <div id="main" style="width: 1000px;height: 600px"></div>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div>

<div id="modal-htxx_test" class="modal fade" tabindex="-1"
		data-backdrop="static">
		<div class="modal-dialog" style="min-width: 1200px;">
			<form id="informationForm">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							预算表详情
						</div>
					</div>
					<div class="modal-body"
						style="max-height: 700px; overflow-y: scroll;">
						<div class="col-xs-12 col-sm-12">
							<table class="table table-striped table-bordered table-hover">
								<tr>
									<td>毛利润：<span style="color: green;" id="sum_info">
									</span></td>
								</tr>
							</table>
						</div>
						<div class="col-xs-12 col-sm-6">
							<div class="widget-box">
								<div class="widget-header">
									<h4 class="widget-title">收入</h4>
								</div>

								<div class="widget-body">
									<div class="widget-main">
										<table class="table table-striped table-bordered table-hover">
											<tr>
												<td colspan="2" style="text-align: center;">项目</td>
												<td style="text-align: center;">预算</td>
												<td style="text-align: center;">备注</td>
											</tr>
											<tr>
												<td colspan="2">租金</td>
												<td id="rent_info" class="cass"></td>
												<td id="rentps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">物业管理费</td>
												<td id="property_info" class="cass"></td>
												<td id="propertyps_info" class="cass"></td>
											</tr>
											<tr>
												<td rowspan="2" style="vertical-align: middle;">停车费</td>
												<td>固定停车费</td>
												<td id="fixedparking_info" class="cass"></td>
												<td id="fixedparkingps_info" class="cass"></td>
											</tr>
											<tr>
												<td>临时停车费</td>
												<td id="tempparking_info" class="cass"></td>
												<td id="tempparkingps_info" class="cass"></td>
											</tr>
											<%--<tr>
                                            <td colspan="2">服务费</td>
                                            <td id="service_info">84315.00</td>
                                            <td>含基站租赁</td>
                                        </tr>--%>
											<tr>
												<td colspan="2">广告费</td>
												<td id="advertising_info" class="cass"></td>
												<td id="advertisingps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">其他经营收入</td>
												<td id="rest_info" class="cass"></td>
												<td id="restps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">维修材料</td>
												<td id="servicing_info" class="cass"></td>
												<td id="servicingps_info" class="cass"></td>
											</tr>
											<%--<tr>
                                            <td colspan="2">仓储费/经营开发</td>
                                            <td id="warehouse_info">35000.00</td>
                                            <td>有服务合同</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">租线费</td>
                                            <td id="rental_info">70000.00</td>
                                            <td>备注</td>
                                        </tr>--%>
											<tr>
												<td colspan="2">电费</td>
												<td id="electricin_info" class="cass"></td>
												<td id="electricinps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">水费</td>
												<td id="waterin_info" class="cass"></td>
												<td id="waterinps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="4">小计：<span style="color: red" id="sum0_info"></span></td>

											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6">
							<div class="widget-box">
								<div class="widget-header">
									<h4 class="widget-title">成本</h4>
								</div>

								<div class="widget-body">
									<div class="widget-main">
										<table class="table table-striped table-bordered table-hover">
											<tr>
												<td colspan="3" style="text-align: center;">项目</td>
												<td style="text-align: center;">预算</td>
												<td style="text-align: center;">备注</td>
											</tr>
											<tr>
												<td rowspan="3" style="vertical-align: middle;">能源费</td>
												<td colspan="2">水费</td>
												<td id="water_info" class="cass"></td>
												<td id="waterps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">电费</td>
												<td id="electricout_info" class="cass"></td>
												<td id="electricoutps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">燃气费</td>
												<td id="gas_info" class="cass"></td>
												<td id="gasps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="5">小计:<span style="color: red;" id="sum1_info"></span>
												</td>
											</tr>
										</table>
										<table class="table table-striped table-bordered table-hover">
											<tr>
												<td colspan="3" style="text-align: center;">项目</td>
												<td style="text-align: center;">预算</td>
												<td style="text-align: center;">备注</td>
											</tr>
											<tr>
												<td rowspan="16" style="vertical-align: middle;">办公总务</td>
												<td colspan="2">办公用品</td>
												<td id="stationery_info" class="cass"></td>
												<td id="stationeryps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">电话、通信费等</td>
												<td id="communication_info" class="cass"></td>
												<td id="communicationps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">饮用水等</td>
												<td id="drinkwater_info" class="cass"></td>
												<td id="drinkwaterps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="2">门牌制作等</td>
												<td id="doorplate_info" class="cass"></td>
												<td id="doorplateps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">节假日布置</td>
												<td id="decorate_info" class="cass"></td>
												<td id="decorateps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">保洁用品</td>
												<td id="cleanser_info" class="cass"></td>
												<td id="cleanserps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">绿化费</td>
												<td id="afforestation_info" class="cass"></td>
												<td id="afforestationps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">劳防用品</td>
												<td id="ppe_info" class="cass"></td>
												<td id="ppeps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">垃圾清运费</td>
												<td id="trashcleaning_info" class="cass"></td>
												<td id="trashcleaningps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">应急物资</td>
												<td id="emergencymaterial_info" class="cass"></td>
												<td id="emergencymaterialps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">外墙、水箱清洗</td>
												<td id="wallwashing_info" class="cass"></td>
												<td id="wallwashingps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">报警服务费</td>
												<td id="alarmservice_info" class="cass"></td>
												<td id="alarmserviceps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">灭虫害服务费</td>
												<td id="pestcontrol_info" class="cass"></td>
												<td id="pestcontrolps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">污水处理（疏通）费</td>
												<td id="sewerage_info" class="cass"></td>
												<td id="sewerageps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">地坪保养费</td>
												<td id="maintenance_info" class="cass"></td>
												<td id="maintenanceps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="2">其他</td>
												<td id="office_info" class="cass"></td>
												<td id="officeps_info" class="cass"></td>
											</tr>

											<tr>
												<td colspan="5">小计:<span style="color: red;" id="sum2_info">
												</span>
												</td>
											</tr>
										</table>
										<table class="table table-striped table-bordered table-hover">
											<tr>
												<td>其他</td>
												<td id="other_info" class="cass"></td>
												<td id="otherps_info" class="cass"></td>
											</tr>
											<tr>
												<td colspan="3">小计:<span style="color: red;" id="sum3_info"></span>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer no-margin-top">
						<div class="text-center">
							<button class="btn btn-app btn-pink btn-xs" data-dismiss="modal">
								<i class="ace-icon fa fa-share bigger-160"></i> 取消
							</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

<!-- page specific plugin scripts -->
<script type="text/javascript">
		var scripts = [ null, "${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js", "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js", "${contextPath}/static/assets/js/jquery-ui.custom.js",
		        		"${contextPath}/static/assets/js/jquery.ui.touch-punch.js", "${contextPath}/static/assets/js/markdown/markdown.js", "${contextPath}/static/assets/js/markdown/bootstrap-markdown.js",
		        		,"${contextPath}/static/assets/js/echarts.js","${contextPath}/static/assets/js/select2.js","${contextPath}/static/assets/js/jquery.hotkeys.js", 
		        		"${contextPath}/static/assets/js/bootstrap-wysiwyg.js", "${contextPath}/static/assets/js/bootbox.js", "${contextPath}/static/assets/js/jquery.gritter.js", null ]
      
		$(".page-content-area").ace_ajax("loadScripts", scripts, function() {
        	// inline scripts related to this page
        	jQuery(function($) {
        		
        		var grid_selector = "#repoert-table";
        		var pager_selector = "#grid-pager";

        		// resize to fit page size
        		$(window).on("resize.jqGrid", function() {
        			$(grid_selector).jqGrid("setGridWidth", $(".page-content").width());
        		})
        		// resize on sidebar collapse/expand
        		var parent_column = $(grid_selector).closest("[class*='col-']");
        		$(document).on("settings.ace.jqGrid", function(ev, event_name, collapsed) {
        			if (event_name === "sidebar_collapsed" || event_name === "main_container_fixed") {
        				// setTimeout is for webkit only to give time for DOM changes and then redraw!!!
        				setTimeout(function() {
        					$(grid_selector).jqGrid("setGridWidth", parent_column.width());
        				}, 0);
        			}
        		})
        		
        		getbuildMsg();
        		
        		$(document).keydown(function(event) {
					var key = window.event ? event.keyCode : event.which;
					if (key == 13) {
						if ($("#search-input").val() == "") {
	        				$.gritter.add({
	    		                title: "系统信息",
	    		                text: "请输入检索词",
	    		                class_name: "gritter-info gritter-center"
	    		            });  
	    			        return;
	    			    } else {
	    			    	$.ajax({
	            				dataType : "json",
	            				url : "${contextPath}/sys/information/getInformationHibernateSearch",
	            				type : "post",
	            				data : {
	            					luceneName : $("#search-input").val()
	            				},
	            				complete : function(response) {
	            					var result = eval("("+response.responseText+")");
	            					jQuery(grid_selector)[0].addJSONData(result);
	            				}
	            			});
	    			    }
					}
				});
        		
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : "${contextPath}/recode/achievement/getsumToTable",
        			datatype : "json",
        			height : 450,
        			width : 770,
        			colNames : ["编号","楼宇名称", "年份","预算","一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月",""],
        			colModel : [ 
						{
							 name:'build',
							 width : 150,
							 hidden:true,
						},
						{
							name : "name",
							width : 150,
							searchoptions : {sopt : ["cn","eq"]},
						},{
							name : "year",
							width : 50,
							searchoptions : {sopt : ["cn","eq"]},
						},{
							name : "dugetsum",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="budgetsumInfo(\''+rows.build+'\',\''+rows.year+'\')">'+rows.dugetsum+'</a>';
	        				}
						},{
							name : "jan",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'1\')">'+rows.jan+'</a>';
	        				}
						},{
							name : "feb",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'2\')">'+rows.feb+'</a>';
	        				}
						},{
							name : "mar",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'3\')">'+rows.mar+'</a>';
	        				}
						},{
							name : "apr",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'4\')">'+rows.apr+'</a>';
	        				}
						},{
							name : "may",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'5\')">'+rows.may+'</a>';
	        				}
						},{
							name : "jun",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'6\')">'+rows.jun+'</a>';
	        				}
						},{
							name : "jul",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'7\')">'+rows.jul+'</a>';
	        				}
						},{
							name : "aug",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'8\')">'+rows.aug+'</a>';
	        				}
						},{
							name : "sept",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'9\')">'+rows.sept+'</a>';
	        				}
						},{
							name : "oct",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'10\')">'+rows.oct+'</a>';
	        				}
						},{
							name : "nov",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" style="cursor:pointer;" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'11\')">'+rows.nov+'</a>';
	        				}
						},{
							name : "dece",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="" onclick="monthsumInfo(\''+rows.build+'\',\''+rows.year+'\',\'12\')">'+rows.dece+'</a>';
	        				}
						},{
							name : "",
							width : 100,
							search:false,
							formatter:function(value,options,rows){
	        					return '<a class="btn btn-info btn-sm" onclick="report(\''+rows.build+'\',\''+rows.year+'\')">导出报表</a>';
	        				}
						},
        			],
        			//scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
        			sortname : "id",
        			sortorder : "asc",
        			viewrecords : true,
        			rowNum : 10,
        			rowList : [ 10, 20, 30 ],
        			pager : pager_selector,
        			altRows : true,
        			//toppager : true,
        			multiselect : true,
        			//multikey : "ctrlKey",
        	        multiboxonly : true,
        			loadComplete : function() {
        				var table = this;
        				setTimeout(function(){
        					styleCheckbox(table);
        					updateActionIcons(table);
        					updatePagerIcons(table);
        					enableTooltips(table);
        				}, 0);
        			},
        			editurl : null,
	       			onSelectRow: function (id){
	       				return;
	       				getreporttable(id);
	                }
        			
        		});
        		
        		$(window).triggerHandler("resize.jqGrid");// trigger window resize to make the grid get the correct size
        		
        		// enable search/filter toolbar
        		// jQuery(grid_selector).jqGrid("filterToolbar",{defaultSearch:true,stringResult:true})
        		// jQuery(grid_selector).filterToolbar({});
        		// switch element when editing inline
        		function aceSwitch(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find("input[type=checkbox]").addClass("ace ace-switch ace-switch-5").after("<span class='lbl'></span>");
        			}, 0);
        		}
        		
        		$("#editor").ace_wysiwyg({
        			toolbar:
        			[
        				"font",
        				null,
        				"fontSize",
        				null,
        				{name:"bold", className:"btn-info"},
        				{name:"italic", className:"btn-info"},
        				{name:"strikethrough", className:"btn-info"},
        				{name:"underline", className:"btn-info"},
        				null,
        				{name:"insertunorderedlist", className:"btn-success"},
        				{name:"insertorderedlist", className:"btn-success"},
        				{name:"outdent", className:"btn-purple"},
        				{name:"indent", className:"btn-purple"},
        				null,
        				{name:"justifyleft", className:"btn-primary"},
        				{name:"justifycenter", className:"btn-primary"},
        				{name:"justifyright", className:"btn-primary"},
        				{name:"justifyfull", className:"btn-inverse"},
        				null,
        				{name:"createLink", className:"btn-pink"},
        				{name:"unlink", className:"btn-pink"},
        				null,
        				{name:"insertImage", className:"btn-success"},
        				null,
        				"foreColor",
        				null,
        				{name:"undo", className:"btn-grey"},
        				{name:"redo", className:"btn-grey"}
        			],
        			"wysiwyg": {
        				fileUploadError: showErrorAlert
        			}
        		}).prev().addClass("wysiwyg-style3");
        		
        		function showErrorAlert(reason, detail) {
        			var msg = "";
        			if (reason === "unsupported-file-type") {
        				msg = "Unsupported format " + detail;
        			} else {
        				// console.log("error uploading file", reason, detail);
        			}
        			$("<div class='alert'> <button type='button' class='close' data-dismiss='alert'>&times;</button>" + "<strong>File upload error</strong> " + msg + " </div>").prependTo("#alerts");
        		}
        		
        		$("#addInformationButton").bind("click", function() {
        			$("#id").val('');
    				$("#modal-table").modal("toggle");
    				$("#informationForm")[0].reset();
    				$("#editor").html("");
    				$("#modal-tip").html("");
        		});
        		
        		$("#editInformationButton").bind("click", function() {
        			var selectedId = $(grid_selector).jqGrid("getGridParam", "selrow");
        			if(null == selectedId){
        				$.gritter.add({
    		                title: "系统信息",
    		                text: "请选择记录",
    		                class_name: "gritter-info gritter-center"
    		            });        				
        			}else{
        				$("#modal-table").modal("toggle");
        				$("#id").val(jQuery(grid_selector).jqGrid("getRowData",jQuery(grid_selector).jqGrid("getGridParam", "selrow")).id);
        				$("#name").val(jQuery(grid_selector).jqGrid("getRowData",jQuery(grid_selector).jqGrid("getGridParam", "selrow")).name);
        				$("#address").val(jQuery(grid_selector).jqGrid("getRowData",jQuery(grid_selector).jqGrid("getGridParam", "selrow")).address);
        				$("#contact").val(jQuery(grid_selector).jqGrid("getRowData",jQuery(grid_selector).jqGrid("getGridParam", "selrow")).contact);
        				$("#manager").val(jQuery(grid_selector).jqGrid("getRowData",jQuery(grid_selector).jqGrid("getGridParam", "selrow")).manager);
        				$("#comment").val(jQuery(grid_selector).jqGrid("getRowData",jQuery(grid_selector).jqGrid("getGridParam", "selrow")).comment);
        				$("#propertyfee").val(jQuery(grid_selector).jqGrid("getRowData",jQuery(grid_selector).jqGrid("getGridParam", "selrow")).propertyfee);
        			}
        		});
        		
        		$("#informationForm").on("submit", function(e) {
        			var data = new Object();
        			data.name=$("#name").val();
        			data.address=$("#address").val();
        			data.contact=$("#contact").val();
        			data.manager=$("#manager").val();
        			data.comment=$("#comment").val();
        			data.propertyfee=$("#propertyfee").val();
        			if($("#id").val() == '' || $("#id").val() == null || $("#id").val() == undefined){
        			}else{
        				data.id = $("#id").val();
        			}
   			    	$.ajax({
           				dataType : "json",
           				url : "${contextPath}/recode/build/saveOrupdatBuild",
           				type : "post",
           				contentType: 'application/json',
              			data :JSON.stringify(data),
           				complete : function(xmlRequest) {
           					$("#modal-table").modal("toggle");
           					jQuery(grid_selector).trigger("reloadGrid");
           				}
           			});
    			    
        		});
        		
        		// navButtons
        		jQuery(grid_selector).jqGrid("navGrid", pager_selector, { // navbar options
        			edit : false,
        			editicon : "ace-icon fa fa-pencil blue",
        			add : false,
        			addicon : "ace-icon fa fa-plus-circle purple",
        			del : <shiro:hasPermission name="${ROLE_KEY}:countReport:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:countReport:delete">false</shiro:lacksPermission>,
        			delicon : "ace-icon fa fa-trash-o red",
        			search : <shiro:hasPermission name="${ROLE_KEY}:countReport:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:countReport:search">false</shiro:lacksPermission>,
        			searchicon : "ace-icon fa fa-search orange",
        			refresh : true,
        			refreshicon : "ace-icon fa fa-refresh blue",
        			view : <shiro:hasPermission name="${ROLE_KEY}:countReport:view">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:countReport:view">false</shiro:lacksPermission>,
        			viewicon : "ace-icon fa fa-search-plus grey"
        		}, {
        			// edit record form
        			// closeAfterEdit: true,
        			// width: 700,
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest(".ui-jqdialog").find(".ui-jqdialog-titlebar").wrapInner("<div class='widget-header' />")
        				style_edit_form(form);
        			},
    				errorTextFormat: function (response) {
    					var result = eval("("+response.responseText+")");
    				    return result.message;
    				}
        		}, {
        			// new record form
        			// width: 700,
        			closeAfterAdd : true,
        			recreateForm : true,
        			viewPagerButtons : false,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest(".ui-jqdialog").find(".ui-jqdialog-titlebar").wrapInner("<div class='widget-header' />")
        				style_edit_form(form);
        			},
    				errorTextFormat: function (response) {
    					var result = eval("("+response.responseText+")");
    				    return result.message;
    				}
        		}, {
        			// delete record form
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				if (form.data("styled"))
        					return false;
        				form.closest(".ui-jqdialog").find(".ui-jqdialog-titlebar").wrapInner("<div class='widget-header' />")
        				style_delete_form(form);
        				form.data("styled", true);
        			},
        			onClick : function(e) {
        				// alert(1);
        			}
        		}, {
        			// search form
        			recreateForm : true,
        			afterShowSearch : function(e) {
        				var form = $(e[0]);
        				form.closest(".ui-jqdialog").find(".ui-jqdialog-title").wrap("<div class='widget-header' />")
        				style_search_form(form);
        			},
        			afterRedraw : function() {
        				style_search_filters($(this));
        			},
        			multipleSearch : true 
	        		/**
	        		 * multipleGroup:true, showQuery: true
	        		 */
        		}, {
        			// view record form
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest(".ui-jqdialog").find(".ui-jqdialog-title").wrap("<div class='widget-header' />")
        			}
        		})
        		
        		// add custom button to export the data to excel
        		if(<shiro:hasPermission name="${ROLE_KEY}:countReport:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:countReport:export">false</shiro:lacksPermission>){
    				jQuery(grid_selector).jqGrid("navButtonAdd", pager_selector,{
   					   caption : "",
   				       title : "导出Excel",
   				       buttonicon : "ace-icon fa fa-file-excel-o green", 
   				       onClickButton : function () { 
   				    	   var keys = [], ii = 0, rows = "";
   				    	   var ids = $(grid_selector).getDataIDs(); // Get All IDs
   				    	   var row = $(grid_selector).getRowData(ids[0]); // Get First row to get the labels
   				    	   //var label = $(grid_selector).jqGrid("getGridParam","colNames");
   	   			    	   for (var k in row) {
   				    	   	   keys[ii++] = k; // capture col names
   				    	   	   rows = rows + k + "\t"; // output each Column as tab delimited
   				    	   }
   				    	   rows = rows + "\n"; // Output header with end of line
   				    	   for (i = 0; i < ids.length; i++) {
   				    	   	   row = $(grid_selector).getRowData(ids[i]); // get each row
   				    	   	   for (j = 0; j < keys.length; j++)
   				    	   		   rows = rows + row[keys[j]] + "\t"; // output each Row as tab delimited
   				    	   	   rows = rows + "\n"; // output each row with end of line
   				    	   }
   				    	   rows = rows + "\n"; // end of line at the end
   				    	   var form = "<form name='csvexportform' action='${contextPath}/sys/information/operateInformation?oper=excel' method='post'>";
   				    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
   				    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
   				    	   OpenWindow = window.open("", "");
   				    	   OpenWindow.document.write(form);
   				    	   OpenWindow.document.close();
   				       } 
   					});        			
        		}
        		
        		function style_edit_form(form) {
        			// form.find("input[name=statusCn]").addClass("ace ace-switch ace-switch-5").after("<span class="lbl"></span>");
        			// don"t wrap inside a label element, the checkbox value won"t be submitted (POST"ed)
        			// .addClass("ace ace-switch ace-switch-5").wrap("<label class="inline" />").after("<span class="lbl"></span>");

        			// update buttons classes
        			var buttons = form.next().find(".EditButton .fm-button");
        			buttons.addClass("btn btn-sm").find("[class*='-icon']").hide();// ui-icon, s-icon
        			buttons.eq(0).addClass("btn-primary").prepend("<i class='ace-icon fa fa-check'></i>");
        			buttons.eq(1).prepend("<i class='ace-icon fa fa-times'></i>")

        			buttons = form.next().find(".navButton a");
        			buttons.find(".ui-icon").hide();
        			buttons.eq(0).append("<i class='ace-icon fa fa-chevron-left'></i>");
        			buttons.eq(1).append("<i class='ace-icon fa fa-chevron-right'></i>");
        		}

        		function style_delete_form(form) {
        			var buttons = form.next().find(".EditButton .fm-button");
        			buttons.addClass("btn btn-sm btn-white btn-round").find("[class*='-icon']").hide();// ui-icon, s-icon
        			buttons.eq(0).addClass("btn-danger").prepend("<i class='ace-icon fa fa-trash-o'></i>");
        			buttons.eq(1).addClass("btn-default").prepend("<i class='ace-icon fa fa-times'></i>")
        		}

        		function style_search_filters(form) {
        			form.find(".delete-rule").val("X");
        			form.find(".add-rule").addClass("btn btn-xs btn-primary");
        			form.find(".add-group").addClass("btn btn-xs btn-success");
        			form.find(".delete-group").addClass("btn btn-xs btn-danger");
        		}
        		
        		function style_search_form(form) {
        			var dialog = form.closest(".ui-jqdialog");
        			var buttons = dialog.find(".EditTable");
        			buttons.find(".EditButton a[id*='_reset']").addClass("btn btn-sm btn-info").find(".ui-icon").attr("class", "ace-icon fa fa-retweet");
        			buttons.find(".EditButton a[id*='_query']").addClass("btn btn-sm btn-inverse").find(".ui-icon").attr("class", "ace-icon fa fa-comment-o");
        			buttons.find(".EditButton a[id*='_search']").addClass("btn btn-sm btn-purple").find(".ui-icon").attr("class", "ace-icon fa fa-search");
        		}

        		function beforeDeleteCallback(e) {
        			var form = $(e[0]);
        			if (form.data("styled"))
        				return false;
        			form.closest(".ui-jqdialog").find(".ui-jqdialog-titlebar").wrapInner("<div class='widget-header' />")
        			style_delete_form(form);
        			form.data("styled", true);
        		}

        		function beforeEditCallback(e) {
        			var form = $(e[0]);
        			form.closest(".ui-jqdialog").find(".ui-jqdialog-titlebar").wrapInner("<div class='widget-header' />")
        			style_edit_form(form);
        		}

        		// it causes some flicker when reloading or navigating grid
        		// it may be possible to have some custom formatter to do this as the grid is being created to prevent this
        		// or go back to default browser checkbox styles for the grid
        		function styleCheckbox(table) {
        			/**
        			 * $(table).find("input:checkbox").addClass("ace") .wrap("<label />") .after("<span class="lbl align-top" />") $(".ui-jqgrid-labels th[id*="_cb"]:first-child")
        			 * .find("input.cbox[type=checkbox]").addClass("ace") .wrap("<label />").after("<span class="lbl align-top" />");
        			 */
        		}

        		// unlike navButtons icons, action icons in rows seem to be hard-coded
        		// you can change them like this in here if you want
        		function updateActionIcons(table) {
        			/**
        			 * var replacement = { "ui-ace-icon fa fa-pencil" : "ace-icon fa fa-pencil blue", "ui-ace-icon fa fa-trash-o" : "ace-icon fa fa-trash-o red", "ui-icon-disk" : "ace-icon fa fa-check green", "ui-icon-cancel" :
        			 * "ace-icon fa fa-times red" }; $(table).find(".ui-pg-div span.ui-icon").each(function(){ var icon = $(this); var $class = $.trim(icon.attr("class").replace("ui-icon", "")); if($class in replacement)
        			 * icon.attr("class", "ui-icon "+replacement[$class]); })
        			 */
        		}

        		// replace icons with FontAwesome icons like above
        		function updatePagerIcons(table) {
        			var replacement = {
        				"ui-icon-seek-first" : "ace-icon fa fa-angle-double-left bigger-140",
        				"ui-icon-seek-prev" : "ace-icon fa fa-angle-left bigger-140",
        				"ui-icon-seek-next" : "ace-icon fa fa-angle-right bigger-140",
        				"ui-icon-seek-end" : "ace-icon fa fa-angle-double-right bigger-140"
        			};
        			$(".ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon").each(function() {
        				var icon = $(this);
        				var $class = $.trim(icon.attr("class").replace("ui-icon", ""));

        				if ($class in replacement)
        					icon.attr("class", "ui-icon " + replacement[$class]);
        			})
        		}

        		function enableTooltips(table) {
        			$(".navtable .ui-pg-button").tooltip({
        				container : "body"
        			});
        			$(table).find(".ui-pg-div").tooltip({
        				container : "body"
        			});
        		}

        		// var selr = jQuery(grid_selector).jqGrid("getGridParam","selrow");

        		$(document).one("ajaxloadstart.page", function(e) {
        			$(grid_selector).jqGrid("GridUnload");
        			$(".ui-jqdialog").remove();
        		});
        		
        	});
        });
		
		function getbuildMsg(){
	    	$('#lyxx').select2({
	            ajax: {
	                type:"get",
	                url : "${contextPath}/recode/build/getBuildByCondition",
	                contentType: 'application/json',
	                dataType:"JSON",
	                delay: 550,
	                data: function (params) {
	                	params.page = 1;
	                	params.rows = 10;
	                	params.filters = '{"groupOp":"AND","rules":[{"field":"name","op":"cn","data":"'+checknull(params.term)+'"}]}';
	                    return params;
	                },
	                processResults: function (data, params) {
	                    params.page = params.page ? 1 : params.page;
	                    var itemList = [];
	                    var row = data.rows;
	                    for(var i=0;i<row.length;i++){
	                        itemList.push({id: row[i].id, text: row[i].name});
	                    }
	                    return {
	                        results: itemList,
	                        pagination: {
	                            more: (params.page * 10) < data.totalNumber
	                        }
	                    };
	                },
	                cache: true
	            },
	            multiBoolean:false,
	            language: "zh-CN",
	            placeholder:'--请选择--',//默认文字提示
	            allowClear: true,//允许清空
	            escapeMarkup: function (markup) { return markup; }, // 自定义格式化防止xss注入
	            templateResult: function formatRepo(repo){return repo.text;}, // 函数用来渲染结果
	            templateSelection: function formatRepoSelection(repo){return repo.text;} // 函数用于呈现当前的选择
	        });
	    }
		
		 function getAchievementMsgxx(){
	        jQuery("#repoert-table").jqGrid('setGridParam',{
	            datatype:'json',
	            postData:{'build':$("#lyxx").val()}, //发送数据
	            page:1
	        }).trigger("reloadGrid"); //重新载入
	    }
		 function checknull(val){
				if(val == null || val == undefined || val == "undefined" || val == 'null' ){
					return '';
				}
				return val;
			}
		 
		 
		 function report(build,year){
			var data = new Object();
			data.build = build;
			data.year = year;
			 $.ajax({
    				dataType : "json",
    				url : "${contextPath}/recode/achievement/getExport",
    				type : "post",
    				contentType: 'application/json',
    				data :JSON.stringify(data),
    				complete : function(xmlRequest) {
    					if(xmlRequest.status == 200){
    						if( xmlRequest.responseText == '999'){
    							setTimeout(function(){
    								window.location.href = '${contextPath}/static/word/20180001.xlsx';
    							}, 1000);
        					}
    	                }
    				}
    			});
		 }
		 
		 function getreporttable(id){
				var rowdate = $("#repoert-table").jqGrid('getRowData',id);
			 	
                $("#modal-table").modal("toggle");
                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('main'));

                // 指定图表的配置项和数据
                var option = {
                    title: {
                        text: '月实绩曲线图'
                    },
                    xAxis: {
                        type: 'category',
                        data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月','八月','八月','九月','十月','十一月','十二月']
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        data: [rowdate.jan, rowdate.feb, rowdate.mar, rowdate.apr, rowdate.may, rowdate.jun, rowdate.jul,rowdate.aug,rowdate.sept,rowdate.oct,rowdate.nov,rowdate.dece],
                        type: 'line',
                        smooth:true,
                        itemStyle : { normal: {label : {show: true}}}
                    }]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);

	            
		 }
		 
		 //年度预算
		 function budgetsumInfo(id,year){
			 clearInfo();
			 $.ajax({
		            dataType : "json",
		            url : "${contextPath}//recode/budget/getBudgetByCondition?page=1&rows=1&build="+id+"&year="+year,
		            type : "post",
		            contentType: 'application/json',
		            data :null,
		            complete : function(xmlRequest) {
		                console.log(xmlRequest);
		                if(xmlRequest.status == 200){
		                    var data = JSON.parse(xmlRequest.responseText).rows;
		                    infobudgetInfoToview(data);
		                }

		            }
		        });
			 $("#modal-htxx_test").modal("show");
		 }
		//详情
	    function infobudgetInfoToview(list){
	        var data =  list[0];
	        $('#sum0_info').html(data.sumincome);
	        $('#sum1_info').html(data.sumenergy);
	        $('#sum2_info').html(data.sumoffice);
	        $('#sum3_info').html(data.sumelsed);
	        $('#sum_info').html(parseFloat(data.sumincome) - parseFloat(data.sumcost));
	        for(var param in data){
	            $('.cass').each(function(i){
	                console.log($(this).attr('id').split('_info')[0]);
	                if($(this).attr('id').split('_info')[0] == param){
	                    $(this).html(data[param]);
	                    return false; //跳出循环
	                }
	            });
	        }
	    }
		
		//月度详情
		function monthsumInfo(id,year,month){
			clearInfo();
			$.ajax({
	            dataType : "json",
	            url : "${contextPath}//recode/achievement/getAchievementByCondition?page=1&rows=1&build="+id+"&year="+year+"&month="+month,
	            type : "post",
	            contentType: 'application/json',
	            data :null,
	            complete : function(xmlRequest) {
	                console.log(xmlRequest);
	                if(xmlRequest.status == 200){
	                    var list = JSON.parse(xmlRequest.responseText).rows;
	                    var data =  list[0];
	                    $('#sum0_info').html(data.sumincome);
	                    $('#sum1_info').html(data.sumenergy);
	                    $('#sum2_info').html(data.sumoffice);
	                    $('#sum3_info').html(data.sumelsed);
	                    $('#sum_info').html(parseFloat(data.sumincome) - parseFloat(data.sumcost));
	                    for(var param in data){
	                        $('.cass').each(function(i){
	                            console.log($(this).attr('id').split('_info')[0]);
	                            if($(this).attr('id').split('_info')[0] == param){
	                                $(this).html(data[param]);
	                                return false; //跳出循环
	                            }
	                        });
	                    }
	                }

	            }
	        });
	        $("#modal-htxx_test").modal("show");
		}
		
		function clearInfo(){
			$("#modal-htxx_test td").each(function (){
				var id = $(this).attr('id');
				if(id != null && id != undefined && id.indexOf("_info") != -1){
					$(this).html('');
				}
			});
			 $('#sum0_info').html('');
             $('#sum1_info').html('');
             $('#sum2_info').html('');
             $('#sum3_info').html('');
             $('#sum_info').html('');
		}
</script>
