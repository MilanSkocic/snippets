import functools
import logging
from logging import handlers
import sys

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# Create handlers
c_handler = logging.StreamHandler(sys.stdout)
f_handler = handlers.RotatingFileHandler("./log.log", maxBytes=1e6, backupCount=3)
c_handler.setLevel(logging.DEBUG)
f_handler.setLevel(logging.DEBUG)

# Create formatters and add it to handlers
c_format = logging.Formatter('%(name)s - %(levelname)s - %(message)s')
f_format = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
c_handler.setFormatter(c_format)
f_handler.setFormatter(f_format)

# Add handlers to the logger
logger.addHandler(c_handler)
logger.addHandler(f_handler)

logger.info("Starting app.")

def debug(func):
    r"""
    Wrapper for debug
    """
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        logger.debug(f"Entering {func.__name__:s}")
        logger.debug(f"Arguments are: {str(args):s}")
        res = func(*args)
        logger.debug(f"Result is: {str(res):s}")
    return wrapper

@debug
def func(a, b):
    r"""
    Compute a + b.

    Parameters
    ------------
    a: float
        Number
    b: float
        Number
    """
    return a + b


if __name__ == "__main__":

    print(func.__doc__)
    func(1, 2)
    logger.info("Ending app.")