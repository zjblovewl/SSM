<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/content/config/head.jsp" %>
<html>
<head>
    <title>交易详情</title>
    <style>
        .seeMember_div {
            width: 90%;
            margin: 20px auto;
        }

        .layui-border-box {
            width: auto !important;
            height: auto !important;
        }

        .layui-table {
            width: 100%;
        }

        .layui-table-body {
            height: auto !important;
        }

        .layui-table-view {
            position: relative;
            margin: 10px 37px;
            overflow: hidden;
            text-align: -webkit-center;
        }

        .laytable-cell-1-id {
            display: none;
        }

        .layui-table-page {
            height: 26px;
            width: 100%;
            text-align: center;
        }

        .table {
            width: 60%;
            max-width: 100%;
            margin-bottom: 20px;
            margin: 0px auto;
            text-align: center;
        }

        .img-thumbnail {
            border-radius: 50%;
            width: 41px;
        }

        #tran_ {
            position: absolute;
            top: 41px;
            right: 13%;
        }
    </style>
</head>
<body>
<table class="table .table-condensed">
    <tr>
        <td rowspan="3">
            <img src="${img}/login/tou.png" alt="..." class="img-thumbnail">
            <div>姓名：${item.membername}</div>
        </td>
        <td>姓名：${item.sex}</td>
        <td>生日:${item.birthdate}</td>
        <td>会员编号:${item.membernumber}</td>
    </tr>
    <tr>
        <td>手机号：${item.phonenumber}</td>

        <td>余额:${item.balance}元</td>
        <td>累计消费：${item.consumptionsum}</td>
    </tr>
</table>
<button class="layui-btn" id="tran_">交易</button>
<table class="layui-hide" id="LAY_table_user" lay-filter="user"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
</script>
<script>
    var mId = '${item.id}'
    $(function () {
        $("#tran_").click(function () {
            //iframe窗
            layer.open({
                type: 2,
                title: false,
                closeBtn: 2, //不显示关闭按钮
                shade: [0.3],
                area: ['80%', '80%'],
                maxmin: true, //开启最大化最小化按钮
                anim: 3,
                move: true,
                content: ['/admin/toTransaction?memberId=' + mId, 'no'], //iframe的url，no代表不显示滚动条
                end: function () { //此处用于演示

                }
            });
            $(".layui-layer-min").css("display", "none")
            $(".layui-layer").css("box-shadow", "1px 1px 20px 12px rgba(0,0,0,.3)")
        })
    })
    layui.use('table', function () {
        var table = layui.table
        var tableIns = table.render({
            elem: '#LAY_table_user'
            , loading: true
            , limit: 10 //默认采用60
            , url: '/admin/getTransactionDetail?id=' + mId
            , cols: [[
                {field: 'id', title: 'ID', width: 50, sort: true, fixed: true}
                , {field: 'pay', title: '支出', width: 150}
                , {field: 'balance', title: '余额', width: 80, sort: true}
                , {field: 'remarks', title: '备注', width: 180}
                , {field: 'time', title: '日期', width: 140}
                , {field: 'right', title: '操作', width: 177, toolbar: "#barDemo"}
            ]]
            , id: 'testReload'
            , page: true
            , height: 315
            , done:function () {
                    $(".laytable-cell-1-time").each(function(index,item){
                        if(index>0){
                                $(this).text(formatDate_ssm($(this).text(),"年","月","日"))
                        }
                    })
            }
    })
        ;

        $('#submit_search').on('click', function () {
            var num = $("#num").val();
            var phone = $("#phone").val();
            var mName = $("#mName").val();
            tableIns.reload({
                where: {
                    num: num
                    , phone: phone
                    , mName: mName
                }
            });
        });


        //监听工具条
        table.on('tool(user)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                layer.msg('ID：' + data.id + ' 的查看操作');
                window.location.href = "/admin/transaction"
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                layer.alert('编辑行：<br>' + JSON.stringify(data))
            }
        });
        updateTime();
    });

    function updateTime() {
        $(".laytable-cell-1-time").each(function (index, item) {
            console.log($(this).text())
//            $(this).text( formatDate($(this).text()))
            console.log()

        })
    }

    function formatDate(now) {
        var year = now.getFullYear(),
            month = now.getMonth() + 1,
            date = now.getDate(),
            hour = now.getHours(),
            minute = now.getMinutes(),
            second = now.getSeconds();

        return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
    }
</script>
</body>
</html>
