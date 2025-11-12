
# Step 1: Unload conflicting packages
if ("package:TMB" %in% search()) detach("package:TMB", unload=TRUE)
if ("package:Matrix" %in% search()) detach("package:Matrix", unload=TRUE)

# Step 2: Install correct versions (optional)
# install.packages("Matrix")  # Uncomment if needed
# install.packages("TMB")     # Uncomment if needed

# Step 3: Load Matrix first, then TMB
library(Matrix)  # Load Matrix before TMB
library(TMB)

# Step 4: Resolve function conflicts (if needed)
if (requireNamespace("conflicted", quietly = TRUE)) {
  library(conflicted)
  conflicted::conflict_prefer("forceSymmetric", "Matrix")
}

# Step 5: Load glmmTMB after resolving dependencies
# install.packages("glmmTMB")
library(glmmTMB)

# Step 6: Check if everything is working
sessionInfo()  # Check loaded packages and versions

# Load required package
library(glmmTMB)

# Simulated data
set.seed(123)  # For reproducibility
y <- rpois(10, 1)
x <- rgamma(10, 2, 4)
x1 <- rbeta(10, 1, 1)
group <- factor(rep(1:2, each = 5))  # Create a grouping variable

# Create a proper data frame
data <- data.frame(y = y, x = x, x1 = x1, group = group)

# Fit the glmmTMB model with a random intercept
model <- glmmTMB(y ~ x + x1 + (1 | group),  # Random intercept for 'group'
                 data = data, 
                 family = nbinom2(link = "log"),  
                 ziformula = ~ .)  

# Print model summary
summary(model)
