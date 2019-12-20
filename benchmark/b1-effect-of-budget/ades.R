# ---
# ALGORITHM DESIGN
# ---

# Specify the algorithms to be run on the tasks
# NOTE: all algorithms should return the same results

# Folder with algo scripts
alg_folder = "algorithms"

# Source all algorithms 
sapply(list.files(alg_folder, full.names = TRUE), source)

ALGORITHMS = list(
    mbo = mbofun
)

ades = lapply(ALGORITHMS, function(x) x$ades)


