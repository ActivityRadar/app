# AWS S3 bucket setup for image storage

We are currently using AWS S3 buckets as image storage.

For access, we use the `aws_s3_api` flutter package. We use accessKey and secretKey credentials,
so every app user accesses the bucket with the same credentials.

On the AWS side of things there has to be some setup done:

1. Create or log into your AWS account as admin.
2. Create a new bucket.
3. Note down the bucket name and its ARN.
4. Create a new IAM user in the IAM console.
5. Copy the ARN of the newly created IAM user.
6. Under 'Security credentials' create a new Access key.
7. Note down the access Key and the secret key.
8. Go to the console of the bucket owner and from there to the new bucket.
9. Got to 'Permissions' and edit the bucket policy. Now, the noted down values will be needed.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "statement1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "ARN_OF_THE_IAM_USER"
            },
            "Action": [
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ],
            "Resource": "ARN_OF_THE_BUCKET"
        },
        {
            "Sid": "statement2",
            "Effect": "Allow",
            "Principal": {
                "AWS": "ARN_OF_THE_IAM_USER"
            },
            "Action": "s3:GetObject",
            "Resource": "ARN_OF_THE_BUCKET/*"
        },
        {
            "Sid": "statement3",
            "Effect": "Allow",
            "Principal": {
                "AWS": "ARN_OF_THE_IAM_USER"
            },
            "Action": "s3:PutObject",
            "Resource": "ARN_OF_THE_BUCKET/*"
        }
    ]
}
```

These three statements will grant access to the IAM user for uploading and downloading
objects.
Of course, you can extend these rules, but they should be the minimum to be able to make
API calls.

If you should have problems with the above steps, you should take a look at the official
AWS documentation, where all the actions are covered.

## Add credentials to /lib/constants/secrets.dart

The credentials must be added to the secrets file of the project which is excluded from
git versioning. You should do this by replacing the respective values for

- `awsAccessKey`
- `awsSecretKey`
- `awsBucketName`

with your specific values.
