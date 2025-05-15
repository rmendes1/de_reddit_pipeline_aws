import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsgluedq.transforms import EvaluateDataQuality
from pyspark.sql.functions import concat_ws
from awsglue import DynamicFrame

# Recebe os parâmetros via Glue
args = getResolvedOptions(sys.argv, ['JOB_NAME', 'INPUT_PATH', 'OUTPUT_PATH'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

DEFAULT_DATA_QUALITY_RULESET = """
    Rules = [
        ColumnCount > 0
    ]
"""

# Leitura do CSV do S3
df_raw = glueContext.create_dynamic_frame.from_options(
    format_options={"quoteChar": "\"", "withHeader": True, "separator": ","},
    connection_type="s3",
    format="csv",
    connection_options={"paths": [args['INPUT_PATH']], "recurse": True},
    transformation_ctx="read_raw"
)

# Transformações
df = df_raw.toDF()
df_combined = df.withColumn('ESS_updated', concat_ws('-', df['edited'], df['spoiler'], df['stickied']))
df_combined = df_combined.drop('edited', 'spoiler', 'stickied')

# Conversão de volta para DynamicFrame
df_final = DynamicFrame.fromDF(df_combined, glueContext, 'df_final')

# Validação de qualidade dos dados
EvaluateDataQuality().process_rows(
    frame=df_raw,
    ruleset=DEFAULT_DATA_QUALITY_RULESET,
    publishing_options={
        "dataQualityEvaluationContext": "EvaluateDataQuality_node",
        "enableDataQualityResultsPublishing": True
    },
    additional_options={
        "dataQualityResultsPublishing.strategy": "BEST_EFFORT",
        "observations.scope": "ALL"
    }
)

# Escrita no S3
glueContext.write_dynamic_frame.from_options(
    frame=df_final,
    connection_type="s3",
    format="csv",
    connection_options={
        "path": args['OUTPUT_PATH'],
        "compression": "snappy",
        "partitionKeys": []
    },
    transformation_ctx="write_transformed"
)

job.commit()
