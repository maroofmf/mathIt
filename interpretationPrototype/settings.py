import logging
logger = logging.getLogger('root')
FORMAT = "[FileName: %(filename)s, LineNo:%(lineno)s, FunctionName:%(funcName)s()] Message: %(message)s"
logging.basicConfig(format=FORMAT)
logger.setLevel(logging.DEBUG)


# Use this:
#
# setting.logger.debug('your message')

