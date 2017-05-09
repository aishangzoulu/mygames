<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sdf" %>
<tiles:insertDefinition name="console">
    <tiles:putAttribute name="title" value="kmeans"></tiles:putAttribute>
    <tiles:putAttribute name="head">
        <script type="text/javascript">
            seajs.use(['jquery', 'myui.datatable', 'bootstrap', 'myutil.init',"highcharts"], function ($) {
                var baseUrl = '${__baseUrl}';
                var stepIndex = 0;
                var pointsList;
                var clustersList;
                var colors=["yellow","green","red"];
                $(function () {
                    $("#start").on('click', function () {
                        $.ajax({
                            url: baseUrl + "/game/kmeans/result",
                            dataType:"json",
                            data: {"id": "1"},
                            success: function (ret) {
                                pointsList=ret.pointsList;
                                clustersList=ret.clustersList;
                                var seriesList=createSeriesList(pointsList,clustersList,stepIndex);
                                createChart(seriesList);
                            }
                        });
                    });
                    $("#next").on('click', function () {
                        $("#main").html();
                        stepIndex++;
                        var seriesList=createSeriesList(pointsList,clustersList,stepIndex);
                        console.info(seriesList);
                        createChart(seriesList);
                    });
                });

                function createSeriesList(pointsList,clustersList,stepIndex){
                    var data0=[];
                    var data1=[];
                    var data2=[];
                    var dataArr=[data0,data1,data2];
                    var points =pointsList[stepIndex];
                    var clusters=clustersList[stepIndex];
                    for(var index=0;index<points.length;index++){
                        var point=points[index];
                        if(point.cluster==0){
                            dataArr[0].push([point.x,point.y]);
                        }else if(point.cluster==1){
                            dataArr[1].push([point.x,point.y]);
                        }else{
                            dataArr[2].push([point.x,point.y]);
                        }
                    }
                    var seriesList=[];
                    for(var index=0;index<clusters.length;index++){
                        var series={
                            name: 'Cluster-'+index,
                            color:colors[index],
                            data:dataArr[index]
                        };
                        seriesList.push(series);
                    }
                    return seriesList;
                }

                function create(pointsList,clustersList){
                    var seriesList=[];
                    var initClusters=clustersList[0];
                    for(var index=0;index<initClusters.length;index++){
                        var cluster=initClusters[index];
                        var data=[];
                        for(var pIndex=0;pIndex<cluster.points.length;pIndex++){
                            var point=cluster.points[index];
                            data.push([point.x,point.y]);
                        }
                        var series={
                            name: 'Cluster-'+cluster.id,
                            color:colors[index],
                            data:data
                        };
                        seriesList.push(series);
                    }
                }

                function createChart(series) {
                    $("#main").highcharts( {
                        chart: {
                            type: 'scatter',
                            zoomType: 'xy'
                        },
                        title: {
                            text: 'K-Means聚类算法'
                        },
                        subtitle: {
                            text: 'random data'
                        },
                        xAxis: {
                            title: {
                                enabled: true,
                                text: 'Width (cm)'
                            },
                            startOnTick: true,
                            endOnTick: true,
                            showLastLabel: true
                        },
                        yAxis: {
                            title: {
                                text: 'Height (cm)'
                            }
                        },
                        legend: {
                            layout: 'vertical',
                            align: 'left',
                            verticalAlign: 'top',
                            x: 100,
                            y: 70,
                            floating: true,
                            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
                            borderWidth: 1
                        },
                        plotOptions: {
                            scatter: {
                                marker: {
                                    radius: 5,
                                    states: {
                                        hover: {
                                            enabled: true,
                                            lineColor: 'rgb(100,100,100)'
                                        }
                                    }
                                },
                                states: {
                                    hover: {
                                        marker: {
                                            enabled: false
                                        }
                                    }
                                },
                                tooltip: {
                                    headerFormat: '<b>{series.name}</b><br>',
                                    pointFormat: '{point.x} cm, {point.y} cm'
                                }
                            }
                        },
                        series: series
                    });

                }
            });
        </script>
        <style type="text/css">
            #main {
                width: 80%;
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

        </div>
    </tiles:putAttribute>
</tiles:insertDefinition>