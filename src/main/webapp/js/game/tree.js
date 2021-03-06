function collapse(d) {
    if (d.children) {
        if (d.leaf) {
            d._children = d.children;
            d._children.forEach(collapse);
            d.children = null;
        } else {
            d._children = null;
            d.children.forEach(collapse);
        }
    }
}
function update(source) {
    //node list
    var nodes = tree.nodes(rootData).reverse(),
        links = tree.links(nodes);
    nodes.forEach(function (d) {
        d.y = d.depth * 180;
    });
    var node = svg.selectAll("g.node")
        .data(nodes, function (d) {
            return d.id || (d.id = ++i);
        });

    //node enter in origin
    var nodeEnter = node.enter().append("g")
        .attr("class", "node")
        .attr("transform", function (d) {
            return "translate(" + source.y0 + "," + source.x0 + ")";
        })
        .on("click", click);

    nodeEnter.append("circle")
        .attr("r", 1e-6)
        .style("fill", function (d) {
            return d._children ? "lightsteelblue" : "#fff";
        });

    nodeEnter.append("text")
        .attr("x", function (d) {
            return d.children || d._children ? -10 : 10;
        })
        .attr("dy", ".35em")
        .attr("text-anchor", function (d) {
            return d.children || d._children ? "end" : "start";
        })
        .text(function (d) {
            return d.name;
        })
        .style("fill-opacity", 1e-6);

    //node update for transtate nodes to their new position
    var nodeUpdate = node.transition()
        .duration(duration)
        .attr("transform", function (d) {
            return "translate(" + d.y + "," + d.x + ")";
        });

    nodeUpdate.select("circle")
        .attr("r", 4.5)
        .style("fill", function (d) {
            return d._children ? "lightsteelblue" : "#fff";
        });

    nodeUpdate.select("text")
        .style("fill-opacity", 1);

    // Transition exiting nodes to the parent's new position.
    var nodeExit = node.exit().transition()
        .duration(duration)
        .attr("transform", function (d) {
            return "translate(" + source.y + "," + source.x + ")";
        })
        .remove();

    nodeExit.select("circle")
        .attr("r", 1e-6);

    nodeExit.select("text")
        .style("fill-opacity", 1e-6);

    // Update the links…
    var link = svg.selectAll("path.link")
        .data(links, function (d) {
            return d.target.id;
        });

    // Enter any new links at the parent's previous position.
    link.enter().insert("path", "g")
        .attr("class", "link")
        .attr("d", function (d) {
            var o = {x: source.x0, y: source.y0};
            return diagonal({source: o, target: o});
        });

    // Transition links to their new position.
    link.transition()
        .duration(duration)
        .attr("d", diagonal);

    // Transition exiting nodes to the parent's new position.
    link.exit().transition()
        .duration(duration)
        .attr("d", function (d) {
            var o = {x: source.x, y: source.y};
            return diagonal({source: o, target: o});
        })
        .remove();

    // Stash the old positions for transition.
    nodes.forEach(function (d) {
        d.x0 = d.x;
        d.y0 = d.y;
    });
}
// Toggle children on click.
function click(d) {
    if (d.children) {
        d._children = d.children;
        d.children = null;
    } else {
        d.children = d._children;
        d._children = null;
    }
    update(d);
}
$(function () {
    var width = window.innerWidth * 0.7 - 2;
    var height = window.innerHeight - 15;
    tree = d3.layout.tree().size([height, width]);
    svg = d3.select("svg").attr("height", height).append("g").attr("transform", "translate(30,0)");
    diagonal = d3.svg.diagonal().projection(function (d) {
        return [d.y, d.x];
    });
    i = 0, duration = 750;
    rootData.name = "西瓜数据决策树";
    rootData.x0 = 350;
    rootData.y0 = 0;
    if (rootData.children) {
        rootData.children.forEach(collapse);
        update(rootData);
    }
    $("#secondIndex").text("二级目录:"+rootData.children.length+"个");
});
