from db_tool import *


def get_review_by_businessid(id):
    db = open_conn()
    result = executeQuery(db,'select date,avg(stars) from review where business_id=\''+id+'\' group by date order by date asc;')
    close_conn(db)
    return result

def get_global_mean():
    db = open_conn()
    result = executeQuery(db,'select avg(stars) from review;')
    close_conn(db)
    return result[0][0]

def get_user_mean(id):
    db = open_conn()
    result = executeQuery(db,'select average_stars from user where id=\''+id+'\';')
    close_conn(db)
    return result[0][0]

def get_business_mean(id):
    db = open_conn()
    result = executeQuery(db,'select stars from business where id=\''+id+'\';')
    close_conn(db)
    return result[0][0]

def get_rating(user,business):
    db = open_conn()
    result = executeQuery(db,'select stars from review where user_id=\''+user+'\' and business_id=\''+business+'\';')
    close_conn(db)
    return result[0][0]

def get_business_rated(user_id):
    db = open_conn()
    result = executeQuery(db,'select business_id,stars from review where user_id=\''+user_id+'\'')
    close_conn(db)
    return result

def get_business_hours():
    db = open_conn()
    result = executeQuery(db,'select business_id,stars from review where user_id=\''+user_id+'\'')
    close_conn(db)
    return result



'''
    business
    '4JNXUYY8wbaaDmk3BPzlWw', '7360'
    'RESDUcs7fIiihp38-d6_6g', '7005'
    'K7lWdNUhCbcnEvI0NhGewg', '5950'
    'f4x1YBxkLrZg652xt2KR5g', '4774'
    '2weQS-RnoOBhb1KsHKyoSQ', '4018'
    
    user
    'CxDOIDnH8gp9KXzpBHJYXw','3524'
    'bLbSNkLggFnqwNNzzq-Ijw','1947'
    'PKEzKWv_FktMm2mGPjwd0Q','1499'
    'DK57YibC5ShBmqQl97CKog','1401'
    'QJI9OSEn6ujRCtrX06vs1w','1248'



'''
if __name__ == '__main__':
    print get_global_mean()
