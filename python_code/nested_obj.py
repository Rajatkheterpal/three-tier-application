def get_value_from_nested_object(obj, key):
    keys = key.split('/')
    for k in keys:
        if k in obj:
            obj = obj[k]
        else:
            return None
    return obj

object = {"a":{"b":{"c":"d"}}}
key = "a/b/c"
result = get_value_from_nested_object(object, key)
print(result) # Output: "d"

object = {"x":{"y":{"z":"a"}}}
key = "x/y/z"
result = get_value_from_nested_object(object, key)
print(result) # Output: "a"