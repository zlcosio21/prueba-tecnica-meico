# DECISIONS.md

## How did you structure your solution?

- I separated the provider logic into independent Ruby classes (one per provider).
- There is a ProviderRouter that maps the `payment_type` to the correct provider class.
- The controller only receives the request, finds the provider, and delegates the processing.
- Each provider class handles its own logic and returns a normalized hash.
- The service object orchestrates the process and always returns a standardized response for the API.

## What decisions did you make to make adding new providers easy?

- All provider logic is isolated, so to add a new provider you just create a new class and add it to the ProviderRouter map.
- The output is always mapped to the same JSON format, regardless of the provider's internal API or response.
- No changes are needed in the controller or service when adding a new provider, just update the router and add the new class.

---

## (Spanish, plain style)

- I thought about how to make it so that, even if each provider handles things differently, I could map everything so that when creating a payment, nothing changes and the response is always the same.
- The endpoint receives the info, finds the provider, maps the provider logic to the output format needed, and that's it.
- For the second question: when adding another provider, you just add the class and map it in the router, and the endpoint will return the formatted JSON as required, no extra changes needed.
