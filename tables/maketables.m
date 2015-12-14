addpath latexTable
% source: http://www.mathworks.com/matlabcentral/fileexchange/44274-latextable


%% Table 1: performance of SVT on synthetic data

ld = load('svt_synth.mat');
rows = ld.rows;

input.data = [[rows.n]' ...
    [rows.rank]' ...
    [rows.mdr]' ...
    ([rows.mdr]' .* [rows.rank]' .* (2 * [rows.n]' - [rows.rank]') ./ [rows.n]' ./ [rows.n]') ...
    [cellfun(@mean, {rows.time})]' ...
    [cellfun(@mean, {rows.iter})]' ...
    [cellfun(@mean, {rows.relerr})]' .* 10^4];

input.tableColLabels = {'size ($n \times n$)', ...
    'rank ($r$)', ...
    '$m/d_r$', ...
    '$m/n^2$', ...
    'time (s)', ...
    '\#iters', ...
    'relative error'};

input.dataFormat = {'%d',3,'%0.3f',1,'%.1f',2,'%0.5f x $10^{-4}$',1};

input.tableLabel = 'svt_synth_1';
input.tableCaption = ...
    ['Performance of Singular Value Thresholding on synthetic ' ...
     'matrices of known rank. We generate two $n\times r$ matrices ' ...
     '$U$ and $V$ whose entries are i.i.d. gaussian.' ...
     'We choose $m$ random entries from $M = U V^T$ and measure ' ...
     'convergence rates of SVT. $m/d_r$ is the ratio of sampled ' ...
     'entries $m$ and the ``true dimensionality'''' $d_r = r(2n-r)$.'];

latex = latexTable(input);

fid = fopen('svt_synth.tex', 'w');
for i = 1:numel(latex)
    fprintf(fid, '%s\n', latex{i});
end
fclose(fid);

%% Comparison of svt and keshavan



