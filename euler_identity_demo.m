function euler_identity_demo(freq)
% EULER_IDENTITY_DEMO
% Visualizes Euler's identity and the complex exponential helix.
% Camera path (Conceptual Unfolding):
%   Start:  Unit circle (top-down, look down +t)     -> [az,el] = [0, 90]
%   Middle: Oblique helix (balanced 3D overview)     -> [45, 45]
%   End:    Cosine projection (look along +Im axis)  -> [90, 0]
%
% - Large helix on the left; other plots are fixed in size during rotation
% - Red dots + blue/green vertical guides on Re/Im time plots
% - Orthographic projection for true 2D snapshots at the key views
%
% Example: euler_identity_demo(0.7)

% ======= Parameters =======
if nargin < 1, freq = 0.7; end
omega     = 2*pi*freq;   % angular frequency (rad/s)
sigma     = 0.0;         % growth/decay rate (try ±0.3)
T         = 8;           % total time (s)
Fs        = 200;         % samples/sec
doAnimate = true;

% ======= Data =======
t  = linspace(0, T, T*Fs+1).';
z  = exp((sigma + 1i*omega).*t);
zr = real(z); zi = imag(z);

theta = linspace(0, 2*pi, 361);
unit  = exp(1i*theta);

% ======= Figure + layout (single window) =======
fig = figure('Color','w','Name','Euler & Complex Exponential');
set(fig,'WindowState','maximized');  % Fullscreen

% Global LaTeX interpreters
set(fig,'DefaultTextInterpreter','latex',...
        'DefaultAxesTickLabelInterpreter','latex',...
        'DefaultLegendInterpreter','latex');

tl = tiledlayout(fig, 4, 6, 'TileSpacing','compact');

% ----------------- Helix (big, left) -----------------
ax2 = nexttile(tl, [4 2]); hold(ax2,'on'); grid(ax2,'on');
camproj(ax2,'orthographic');      % true 2D projections at key views
view(ax2, [0 0 1]);               % start top-down (unit circle)
plot3(ax2, zr, zi, t, 'LineWidth',1.5, 'DisplayName','Helix');

% Animated 3D vector (in plane z = t) + cursor
hVec3 = quiver3(ax2, 0, 0, t(1), zr(1), zi(1), 0, ...
    'LineWidth',1.5, 'Color',[0.85 0 0], 'MaxHeadSize',0.4, ...
    'AutoScale','off', 'DisplayName','Current vector in plane $t$');
hCursor = plot3(ax2, zr(1), zi(1), t(1), 'ro', 'MarkerFaceColor','r', ...
    'DisplayName','Current $z(t)$');

xlabel(ax2, '$\Re\{z(t)\}$'); ylabel(ax2, '$\Im\{z(t)\}$'); zlabel(ax2, '$t$');
title(ax2, sprintf('Helix: $e^{(\\sigma+i\\omega)t}$  with  $\\sigma=%.2f$, $\\omega=%.2f$ rad/s', sigma, omega));
daspect(ax2, [1 1 1]); axis(ax2, 'vis3d'); box(ax2,'on');

% ----------------- Complex plane (fixed size) -----------------
ax1 = nexttile(tl, [2 4]); hold(ax1,'on'); axis(ax1,'equal'); grid(ax1,'on');
ax1.PositionConstraint = 'outerposition';   % lock size
plot(ax1, real(unit), imag(unit), 'LineWidth',1.5, 'DisplayName','Unit circle');
plot(ax1, 0, 0, 'k.','MarkerSize',12, 'DisplayName','Origin');

hRot = plot(ax1, cos(theta(1)), sin(theta(1)), 'ro', ...
    'MarkerFaceColor','r', 'DisplayName','$e^{i\theta}$');
hVec = quiver(ax1, 0, 0, cos(theta(1)), sin(theta(1)), 0, ...
    'MaxHeadSize',0.3, 'LineWidth',1.5, 'Color',[0.85 0 0], ...
    'DisplayName','$e^{i\theta}$ vector');

hCos = plot(ax1, [0 cos(theta(1))], [0 0], 'b-', 'LineWidth',1.2, ...
    'DisplayName','$\cos\theta$');
hSin = plot(ax1, [cos(theta(1)) cos(theta(1))], [0 sin(theta(1))], 'g-', 'LineWidth',1.2, ...
    'DisplayName','$\sin\theta$');

xlabel(ax1, '$\Re$'); ylabel(ax1, '$\Im$');
title(ax1, '$e^{i\theta}=\cos\theta+i\sin\theta$');
legend(ax1, 'Location','eastoutside');
xlim(ax1,[-1.2 1.2]); ylim(ax1,[-1.2 1.2]);   % stable ticks

