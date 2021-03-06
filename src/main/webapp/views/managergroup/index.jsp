<%--
  Created by IntelliJ IDEA.
  User: 20150831
  Date: 2015/9/17
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
  <script type="text/javascript" src="/static/scripts/jquery.min.js"></script>
  <!--   EasyUI Start-->
  <link rel="stylesheet" type="text/css" href="/static/easyui/themes/default/easyui.css" />
  <link rel="stylesheet" type="text/css" href="/static/easyui/themes/icon.css" />
  <script type="text/javascript" src="/static/easyui/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="/static/easyui/locale/easyui-lang-zh_CN.js"></script>
  <script type="text/javascript" src="/static/scripts/easyui.formatter.expend.js"></script>
  <script type="text/javascript" src="/static/scripts/easyui.validator.expend.js"></script>
  <!--   EasyUI End-->
  <script type="text/javascript" src="/static/My97DatePicker/WdatePicker.js"></script>
  <link type="text/css" href="/static/styles/admin.css" rel="stylesheet" />
  <script type="text/javascript" src="/static/scripts/common.js"></script>
  <script type="text/javascript" src="/static/scripts/validator.js"></script>
  <script type="text/javascript" src="/static/scripts/city.js"></script>
  <!--ueditor-->
  <script type="text/javascript" src="/static/ueditor/ueditor.config.js"></script>
  <script type="text/javascript" src="/static/ueditor/ueditor.all.min.js"></script>
  <script type="text/javascript" src="/static/ueditor/lang/zh-cn/zh-cn.js"></script>
  <style type="text/css">
    td input
    {
      margin-left: 0 !important;
    }
    /* 因为admin.css 里的 td input 样式会使 combogrid 下拉框错位 所以加下面的样式 */
    .combobox-item
    {
      height: 20px;
    }
    /*EassyUI 下拉框第一项为空时,撑开第一项 */
    .ke-dialog-body .tabs
    {
      height: 0px;
      border: 0px;
    }
    /*KindEdit 的图片上传选择框和EasyUI样式冲突 */
    .datagrid-cell
    {
      white-space: normal !important;
    }
    /*easyui列自动换行*/
    .datagrid-row-selected
    {
      background: #E9F9F9 !important;
    }
    .field-validation-valid
    {
      color: Red;
    }
    .clearfix:before, .clearfix:after
    {
      content: "";
      display: table;
    }

    .clearfix:after
    {
      clear: both;
    }

    /* For IE 6/7 (trigger hasLayout) */
    .clearfix
    {
      zoom: 1;
    }
    .container
    {
      background: #E0EDFE;
      margin-top:0px;
      padding: 0;
      padding-top: 10px;
      width: 100%;
      min-width: 500px
    }
    .con_border
    {
      border: 1px solid #9c9c9c;
      padding: 10px;
      position: relative;
    }
    .con_til
    {
      background: #E0EDFE;
      font: 12px Tahoma,SimSun;
      position: absolute;
      top: -20px;
      padding: 0 5px;
    }
    .con_bg
    {
      overflow: hidden;
      padding-top: 10px;
    }
    .input_text
    {
      margin-right: 3px;
    }
    .input_style
    {
      background: #fff;
      border: 1px solid #ddd;
      height: 20px;
      line-height: 20px;
    }
    .input_blo
    {
      display: inline;
      float: left;
      height: 25px;
      margin: 2px 3px;
    }
  </style>
</head>
<body style="min-width: 800px;">
<form id="schForm">

  <div class="container" id="querycontainer">
    <div class="con_border">
      <h3 class="con_til">
        信息查询</h3>
      <div class="con_bg clearfix">
                <span class="input_blo"><span class="input_text">角色名称</span> <span class="">
                    <input class="adm_21" id="rolename" name="rolename" style="width: 100px;"
                          />

                </span></span>
        <span class="input_blo"><a href="javascript:onSearch()" class="easyui-linkbutton"
                                                                                 iconcls="icon-search">查询</a></span>
         <span class="input_blo"><a href="javascript:onAdd()" class="easyui-linkbutton"
                                    iconcls="icon-search">添加</a></span>
      </div>
    </div>
  </div>
  <div id="toolbar" class="datagrid-toolbar">
    <table>
      <tr>
        <td colspan="12">

        </td>
      </tr>
    </table>
    <div style="clear: both;">
    </div>
  </div>
</form>
<table id="gdgrid">
</table>

<div id="addwindow" title="添加角色"  style="width:600px; height:400px;">
</div>
<script type="text/javascript">
  //初始化
  $(function () {
    resizeTable();
    bindGrid();
    bindWin();

  });
  function resizeTable() {
    var height = ($(window).height() - $("#querycontainer").height()+200);
    var width = $(window).width();
    $("#gdgrid").css("height", height);
    $("#gdgrid").css("width", width);
  }

  function bindWin() {
    $("[id$=window]").window({
      modal: true,
      collapsible: false,
      minimizable: false,
      maximizable: false,
      closed: true
    });
  }
  //绑定数据表格
  function bindGrid() {

    $('#gdgrid').datagrid({
      url: "/managergroup/list?" + $("#schForm").serialize(),
      method: 'get',
      pagination: false,
      rownumbers: false,
      singleSelect: true,
      fitColumns: false,
      pageList: [15, 30, 45, 60],
      pageSize: 15,
      title: "角色管理",
      toolbar: "#toolbar",
      showFooter: false,
      columns: [
        [  { field: 'ck', checkbox: true, width: 50 },
          { field: 'rolename', title: '角色名称', width: 130},
          { field: 'description', title: '角色描述', width: 300  },
          { field: 'createtime', title: '创建时间', width: 300 }
        ]
      ]

    });
  }

  function onEdit() {
    edit("gdgrid", "editwindow", "orderId", "/Order/OrderEdit.aspx?id=");
  }
  function onAdd(){
    $('#addwindow').window('open');
    $('#addwindow').window('refresh', '/managergroup/groupadd');
  }

  function onDelete() {
    ajaxdelete("rentCar", "id", "id", "gdgrid", onSearch);
  }
  function onClose() {
    $('[id$=window]').window('close');
    onSearch();
  }
  function onSearch(){
    $("#gdgrid").datagrid("options").url = "/managergroup/list?" + $("#schForm").serialize();
    $("#gdgrid").datagrid("load");
  }



</script>
</body>
</html>
