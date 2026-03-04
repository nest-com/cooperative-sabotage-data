plot_fig = figure;

%figure('Units', 'inches', 'Position', [1, 1, 12, 8], 'PaperPositionMode', 'auto', 'Renderer', 'painters');
%colormap('gray'); % Example for grayscale, adjust based on your need
plot(fpr2, tpr2, ":",'Color','#D95319','LineWidth', 4.5, 'MarkerSize', 8);
hold on;
plot(fpr1, tpr1, "-",'Color','#0072BD','LineWidth', 2.0, 'MarkerSize', 8);
plot(fpr7, tpr7, "--",'Color','#EDB120','LineWidth', 2.5, 'MarkerSize', 8);
title('ROC Curves for different secret message amplitudes', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'tex');
grid on;
xlabel('FPR', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('TPR', 'FontSize', 12, 'Interpreter', 'latex');
ylim([-0.1 1.1])
xlim([-0.005 0.01])
legend('0.2% Max. Demand Amplitude ', '0.1% Max. Demand Amplitude ', '0.075% Max. Demand Amplitude ','Location','southeast','FontSize',12);
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
box off;
plot_fig.Position = [680 458 645 316];
exportgraphics(plot_fig, 'CombinedROCIdealSecret.png', 'Resolution', 300);