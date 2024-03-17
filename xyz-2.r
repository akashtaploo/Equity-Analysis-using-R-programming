f2 <- function(d, mu, Rf) {
  vec_r <- colMeans(d)
  mtx_V <- cov(d)
  N <- length(vec_r)
  vec_I <- t(t(rep(1, N)))
  mtx_bind <- cbind(vec_r, vec_I)
  mtx_A <- t( mtx_bind) %*% solve(mtx_V) %*%  mtx_bind
  mtx_B <- solve(mtx_V) %*%  mtx_bind
  vec_w <- mtx_B %*% solve(mtx_A) %*% t(cbind(mu, 1))
  sigma <- sqrt(t(vec_w) %*% mtx_V %*% vec_w)
  Sharpe <- (mu - Rf) / sigma
  return(list(vec_w = vec_w, sigma = sigma, Sharpe = Sharpe))
}

