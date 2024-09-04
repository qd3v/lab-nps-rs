require 'json'


INT32_BOUNDARY       = 2 ** 31
INT32_UPPER_BOUNDARY = INT32_BOUNDARY - 1
INT32_LOWER_BOUNDARY = -INT32_BOUNDARY


def int32?(num)
  num.is_a?(Integer) && num.between?(INT32_LOWER_BOUNDARY, INT32_UPPER_BOUNDARY)
end

def valid?(array)
  array.is_a?(Array) && array.all?(&method(:int32?))
end

#
# ENTRY POINT
#

# Docs for handlers: https://docs.aws.amazon.com/lambda/latest/dg/ruby-handler.html
# @param [Object] event parsed JSON's body
# @param [LambdaContext] context https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html
def lambda_handler(event:, context:)
  unless valid?(event)
    return {
      statusCode: 400,
      body:       'Invalid input. Expected an array of int32 numbers'
    }
  end

  {statusCode: 200, body: event.sum}
end
