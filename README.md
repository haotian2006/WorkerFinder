This finds how many workers a client has, this could be modified for server use in the future.
FYI as of 2025 server has a max of 2 workers, and the client has 3. 
This sometimes becomes inaccurate, especially when the game lags when the finder was running, which would result in 0 workers found but if that happens it will fall back to DEFAULT_WORKERS, which is 3. This could be solved by running the calculations again but that would need modfications to the code.
