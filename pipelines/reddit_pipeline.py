import pandas as pd
from datetime import timedelta
from utils.constants import CLIENT_ID, SECRET, OUTPUT_PATH
from etls.reddit_etl import connect_reddit, extract_posts, transform_data, load_data_to_csv


def reddit_pipeline(subreddit: str, time_filter="day", limit=None, **kwargs):
    # Connecting to Reddit instance
    execution_date = kwargs.get('execution_date') - timedelta(days=5)
    file_postfix = execution_date.strftime('%Y%m%d')
    file_name = f"reddit_{file_postfix}"
    instance = connect_reddit(CLIENT_ID, SECRET, 'Airscholar Agent')

    # Extraction
    posts = extract_posts(instance, subreddit, time_filter, limit)
    post_df = pd.DataFrame(posts)

    # Transformation
    post_df = transform_data(post_df)

    # Loading to CSV
    file_path = f'{OUTPUT_PATH}/{file_name}.csv'
    load_data_to_csv(post_df, file_path)

    return file_path
