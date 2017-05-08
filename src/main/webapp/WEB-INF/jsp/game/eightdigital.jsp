<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sdf" %>
<tiles:insertDefinition name="console">
    <tiles:putAttribute name="title" value="八数码"></tiles:putAttribute>
    <tiles:putAttribute name="head">
        <script type="text/javascript">
            seajs.use(['jquery', 'myui.datatable', 'bootstrap', 'myutil.init'], function ($) {
                var baseUrl = '${__baseUrl}';
                var stepIndex = 0;
                $(function () {
                    var id = "123450678";
                    init(id);
                    $("#start").on('click', function () {
                        $.ajax({
                            url: baseUrl + "/game/ed/result",
                            data: {"id": id},
                            success: function (ret) {
                                $("#result").val(ret);
                                var stepText = "最少需要" + ret.length + "步:";
                                for (var i = 0; i < ret.length; i++) {
                                    var direction = ret.charAt(i);
                                    switch (direction) {
                                        case 'u':
                                            stepText += "上"
                                            break;
                                        case 'd':
                                            stepText += "下"
                                            break;
                                        case 'l':
                                            stepText += "左"
                                            break;
                                        case 'r':
                                            stepText += "右"
                                            break;
                                        default:
                                            break;
                                    }
                                }
                                $("#stepText").text(stepText);
                            }
                        });
                    });
                    $("#next").on('click', function () {
                        var ret = $("#result").val();
                        if(stepIndex==ret.length){
                            var stepText=$("#stepText").text()
                            if(stepText.indexOf("拼图已完成")==-1){
                                $("#stepText").text(stepText+",拼图已完成！");
                            }
                        }else{
                            var direction = ret.charAt(stepIndex);
                            updateNumber(direction);
                            stepIndex++;
                        }
                    });
                });
                function updateNumber(direction) {
                    var indexOf0;
                    $("#main .row div").each(function (index, value) {
                        $("#main .row div").eq(index).css("background-color","white");
                        if ($(value).html() == '&nbsp;') {
                            indexOf0 = index;
                        }
                    });
                    switch (direction) {
                        case 'u':
                            var index = indexOf0 - 3;
                            $("#main .row div").eq(indexOf0).html($("#main .row div").eq(index).html());
                            $("#main .row div").eq(index).html("&nbsp;");
                            $("#main .row div").eq(index).css("background-color","#7db9e8");
                            break;
                        case 'd':
                            var index = indexOf0 + 3;
                            $("#main .row div").eq(indexOf0).html($("#main .row div").eq(index).html());
                            $("#main .row div").eq(index).html("&nbsp;");
                            $("#main .row div").eq(index).css("background-color","#7db9e8");
                            break;
                        case 'l':
                            var index = indexOf0 - 1;
                            $("#main .row div").eq(indexOf0).html($("#main .row div").eq(index).html());
                            $("#main .row div").eq(index).html("&nbsp;");
                            $("#main .row div").eq(index).css("background-color","#7db9e8");
                            break;
                        case 'r':
                            var index = indexOf0 + 1;
                            $("#main .row div").eq(indexOf0).html($("#main .row div").eq(index).html());
                            $("#main .row div").eq(index).html("&nbsp;");
                            $("#main .row div").eq(index).css("background-color","#7db9e8");
                            break;
                        default:
                            break;
                    }
                }

                function init(id) {
                    $("#main .row div").each(function (index, value) {
                        if(id.charAt(index)=='0'){
                            $(value).html("&nbsp;");
                        }else{
                            $(value).html(id.charAt(index));
                        }
                    });
                    var indexOf0;
                    $("#main .row div").each(function (index, value) {
                        if ($(value).html() == '&nbsp;') {
                            indexOf0 = index;
                        }
                    });
                    $("#main .row div").eq(indexOf0).css("background-color","#7db9e8");
                }
            });
        </script>
        <style type="text/css">
            #main {
                width: 80%;
            }

            #main .row div {
                height: 50px;
                border: 1px solid #000000;
                text-align: center;
                line-height: 25px;
            }
        </style>
    </tiles:putAttribute>
    <tiles:putAttribute name="body">
        <div class="row">
            <div class="col-md-12" style="text-align: left;">
                <div class="form-inline">
                    <button id="start" class="btn btn-primary btn-query" type="button"><span
                            class="glyphicon glyphicon-search"></span> <span>查看步骤</span></button>
                    <button id="next" class="btn btn-primary btn-query" type="button"><span
                            class="glyphicon glyphicon-arrow-right"></span> <span>下一步</span></button>
                </div>
            </div>
            <div class="col-md-12" style="text-align: left;">
                <span id="stepText"></span>
            </div>
        </div>
        <input type="hidden" id="result"/>

        <div class="container" id="main">
            <div class="row">
                <div class="col-md-4">1</div>
                <div class="col-md-4">2</div>
                <div class="col-md-4">3</div>
            </div>
            <div class="row">
                <div class="col-md-4">4</div>
                <div class="col-md-4">5</div>
                <div class="col-md-4">6</div>
            </div>
            <div class="row">
                <div class="col-md-4">0</div>
                <div class="col-md-4">7</div>
                <div class="col-md-4">8</div>
            </div>
        </div>
    </tiles:putAttribute>
</tiles:insertDefinition>