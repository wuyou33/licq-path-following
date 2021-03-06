function [prob] = hackl1(p)
%HACKL1 Summary of this function goes here
% 
% A case example from book Guddat et. al
% Ex. 3.4.1 page 86
% [OUTPUTARGS] = HACKL1(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% $Author: suwartad $	$Date: 2015/10/14 19:16:54 $	$Revision: 0.1 $
% Copyright: Process Control Group - NTNU Trondheim 2015

prob = struct('neq',{0},'niq',{0},'cin',{0},'ceq',{0},'dp_in',{0},'dp_eq',{0},'hess',{0},'lxp',{0},'x',0,'name',0);
prob.neq  = 0;            % number of equality constraint
prob.niq  = 2;            % number of inequality constraint
prob.name = 'Hackl1';
prob.x    = zeros(2,1);

prob.cin   = (@(x,p)(constraint(x,p)));  % inequality constraint and prob.ceq for equality constraint
prob.ceq   = (@(x,p)(cons_equal(x,p)));
prob.dp_in = (@(x,p)(deriv_param_in(x,p)));
prob.dp_eq = (@(x,p)(deriv_param_eq(x,p)));
prob.hess  = (@(x,y,p)(hessian(x,y,p)));
prob.lxp   = (@(x,y,p)(lag_der_xp(x,y,p)));
prob.obj   = (@(x,p)(objective(x,p)));

end

function [f,g] = objective(x,p)
    f = x(1)^2 + (4*p-2)*x(2) + 0.5*x(2)^2;
    g = zeros(2,1);
    g(1) = 2*x(1);
    g(2) = (4*p-2) + x(2);
end

function [c,J] = constraint(x,p)
    c      = [x(1)^2 + x(2)^2 - 1 ; x(1) - x(2) - p - 0.25];
    J      = zeros(2,2);
    J(1,1) = 2*x(1);
    J(1,2) = 2*x(2);
    J(2,1) = 1;
    J(2,2) = -1;
end

function [Jeq] = cons_equal(x,p)
    Jeq = [];
end

function [cp] = deriv_param_in(x,p)
    cp      = zeros(2,1);
    cp(2,1) = -1;
end

function [cp] = deriv_param_eq(x,p)
    cp = [];
end

function [H] = hessian(x,y,p)
    H      = zeros(2,2);
    H(1,1) = 2 + 2*y(1);
    H(2,2) = 1 + 2*y(1);
end

function [Lxp] = lag_der_xp(x,y,p)
    Lxp      = zeros(2,1);
    Lxp(2,1) = 4;
end
