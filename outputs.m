function [y] = outputs(flip, levels)
   %nodes stores the values in the tree
   nodes = zeros(2 ^ levels - 1, 1);
   %parents stores the index in nodes that is the parent node of the 
   %node with the same index. i.e. the parent of node(i) = parent(i)
   parents = zeros(2 ^ levels - 1, 1);
   
   %build structure of tree by putting references in parents 
   for j = 1:levels
       oldInt = 2 ^ (j-1);
       newInt = 2 ^ (j) - 1;
       for k = oldInt:newInt
           parents(k) = j - 1;
       end
   end
   
   %seed tree with 1 or -1 w/ equal probability
   seed = rand(1);
   if (seed > 0.5)
      nodes(1) = 1; 
   else
      nodes(1) = -1;
   end
   
   %fill tree with values. value at index j will flip from value of parent
   % with likelihood equilvalent to flip probability.
   for j = 2:size(nodes)
       check = rand(1);
       if (check > flip)
           nodes(j) = nodes(parents(j));
       else
           nodes(j) = nodes(parents(j)) * -1;
       end
   end
   
   y = zeros( (2^(levels-1) -1) - (2^levels - 1), 1 );
   for j = ( 2^(levels-1) ):( 2^levels - 1 )
       y(j - ( 2^(levels-1) - 1 )) = nodes(j);
   end
   % want a row
end