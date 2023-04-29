//Currently, a task can execute a single SQL statement, including a cell to a stored procedure.
//In summary, tasks are very handy in Snowflake. they can be combined with Streams, Snowpipes and other tools and techniques to make tasks extremely powerful.

CREATE DATABASE testing_task;

USE testing_task;

CREATE OR REPLACE TABLE demo_video
(
id INT AUTOINCREMENT START = 1 INCREMENT =1,
name VARCHAR(40) DEFAULT 'DEMOVIDEOCREATED',
date TIMESTAMP
);

SELECT * FROM demo_video;


//CREATING A TASK
CREATE OR REPLACE TASK insertdata_1min_interval
WAREHOUSE = COMPUTE_WH
SCHEDULE = '1 MINUTE'
AS INSERT INTO demo_video(DATE) VALUES(CURRENT_TIMESTAMP);

/* The above scheduling is done using a CRON job
Its in the format = ' 0 5 * * *' ( MIN HR DAY_OF_MONTH MONTH_OF_YEAR DAY_OF_THE_WEEK)
In this example, the SCHEDULE parameter is set to ' 0 5 * * *', which corresponds to running the task every day at 5AM UTC.
In Snowflake, the CRON tab functionality is used to schedule tasks that need to be executed at a specific time interval.
Snowflake provides a built in scheduler that uses CRON syntax for scheduling tasks.
The snowflake scheduler allows users to schedule tasks to run at specific intervals, such as hourly, daily, weekly or monthly.
The syntax for scheduling tasks using CRON tabb in Snowflake is similar to that used in Unix like OS */


SHOW TASKS;
// By default, a created task will be in suspended state

// To start a task
ALTER TASK insertdata_1min_interval RESUME;

// To suspend a task
ALTER TASK insertdata_1min_interval SUSPEND;

SELECT * FROM demo_video;

