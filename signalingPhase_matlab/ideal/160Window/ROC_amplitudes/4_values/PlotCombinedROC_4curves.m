plot_fig = figure;
%figure('Units', 'inches', 'Position', [1, 1, 6, 4], 'PaperPositionMode', 'auto', 'Renderer', 'painters');
%colormap('gray'); % Example for grayscale, adjust based on your need
%set(gca, 'FontSize', 12, 'LineWidth', 1);

CH1 = convhull(fpr1, tpr1);
CH2 = convhull(fpr2, tpr2);
CH7 = convhull(fpr7, tpr7);
CH8 = convhull(fpr8, tpr8);
% CH9 = convhull(fpr9, tpr9);
% CH10 = convhull(fpr10, tpr10);

DataCH1 = [fpr1(CH1); tpr1(CH1)];
DataCH2 = [fpr2(CH2); tpr2(CH2)];
DataCH7 = [fpr7(CH7); tpr7(CH7)];
DataCH8 = [fpr8(CH8); tpr8(CH8)];
% DataCH9 = [fpr9(CH9); tpr9(CH9)];
% DataCH10 = [fpr10(CH10); tpr10(CH10)];

DataCH1(:,end)=[];
DataCH2(:,end)=[];
DataCH7(:,end)=[];
DataCH8(:,end)=[];
% DataCH9(:,end)=[];
% DataCH10(:,end)=[];

plot(DataCH1(1,:), DataCH1(2,:),'-','Color','#0072BD','LineWidth', 2,'MarkerSize', 8);
hold
plot(DataCH2(1,:), DataCH2(2,:),'-.','Color','#D95319','LineWidth', 4.5,'MarkerSize', 8);
plot(DataCH7(1,:), DataCH7(2,:), "--",'Color','#EDB120','LineWidth', 2.0, 'MarkerSize', 8);
plot(DataCH8(1,:), DataCH8(2,:), "-",'Color','#7E2F8E','LineWidth', 2.0, 'MarkerSize', 8);
% plot(DataCH9(1,:), DataCH9(2,:), "-.",'Color','#2CA02C','LineWidth', 2.0, 'MarkerSize', 8);
% plot(DataCH10(1,:), DataCH10(2,:), "--",'Color','#8C564B','LineWidth', 2.0, 'MarkerSize', 8);
title('ROC Curves for amplitudes', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'tex');
grid on;
xlabel('FPR', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('TPR', 'FontSize', 12, 'Interpreter', 'latex');
ylim([-0.1 1.1])
xlim([-0.002 0.02])
legend('Amplitude = 0.2%', 'Amplitude =  0.1%', 'Amplitude= 0.066%', 'Amplitude = 0.05%','Location','southeast','FontSize',12);

set(gca, 'FontSize', 12, 'FontWeight', 'bold');
box off;
plot_fig.Position = [680 458 645 316];
exportgraphics(gca, 'ConvexCombinedROC4amplitudes.png', 'Resolution', 300);


