#program initial.

    % Spawn all the cells
    c(0..nrows-1, 0..ncols-1).

    % Adjacency relation between cells
    adj(c(X,Y), c(X+1,Y)) :- c(X,Y), X<nrows-1. 
    adj(c(X,Y), c(X-1,Y)) :- c(X,Y), X>0. 
    adj(c(X,Y), c(X,Y+1)) :- c(X,Y), Y<ncols-1.
    adj(c(X,Y), c(X,Y-1)) :- c(X,Y), Y>0. 

    % Define the starting position of an end as the top left-most one
    p(P,X,Y) :- end(P, c(X,Y)), end(P, c(X',Y')), X<X'.
    p(P,X,Y) :- end(P, c(X,Y)), end(P, c(X',Y')), X=X', Y<Y'.

    % Define the goal position of an end as the the lower right-most one
    g(P,X',Y') :- end(P, c(X,Y)), end(P, c(X',Y')), X<X'.
    g(P,X',Y') :- end(P, c(X,Y)), end(P, c(X',Y')), X=X', Y<Y'.

    % Set the initial state
    h(on(P),(X,Y)) :- p(P,X,Y).

#program always.

    % Mark as filled the current position of each end
    fill(X,Y,P) :- h(on(P),(X,Y)).

    % Generate all the possible actions: movement from the current position of the ends
    % towards the adjacent cells that are not filled and are not obstacles
    action(move(P,X',Y')) :- h(on(P),(X,Y)), not _obs(X',Y'), _adj(c(X,Y),c(X',Y')), not fill(X',Y',_).
    
#program dynamic.

    % Save the previous filled information
    fill(X,Y,P) :- 'fill(X,Y,P).

    % Updathe the position of the end, if it executed a movement
    h(on(P),(X,Y)) :- o(move(P,X,Y)).

    % Inertia: if an end is not moved, it mantains its position
    h(on(P),(X,Y)) :- 'h(on(P),(X,Y)), not o(move(P,_,_)).
    
    % Select possible actions, given the previous state
    {o(A): 'action(A)}.

    % Remove concurrent actions that try to go to the same position
    :- o(move(P,X,Y)), o(move(P',X,Y)), P!=P'.

#program final. 
    % The position of the end must be in the goal position
    :- _g(P,X,Y), not h(on(P),(X,Y)).
    #minimize{1,X,Y: fill(X,Y,_)}.

#show fill/3.
#show dim/2.