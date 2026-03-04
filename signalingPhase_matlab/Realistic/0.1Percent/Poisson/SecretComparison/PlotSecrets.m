t = 1:1:25;
plot_fig = figure;
%figure('Units', 'inches', 'Position', [1, 1, 6, 4], 'PaperPositionMode', 'auto', 'Renderer', 'painters');
%colormap('gray'); % Example for grayscale, adjust based on your need
%set(gca, 'FontSize', 12, 'LineWidth', 1);

plot(t,secretIdeal(1:25), "-",'Color','#0072BD','LineWidth', 2.5, 'MarkerSize', 8);
hold
plot(t,secret2(1:25), ":",'Color','#D95319','LineWidth', 2.5, 'MarkerSize', 8);
plot(t,secret4(1:25), "--",'Color','#EDB120','LineWidth', 2.5, 'MarkerSize', 8);
plot(t,secret6(1:25), '-.', 'Color','#77AC30', 'LineWidth', 2)
title('Comparison of Ideal and realistic secret signal', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');
grid on;
xlabel('Time (s)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
ylabel('Power (W)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
%ylim([9600 10020])
xlim([0 25])
legend('Ideal', '\lambda=0.25', '\lambda=0.50','\lambda=0.75','Location','southeast','FontSize',12);

set(gca, 'FontSize', 12, 'FontWeight', 'bold');
box off;
plot_fig.Position = [680 458 645 316];
exportgraphics(gca, 'RealPoisonSecrets.png', 'Resolution', 300);
