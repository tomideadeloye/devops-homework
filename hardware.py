from flask import Flask, request, jsonify
import psycopg2
import time
import random
application = Flask(__name__)


def slow_process_to_calculate_availability(provider, name):
    time.sleep(5)
    return random.choice(['HIGH', 'MEDIUM', 'LOW'])

@application.route('/hardware/')
def hardware():
    try:
        con = psycopg2.connect(user = "postgres", host = "127.0.0.1", port = "5432", password = 'randompass', database = "rescale")
        c = con.cursor()
        # Print database connection properties
        print ( con.get_dsn_parameters(),"\n")
        sql_file = open('database.sql', 'r')
        c.execute(sql_file.read())
        postgreSQL_select_Query = "select * from hardware"
        c.execute(postgreSQL_select_Query)
        hardwares = c.fetchall()
        statuses = [
            {
                'provider': row[1],
                'name': row[2],
                'availability': slow_process_to_calculate_availability(
                    row[1],
                    row[2]
                ),
            }
            for row in hardwares
        ]
        return jsonify(statuses)
    except (Exception, psycopg2.Error) as error :
        print ("Error occured", error)

    finally:
        #closing database con.
            if(con):
                c.close()
                con.close()
                print("Connection is closed")

if __name__ == "__main__":
    application.run(host='0.0.0.0', port=5001)