% ----------------- Re{z(t)} (fixed size) -----------------
ax4 = nexttile(tl, [1 4]); hold(ax4,'on'); grid(ax4,'on');
ax4.PositionConstraint = 'outerposition';
plot(ax4, t, zr, 'LineWidth',1.2);
ylabel(ax4, '$\Re\{z(t)\}$');
title(ax4, '$\Re\{z(t)\}=e^{\sigma t}\cos(\omega t)$');

% ----------------- Im{z(t)} (fixed size) -----------------
ax5 = nexttile(tl, [1 4]); hold(ax5,'on'); grid(ax5,'on');
ax5.PositionConstraint = 'outerposition';
plot(ax5, t, zi, 'LineWidth',1.2);
ylabel(ax5, '$\Im\{z(t)\}$'); xlabel(ax5, '$t$');
title(ax5, '$\Im\{z(t)\}=e^{\sigma t}\sin(\omega t)$');

% Dots + vertical guide lines on time plots
hDotRe = plot(ax4, t(1), zr(1), 'ro', 'MarkerFaceColor','r');
hDotIm = plot(ax5, t(1), zi(1), 'ro', 'MarkerFaceColor','r');
hLineRe = plot(ax4, [t(1) t(1)], [0 zr(1)], 'b--', 'LineWidth',1.2);
hLineIm = plot(ax5, [t(1) t(1)], [0 zi(1)], 'g--', 'LineWidth',1.2);
hLineRe.Color = [0 0 1 0.7];
hLineIm.Color = [0 0.6 0 0.7];

% Fix time-plot limits (prevents tick/label-induced resizing)
if sigma == 0
    yMax = 1.1;
else
    A = exp(abs(sigma)*T);
    yMax = 1.1*A;
end
xlim(ax4,[0 T]); ylim(ax4, yMax*[-1 1]);
xlim(ax5,[0 T]); ylim(ax5, yMax*[-1 1]);

% ======= Animation =======
if doAnimate
    frames = 1:5:numel(t);   % step to lighten animation
    nF = numel(frames);

    % Camera keyframes (az, el) and corresponding "up" vectors
    % Start: unit circle (top-down), Mid: oblique, End: cosine projection
    T1 = [ 0 90]; U1 = [0 1 0];
    T2 = [45 45]; U2 = [0 0 1];
    T3 = [-90  0]; U3 = [0 0 1];

    % Split frames: first half T1->T2, second half T2->T3
    halfN = floor(nF/2);

    for ii = 1:nF
        k  = frames(ii);
        th = mod(omega*t(k), 2*pi);

        % --- Complex-plane phasor updates ---
        set(hRot, 'XData', cos(th), 'YData', sin(th));
        set(hVec, 'UData', cos(th), 'VData', sin(th));
        set(hCos, 'XData', [0 cos(th)], 'YData', [0 0]);
        set(hSin, 'XData', [cos(th) cos(th)], 'YData', [0 sin(th)]);

        % --- Helix vector + cursor (in plane z=t) ---
        set(hVec3, 'XData', 0, 'YData', 0, 'ZData', t(k), ...
                   'UData', zr(k), 'VData', zi(k), 'WData', 0);
        set(hCursor, 'XData', zr(k), 'YData', zi(k), 'ZData', t(k));

        % --- Time-plot dots + guides ---
        set(hDotRe, 'XData', t(k), 'YData', zr(k));
        set(hDotIm, 'XData', t(k), 'YData', zi(k));
        set(hLineRe, 'XData', [t(k) t(k)], 'YData', [0 zr(k)]);
        set(hLineIm, 'XData', [t(k) t(k)], 'YData', [0 zi(k)]);

        % --- Camera path with easing (ease-in/out) ---
        if ii <= halfN
            a = easeInOutCubic((ii-1)/max(1,halfN-1)); % 0..1
            az = lerp(T1(1), T2(1), a);
            el = lerp(T1(2), T2(2), a);
            uNow = slerp_dir(U1, U2, a);
        else
            b = easeInOutCubic((ii - halfN - 1)/max(1, nF - halfN - 1)); % 0..1
            az = lerp(T2(1), T3(1), b);
            el = lerp(T2(2), T3(2), b);
            uNow = slerp_dir(U2, U3, b);
        end
        camup(ax2, uNow);
        view(ax2, az, el);

        drawnow;
    end
end
end

% ---------- Helpers ----------
function y = lerp(a,b,t)
    y = (1-t)*a + t*b;
end

function v = slerp_dir(v1,v2,a)
    v1 = v1(:)/norm(v1); v2 = v2(:)/norm(v2);
    dotp = max(-1,min(1, v1.'*v2)); ang = acos(dotp);
    if ang < 1e-9, v = v2.'; return; end
    v = (sin((1-a)*ang)/sin(ang))*v1 + (sin(a*ang)/sin(ang))*v2;
    v = (v./norm(v)).';  % row vector
end

function x = easeInOutCubic(t)
    % Smooth ease-in/out (0<=t<=1)
    if t < 0.5
        x = 4*t.^3;
    else
        x = 1 - (-2*t + 2).^3/2;
    end
end
