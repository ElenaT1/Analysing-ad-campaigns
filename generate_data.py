import pandas as pd
from faker import Faker
import uuid
import random

# Initialize Faker 
fake = Faker()

# Generate dummy data
def generate_data(n):
    data = []
    for _ in range(n):
        variation = random.choice(['A', 'B']) 
        if variation == 'A':
            profit = 0 if random.random() < 0.6 else fake.pyfloat(left_digits=3, right_digits=2, positive=True)
        else:
            profit = 0 if random.random() < 0.6 else fake.pyfloat(left_digits=3, right_digits=2, positive=True) * 0.8
        data.append({
            "id": str(uuid.uuid4()),
            "datetime": fake.date_between(start_date='-30d', end_date='today'),
            "variation": variation,
            "total_spend": fake.pyfloat(left_digits=4, right_digits=2, positive=True),
            "geo": fake.country_code(),
            "impressions": fake.pyint(min_value=1000, max_value=100000),
            "profit": profit,
            "clicks": fake.pyint(min_value=100, max_value=10000)
        })
    return pd.DataFrame(data)


# Main routine
if __name__ == "__main__":
    print("Generating data...")
    df = generate_data(10000)
    df.to_csv('table-interview.csv') 
    print("Done!")
    