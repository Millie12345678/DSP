function distorted_output= soft_clip(sig, drive, cap)

%hyperbolic tangent soft cliping (produced both odd and even harmonics)

distorted_output = cap.*tanh(drive.*sig);

end

