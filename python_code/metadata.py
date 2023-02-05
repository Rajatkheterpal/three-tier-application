import requests
import json

def get_metadata(key):
    # URL to retrieve metadata from Azure instance
    url = "http://169.254.169.254/metadata/instance?api-version=2017-12-01"
    # Make a GET request to the URL
    response = requests.get(url, headers={"Metadata": "true"})
    # Parse the response as JSON
    metadata = json.loads(response.text)
    # Return the desired key
    return metadata.get(key, None)

# Get the desired key from the user
data_key = input("Enter the data key to retrieve: ")
# Call the get_metadata function with the desired key
result = get_metadata(data_key)
# Print the result in JSON format
print(json.dumps(result, indent=4))