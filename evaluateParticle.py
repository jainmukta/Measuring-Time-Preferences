import pandas as pd
import numpy as np
import argparse

# Read the CSV file into a pandas DataFrame
def loadData(path, expRcolName):
    oriCols = pd.read_csv(path, nrows=0).columns.tolist()
    assert(expRcolName in oriCols)

    cols2drop = [col for col in oriCols if (col.startswith('exp'))] + ['hh_id', 'wave', 'ps_Y_fin_hoh', 'weighted_assets', 'ps_total_hh_income']
    cols2drop.remove(expRcolName)
    if expRcolName.endswith('totY'):
        cols2drop.remove('ps_total_hh_income')
        yCol = 'ps_total_hh_income'
    elif expRcolName.endswith('finY'):
        cols2drop.remove('ps_Y_fin_hoh')
        yCol = 'ps_Y_fin_hoh'
    elif expRcolName.endswith('assets'):
        cols2drop.remove('weighted_assets')
        yCol = 'weighted_assets'
    else:
        raise ValueError('Invalid Argument experimentRcolName' + expRcolName)
    df = pd.read_csv(path)
    if cols2drop is not None:
        df.drop(columns=cols2drop, inplace=True)
    df = df.dropna().reset_index(drop=True)
    return df, yCol

# Define the evaluation function - returns float
def eval_func(params: np.ndarray, completeDF: pd.DataFrame, experimentRcolName: str, yCol: str) -> float:
    wave_cols = ['wave' + str(i) for i in range(1, 17)]
    eval_eq = (
        ((completeDF[experimentRcolName]
          / (1
             + (params[0]*(completeDF[yCol]**params[1])
                * completeDF['ps_fin_head_age']**params[4]
                * ((params[6] + params[7]*completeDF['caste_group_02'] + params[8]*completeDF['caste_group_03'])**params[5])
                * ((params[10] + params[11]*completeDF['edu_group_02'] + params[12]*completeDF['edu_group_03'] + params[13]*completeDF['edu_group_04'])**params[9])
               )
            )
         )**params[3])
        * (completeDF['wave_family_size_growth']**(1 - params[2]*params[3]))
        * (sum([completeDF[col]*params[i+15] for i, col in enumerate(wave_cols)])**params[14])
    )
    return eval_eq

def find_invalid_row(params: np.ndarray, completeDF: pd.DataFrame, experimentRcolName: str, yCol: str):
    for i, row in completeDF.iterrows():
        eval_eq = eval_func(params, pd.DataFrame(row).transpose(), experimentRcolName, yCol)
        if np.isnan(eval_eq).any() or np.isinf(eval_eq).any():
            return i, row
    return None, None

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--CSVfilePath', type=str, default="../datasets/data/PSO.csv", help='path to data directory')
    parser.add_argument('--experimentRcolName', type=str, default="exp_fd365_totY", help='column name to specify interest rate to be used for experiment')
    args = parser.parse_args()

    assert(args.experimentRcolName.startswith('exp'))

    CompleteDF, yCol = loadData(args.CSVfilePath, args.experimentRcolName)
    
    params = np.array([ 1.39072346,  -0.30404244,   1.33846081,   0.08694385,   0.55549851,
                       -1.47127854,   7.57208338,   2.90968512,   4.24137338,   3.74451256,
                       16.54565665,   2.60610436,  25.48641933,   0.97120359,   0.29144704,
                       -1.53031263,  13.11207083, -16.67158468,  12.80213862,  16.28528537,
                       14.42225583,  -6.79414633,  15.31037066,  -0.70762203,  -7.25264738,
                       12.83891111, -18.59509639,  13.16929916, -10.58263907,  -0.15510294,
                        9.31226345])
    params = np.zeros(31)
    params = np.array([ 1.01586139e-02, -3.87526871e-02,  6.55334587e-01,  8.17353791e-01,
                       -8.10225673e-04, -2.42391709e-01, -9.87440170e-01, -4.86683817e+00,
                        2.59617416e+00,  7.00179660e-01, -3.67133672e+00,  4.79915268e+00,
                        3.47376573e+00,  2.49781063e+00,  2.12198621e-03, -6.07834355e-01,
                        1.39485897e+00, -5.44427334e+00, -2.75899167e+00, -8.79193829e-01,
                       -2.91914114e+00, -5.23164557e+00, -3.67364151e-01, -7.74834978e-01,
                        6.78773229e-01, -2.04459576e+00, -3.53013189e+00, -3.56531255e-01,
                       -2.29045180e-01, -8.44860177e-01, -4.20996263e+00
                       ])
    
    CompleteDF['eval_fn'] = eval_func(params, CompleteDF, args.experimentRcolName, yCol)

    print(CompleteDF[['wave_nd_cons_growth', 'eval_fn']].describe())

    # Usage:
    index, invalid_row = find_invalid_row(params, CompleteDF, args.experimentRcolName, yCol)
    if invalid_row is not None:
        print(f"Found an invalid row at index {index}:")
        print(invalid_row)
    else:
        print("No invalid rows found.")