# Infinite scroll
With this app you can sweep through all the Swift repositories on GitHub, ordered by popularity, i.e. the one with the most stars will be sitting at the top. Instead of displaying the API responses with the standard [pagination](https://developer.github.com/v3/#pagination), the content of the list changes dynamically, thus creating the perception of endless scrolling.
The challenge is to make this scrolling experience as smooth as possible, considering the [cap on GitHub's Search API](https://developer.github.com/v3/search/#rate-limit) and other limitations.

### Before you run the app
Make sure you've replaced the placeholder with your access token [here](https://github.com/bvadnai/InfiniteScrollDemo/blob/5fe914923b6fe28e5dc0607d981130dcaa0e9d3b/InfiniteScrollDemo/Services/Networking/Implementation/GitHubSearch.swift#L13). I made a syntax error deliberately so you don't have to search for it.