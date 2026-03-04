plot_fig = figure;
%figure('Units', 'inches', 'Position', [1, 1, 6, 4], 'PaperPositionMode', 'auto', 'Renderer', 'painters');
%colormap('gray'); % Example for grayscale, adjust based on your need
%set(gca, 'FontSize', 12, 'LineWidth', 1);

CH8a = convhull(fpr8a, tpr8a);
CH8b = convhull(fpr8b, tpr8b);
CH8c = convhull(fpr8c, tpr8c);
CH8d = convhull(fpr8d, tpr8d);

DataCH8a = [fpr8a(CH8a); tpr8a(CH8a)];
DataCH8b = [fpr8b(CH8b); tpr8b(CH8b)];
DataCH8c = [fpr8c(CH8c); tpr8c(CH8c)];
DataCH8d = [fpr8d(CH8d); tpr8d(CH8d)];

DataCH8a(:,end)=[];
DataCH8b(:,end)=[];
DataCH8c(:,end)=[];
DataCH8d(:,end)=[];


plot(DataCH8d(1,:), DataCH8d(2,:),'-','Color','#0072BD','LineWidth', 2,'MarkerSize', 8);
hold
%plot(DataCH8c(1,:), DataCH8c(2,:),'-.','Color','#D95319','LineWidth', 4.5,'MarkerSize', 8);
plot(DataCH8b(1,:), DataCH8b(2,:), "--",'Color','#EDB120','LineWidth', 2.0, 'MarkerSize', 8);
plot(DataCH8a(1,:), DataCH8a(2,:), "-",'Color','#7E2F8E','LineWidth', 2.0, 'MarkerSize', 8);
title('ROC Curves for 0.05% Amplitude for different Message Lenghts', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'tex');
grid on;
xlabel('FPR', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('TPR', 'FontSize', 12, 'Interpreter', 'latex');
ylim([-0.1 1.1])
xlim([-0.002 0.02])
legend( '1200 s','880 s', '640 s','Location','southeast','FontSize',12);

set(gca, 'FontSize', 12, 'FontWeight', 'bold');
box off;
plot_fig.Position = [680 458 645 316];
exportgraphics(gca, 'windows005.png', 'Resolution', 300);


