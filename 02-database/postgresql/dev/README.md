

## 📌 What this resource does

* Creates a **custom PostgreSQL parameter group** (`aws_db_parameter_group`) for an **RDS PostgreSQL 15** instance.
* Overrides default PostgreSQL runtime parameters with values tuned for:

  * **Session safety** (timeouts, connection limits)
  * **Logging & observability**
  * **Performance troubleshooting**

> ⚠️ Since most parameters are set with `apply_method = "pending-reboot"`, they only take effect after **restarting the RDS instance**.

---

## 🔎 Parameter explanations

### 🔹 Basic resource info

```hcl
name        = "logistics-custom-postgres-params"
family      = "postgres15"
description = "Custom PostgreSQL parameters for Logistics"
```

* **family**: must match your engine version family (`postgres15` for PostgreSQL 15).
* **name**: unique identifier for the parameter group.
* **description**: free text for clarity.

---

### 🛡️ Session & transaction safety

```hcl
parameter {
  name  = "idle_in_transaction_session_timeout"
  value = "600000"
  apply_method = "pending-reboot"
}
```

* Disconnects a session if it leaves a transaction idle for too long (600,000 ms = 10 min).
* Prevents “idle in transaction” sessions from holding locks forever.

```hcl
parameter {
  name  = "statement_timeout"
  value = "600000"
  apply_method = "pending-reboot"
}
```

* Cancels queries that run longer than 10 minutes.
* Protects against badly written or runaway queries.

```hcl
parameter {
  name  = "max_connections"
  value = "300"
  apply_method = "pending-reboot"
}
```

* Sets maximum concurrent client connections.
* Default is \~100; increased to 300 to handle more traffic.
* Be mindful: higher connections → more memory usage.

---

### 📝 Query & transaction logging

```hcl
parameter {
  name  = "log_statement"
  value = "all"
  apply_method = "pending-reboot"
}
```

* Logs every SQL statement (`all`).
* Useful for debugging but can generate **huge logs**.
* Alternatives:

  * `ddl` → logs only schema changes
  * `mod` → logs INSERT/UPDATE/DELETE but not SELECT

```hcl
parameter {
  name  = "log_min_duration_statement"
  value = "2000"
  apply_method = "pending-reboot"
}
```

* Logs queries taking **more than 2000 ms (2s)**.
* Helps find slow queries without overwhelming logs.

---

### 👤 Connection tracking

```hcl
parameter {
  name  = "log_connections"
  value = "1"
  apply_method = "pending-reboot"
}
parameter {
  name  = "log_disconnections"
  value = "1"
  apply_method = "pending-reboot"
}
```

* Logs when users **connect** and **disconnect**.
* Helps audit activity and spot suspicious login patterns.

---

### ⚙️ Maintenance & background tasks

```hcl
parameter {
  name  = "log_checkpoints"
  value = "1"
  apply_method = "pending-reboot"
}
```

* Logs checkpoint activity (write buffers to disk).
* Helps track when PostgreSQL checkpoints occur (important for performance tuning).

```hcl
parameter {
  name  = "log_autovacuum_min_duration"
  value = "0"
  apply_method = "pending-reboot"
}
```

* Logs **all autovacuum operations** (since `0` = log every run).
* Useful for diagnosing table bloat & vacuum issues.

```hcl
parameter {
  name  = "log_lock_waits"
  value = "1"
  apply_method = "pending-reboot"
}
```

* Logs when a query waits too long for a lock.
* Helps identify blocking queries causing deadlocks or latency.

---

### 🖊️ Log formatting

```hcl
parameter {
  name  = "log_line_prefix"
  value = "%t:%r:%u@%d:[%p]:"
  apply_method = "pending-reboot"
}
```

* Defines the **prefix format** for each log line.
* Breakdown:

  * `%t` → timestamp
  * `%r` → remote host/port
  * `%u` → user name
  * `%d` → database name
  * `%p` → process ID
* Example log entry:

  ```
  2025-09-19 11:30:12:192.168.1.10(5432):appuser@appdb:[12345]: SELECT * FROM orders;
  ```

---

## ✅ Why these parameters matter

* **Safety**: prevents runaway queries and idle locks.
* **Scalability**: increases max connections for app load.
* **Observability**: detailed logs help diagnose performance & lock issues.
* **Auditing**: logs connections, disconnections, and user actions.

---
