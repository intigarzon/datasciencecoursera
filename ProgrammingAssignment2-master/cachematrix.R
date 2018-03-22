## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  
  makeCacheMatrix <- function(x = matrix()) { ## define argument with default "matrix"
    +    inv <- NULL                             ## initialise inv as NULL; will hold value of matrix inverse 
    +    set <- function(z) {                    ## define function SET to assign new 
      +        x <<- z                             ## value of matrix in parent environment
      +        inv <<- NULL                        ## if there is a new matrix, reset inv to NULL
      +    }
    +    get <- function() x             ## define the get function - returns value of the matrix argument
    +    
      +    setinverse <- function(inverse) inv <<- inverse  ## assigns value for inv parent environment
      +    getinverse <- function() inv                     ## gets value of inv whenever is called
      +    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)  ## referring to functions with 
      +                                                                                  ## $ operator
  }
}



## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}
