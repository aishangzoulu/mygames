package com.raymond.game.util.kmeans;
import com.google.common.collect.Lists;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Raymond on 2017/5/8.
 */
/* 
 * KMeans.java ; Cluster.java ; Point.java
 *
 * Solution implemented by DataOnFocus
 * www.dataonfocus.com
 * 2015
 *
*/
public class KMeans {

    //Number of Clusters. This metric should be related to the number of points
    private int NUM_CLUSTERS = 3;
    //Number of Points
    private int NUM_POINTS = 15;
    //Min and Max X and Y
    private static final int MIN_COORDINATE = 0;
    private static final int MAX_COORDINATE = 10;

    private List<Point> points;
    private List<Cluster> clusters;

    private List<List<Point>> pointsList;
    private List<List<Cluster>> clustersList;

    public List<Point> getPoints() {
        return points;
    }

    public void setPoints(List<Point> points) {
        this.points = points;
    }

    public List<Cluster> getClusters() {
        return clusters;
    }

    public void setClusters(List<Cluster> clusters) {
        this.clusters = clusters;
    }

    public List<List<Point>> getPointsList() {
        return pointsList;
    }

    public void setPointsList(List<List<Point>> pointsList) {
        this.pointsList = pointsList;
    }

    public List<List<Cluster>> getClustersList() {
        return clustersList;
    }

    public void setClustersList(List<List<Cluster>> clustersList) {
        this.clustersList = clustersList;
    }

    public KMeans() {
        this.points = new ArrayList();
        this.clusters = new ArrayList();
        this.pointsList=new ArrayList<>();
        this.clustersList=new ArrayList<>();
    }

    public static void main(String[] args) {
        KMeans kmeans = new KMeans();
        kmeans.init();
        kmeans.calculate();
    }

    //Initializes the process
    public void init() {
        //Create Points
        points = Point.createRandomPoints(MIN_COORDINATE,MAX_COORDINATE,NUM_POINTS);

        //Create Clusters
        //Set Random Centroids
        for (int i = 0; i < NUM_CLUSTERS; i++) {
            Cluster cluster = new Cluster(i);
            Point centroid = Point.createRandomPoint(MIN_COORDINATE,MAX_COORDINATE);
            cluster.setCentroid(centroid);
            clusters.add(cluster);
        }

        //Print Initial state
        plotClusters();

        pointsList.add(clonePointList(points));
        clustersList.add(Lists.newArrayList(clusters));
    }

    private void plotClusters() {
        for (int i = 0; i < NUM_CLUSTERS; i++) {
            Cluster c = clusters.get(i);
            c.plotCluster();
        }
    }

    //The process to calculate the K Means, with iterating method.
    public void calculate() {
        boolean finish = false;
        int iteration = 0;

        // Add in new data, one at a time, recalculating centroids with each new one.
        while(!finish) {
            //Clear cluster state
            clearClusters();

            List<Point> lastCentroids = getCentroids();

            //Assign points to the closer cluster
            assignCluster();

            //Calculate new centroids.
            calculateCentroids();

            iteration++;

            List<Point> currentCentroids = getCentroids();

            //Calculates total distance between new and old Centroids
            double distance = 0;
            for(int i = 0; i < lastCentroids.size(); i++) {
                distance += Point.distance(lastCentroids.get(i),currentCentroids.get(i));
            }
            System.out.println("#################");
            System.out.println("Iteration: " + iteration);
            System.out.println("Centroid distances: " + distance);
            plotClusters();

            if(distance == 0) {
                finish = true;
            }
            pointsList.add(clonePointList(points));
            clustersList.add(Lists.newArrayList(clusters));
        }
    }

    private void clearClusters() {
        for(Cluster cluster : clusters) {
            cluster.clear();
        }
    }

    private List getCentroids() {
        List centroids = new ArrayList(NUM_CLUSTERS);
        for(Cluster cluster : clusters) {
            Point aux = cluster.getCentroid();
            Point point = new Point(aux.getX(),aux.getY());
            centroids.add(point);
        }
        return centroids;
    }

    private void assignCluster() {
        double max = Double.MAX_VALUE;
        double min = max;
        int cluster = 0;
        double distance = 0.0;

        for(Point point : points) {
            min = max;
            for(int i = 0; i < NUM_CLUSTERS; i++) {
                Cluster c = clusters.get(i);
                distance = Point.distance(point, c.getCentroid());
                if(distance < min){
                    min = distance;
                    cluster = i;
                }
            }
            point.setCluster(cluster);
            clusters.get(cluster).addPoint(point);
        }
    }

    private void calculateCentroids() {
        for(Cluster cluster : clusters) {
            double sumX = 0;
            double sumY = 0;
            List<Point> list = cluster.getPoints();
            int n_points = list.size();

            for(Point point : list) {
                sumX += point.getX();
                sumY += point.getY();
            }

            Point centroid = cluster.getCentroid();
            if(n_points > 0) {
                double newX = sumX / n_points;
                double newY = sumY / n_points;
                centroid.setX(newX);
                centroid.setY(newY);
            }
        }
    }

    public static List<Point> clonePointList(List<Point> list) {
        List<Point> clone = new ArrayList<Point>(list.size());
        for (Point item : list){
            Point point=new Point();
            point.setCluster(item.getCluster());
            point.setX(item.getX());
            point.setY(item.getY());
            clone.add(point);
        }
        return clone;
    }

    public static List<Cluster> cloneClusterList(List<Cluster> list) {
        List<Cluster> clone = new ArrayList<Cluster>(list.size());
        for (Cluster item : list){
            Cluster cluster=new Cluster();
            cluster.setCentroid(item.getCentroid());
            cluster.setPoints(clonePointList(item.getPoints()));
            clone.add(cluster);
        }
        return clone;
    }
}