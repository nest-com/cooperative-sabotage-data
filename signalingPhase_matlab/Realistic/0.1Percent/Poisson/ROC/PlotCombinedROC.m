plot_fig = figure;
%figure('Units', 'inches', 'Position', [1, 1, 6, 4], 'PaperPositionMode', 'auto', 'Renderer', 'painters');
%colormap('gray'); % Example for grayscale, adjust based on your need
%set(gca, 'FontSize', 12, 'LineWidth', 1);

plot(fpr1, tpr1, "-",'Color','#0072BD','LineWidth', 2, 'MarkerSize', 8);
hold
plot(fpr2, tpr2, ":",'Color','#D95319','LineWidth', 4.5, 'MarkerSize', 8);
plot(fpr7, tpr7, "--",'Color','#EDB120','LineWidth', 2.0, 'MarkerSize', 8);

title('ROC Curves for different \gamma values', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'tex');
grid on;
xlabel('FPR', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('TPR', 'FontSize', 12, 'Interpreter', 'latex');
ylim([-0.1 1.1])
xlim([-0.005 0.02])
legend('\gamma = 0.25 ', '\gamma = 0.50 ', '\gamma = 0.75','Location','southeast','FontSize',12);

set(gca, 'FontSize', 12, 'FontWeight', 'bold');
box off;
plot_fig.Position = [680 458 645 316];
exportgraphics(gca, 'CombinedROCgammas.png', 'Resolution', 300);


