function [uf] = uf_function(lambda, s, u0, t)
    uf = ( s * exp( 2*s*t*lambda ) ) / ( exp( 2*s*t*lambda ) -1 + (s/u0));
end