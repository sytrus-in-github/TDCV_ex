%% ex02 a)

sig_i = 3;
sig_d = 0.7*sig_i;
alpha = 0.06;
threshold = 20000;
SHOW_SIGMA = true;
NO_SHOW = false;
% drawHarris('test.pgm', sig_d, sig_i, alpha, threshold, NO_SHOW);
% waitforbuttonpress;
% drawHarris('sample2.jpg', sig_d, sig_i, alpha, threshold, NO_SHOW);
% waitforbuttonpress;
% drawHarris('checkerboard_tunnel.png', sig_d, sig_i, alpha, threshold, NO_SHOW);
% waitforbuttonpress;
drawHarris('house.tif', sig_d, sig_i, alpha, threshold, NO_SHOW);
waitforbuttonpress;

%% ex02 b) c)

% parameters from paper
thresh_h = 1500;
thresh_l = 10;
alpha = 0.06;
c= 0.7;
s_init = 1.5;
k = 1.2;
n = 5;

% drawMultiscaleHarris_('test.pgm', s_init, c, 5, k, alpha, thresh_h);
% waitforbuttonpress;
% drawHarrisLaplace_('test.pgm', s_init, c, 5, k, alpha, thresh_h, thresh_l);
% waitforbuttonpress;
% drawMultiscaleHarris_('sample2.jpg', s_init, c, 5, k, alpha, thresh_h);
% waitforbuttonpress;
% drawHarrisLaplace_('sample2.jpg', s_init, c, 5, k, alpha, thresh_h, thresh_l);
% waitforbuttonpress;
% drawMultiscaleHarris_('checkerboard_tunnel.png', s_init, c, 5, k, alpha, thresh_h);
% waitforbuttonpress;
% drawHarrisLaplace_('checkerboard_tunnel.png', s_init, c, 5, k, alpha, thresh_h, thresh_l);
% waitforbuttonpress;
drawMultiscaleHarris_('house.tif', s_init, c, 5, k, alpha, thresh_h);
waitforbuttonpress;
drawHarrisLaplace_('house.tif', s_init, c, 5, k, alpha, thresh_h, thresh_l);
waitforbuttonpress;

%% ex02 d)

thresh_h = 1500;
thresh_l = 10;
alpha = 0.06;
c= 0.7;
s_init = 1.5;
k = 1.2;

drawMultiscaleHarris0517_('house.tif', s_init, c, k, alpha, thresh_h);
waitforbuttonpress;
drawHarrisLaplace0517_('house.tif', s_init, c, k, alpha, thresh_h, thresh_l);
waitforbuttonpress;
