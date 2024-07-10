- This project (full terrafrom) creates a cloud storage subscription to a pub/sub topic.

- The target bucket has a class storage ```var.storage_class``` 
   - DEV/INT: "STANDARD"
   - PROD : "ARCHIVE"

- The target bucket has a life cycle rule: 
   - condition: age = ```var.lifecycle_days```
      - DEV/INT: 1
      - PROD : 395
   - action: type = delete

- The target bucket has a retention policy ```var.retention_lock``` with a retention period (in seconds) of ```var.retention_period```.
   - lock
      - DEV/INT: false
      - PROD: true
   - period 
      - DEV/INT: 86400
      - PROD: 34128000

> Caution: Locking a retention policy is an irreversible action. Once locked, you must delete the entire bucket in order to "remove" the bucket's retention policy. However, before you can delete the bucket, you must be able to delete all the objects in the bucket, which itself is only possible if all the objects have reached the retention period set by the retention policy.