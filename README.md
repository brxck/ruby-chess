# chess

## Assignment

- Build a command line Chess game where two players can play against each other.
- The game should be properly constrained – it should prevent players from making illegal moves and declare check or check mate in the correct situations.
- Make it so you can save the board at any time (remember how to serialize?)
- Write tests for the important parts. You don’t need to TDD it (unless you want to), but be sure to use RSpec tests for anything that you find yourself typing into the command line repeatedly.
- Do your best to keep your classes modular and clean and your methods doing only one thing each. This is the largest program that you’ve written, so you’ll definitely start to see the benefits of good organization (and testing) when you start running into bugs.
- Have fun! Check out the unicode characters for a little spice for your gameboard.
- (Optional extension) Build a very simple AI computer player (perhaps who does a random legal move)

## Planning

This project actually shouldn't be too difficult since the pieces don't have any interaction outside of collision. The hardest work to be done: constrained moving of pieces, check & checkmate endgame, save/load functions.