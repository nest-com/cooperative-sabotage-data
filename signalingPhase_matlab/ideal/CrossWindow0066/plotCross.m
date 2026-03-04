plot_fig = figure;
%figure('Units', 'inches', 'Position', [1, 1, 6, 4], 'PaperPositionMode', 'auto', 'Renderer', 'painters');
%colormap('gray'); % Example for grayscale, adjust based on your need
%set(gca, 'FontSize', 12, 'LineWidth', 1);

CH7a = convhull(fpr7, tpr7);
CH7b = convhull(fpr7b, tpr7b);

DataCH7a = [fpr7(CH7a); tpr7(CH7a)];
DataCH7b = [fpr7b(CH7b); tpr7b(CH7b)];

DataCH7a(:,end)=[];
DataCH7b(:,end)=[];


plot(DataCH7b(1,:), DataCH7b(2,:),'-','Color','#0072BD','LineWidth', 2,'MarkerSize', 8);
hold
plot(DataCH7a(1,:), DataCH7a(2,:),'-.','Color','#D95319','LineWidth', 4.5,'MarkerSize', 8);

title('ROC Curves for 0.066% Amplitude for different Message Lenghts', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'tex');
grid on;
xlabel('FPR', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('TPR', 'FontSize', 12, 'Interpreter', 'latex');
ylim([-0.1 1.1])
xlim([-0.002 0.02])
legend( '880 s', '640 s','Location','southeast','FontSize',12);

set(gca, 'FontSize', 12, 'FontWeight', 'bold');
box off;
plot_fig.Position = [680 458 645 316];
exportgraphics(gca, 'ConvexCombinedROC4amplitudes.png', 'Resolution', 300);


