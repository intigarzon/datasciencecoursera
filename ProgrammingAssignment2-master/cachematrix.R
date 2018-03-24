
## This branch creates a fork from the week 3 R coding assingment.



## This function creates an object (matrix) that can catch its inverse

makeCacheMatrix <- function(x = matrix()) {
  
  makeCacheMatrix <- function(x = matrix()) { ## define argument with default "matrix"
        inv <- NULL                             ## initialise inv as NULL; will hold value of matrix inverse 
        set <- function(z) {                    ## define function SET to assign new 
              x <<- z                             ## value of matrix in parent environment
              inv <<- NULL                        ## if there is a new matrix, reset inv to NULL
          }
       get <- function() x             ## define the get function - returns value of the matrix argument
        
          setinverse <- function(inverse) inv <<- inverse  ## assigns value for inv parent environment
          getinverse <- function() inv                     ## gets value of inv whenever is called
          list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)  ## referring to functions with 
                                                                                        ## $ operator
  }
}



## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), then the
## cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  m <- x$getmean()
  if(!is.null(m)) {       ## This statement verify whether the inverse has been calculated, if so gets cached data
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}
