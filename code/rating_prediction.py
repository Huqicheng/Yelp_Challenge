from dao import *

class Baseline_Predictor:
    def __init__(self):
        self.global_mean = float(get_global_mean())

    def cal_rating(self,user_id,business_id):
        user_mean = float(get_user_mean(user_id))
        business_mean = float(get_business_mean(business_id))
        rating = 3*self.global_mean-user_mean-business_mean
        if rating>5:
            rating = 5
        elif rating<0:
            rating = 0
        return rating




if __name__ == '__main__':
    predictor = Baseline_Predictor()
    user_id = 'QJI9OSEn6ujRCtrX06vs1w'
    businesses = get_business_rated(user_id)
    for row in businesses:
        business_id = row[0]
        stars = row[1]
        print stars,predictor.cal_rating(user_id,business_id)






