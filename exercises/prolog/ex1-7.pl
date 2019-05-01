/* vim: set syntax=prolog */
:- [parent_relation].

% (a) No, parent(pam, bob) is a fact.
% (b) No, both parent and female are facts that must be true (no recursion).
% (c) No, the fact parent(pam, bob) is tried first, and then the fact
%     parent(bob, ann), due to the order of declarations. No backtracking
%     needed.
% (d) Yes, first parent(bob, ann) is found, and Prolog looks for a
%     parent(ann, jim) which doesn't exist. It'll then backtrack and try the
%     next fact, parent(bob, pat), which succeeds as there exists a fact
%     parent(pat, jim).
