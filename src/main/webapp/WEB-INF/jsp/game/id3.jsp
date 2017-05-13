<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sdf" %>
<tiles:insertDefinition name="console">
    <tiles:putAttribute name="title" value="kmeans"></tiles:putAttribute>
    <tiles:putAttribute name="head">
        <link rel="stylesheet" href="/css/game/main.css">
        <script type="text/javascript">
            var baseUrl = '${__baseUrl}';
            var rootData=$.parseJSON('${root}');
            seajs.use(['jquery', 'myui.datatable', 'bootstrap', 'myutil.init',"highcharts"], function ($) {
                renderTree(rootData);
                function renderTree(json){
                    decisionTree.init({
                        container : '.svg-container',
                        data : json,
                        showPredictionPanel : true
                    });
                }
            });
        </script>
        <script src="/js/game/d3.js"></script>
        <script src="/js/game/decision-tree.js"></script>
        <script src="/js/game/lodash.js"></script>
        <style type="text/css">

        </style>
    </tiles:putAttribute>
    <tiles:putAttribute name="body">
        <div class="svg-container"></div>
    </tiles:putAttribute>
</tiles:insertDefinition>