plot_fig = figure;

amps = [0.2 0.1 0.066 0.05];
lengths = [480 640 880 1200];
plot(lengths, amps, '-','Color','#0072BD','LineWidth', 2,'MarkerSize', 8)
 title('Trade Off Amplitude vs Length of the secret message', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'tex');grid on;
xlabel('Message Length (s)', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('Percentage of normal demand', 'FontSize', 12, 'Interpreter', 'latex');


set(gca, 'FontSize', 12, 'FontWeight', 'bold');
box off;
plot_fig.Position = [680 458 645 316];
exportgraphics(gca, 'tradeoff.png', 'Resolution', 300);


