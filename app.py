import wget
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("pyspark-notebook").master("spark://spark-master:7077").config("spark.executor.memory", "512m").getOrCreate()


url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
wget.download(url)


data = spark.read.csv("iris.data")

data.show(n=5)
