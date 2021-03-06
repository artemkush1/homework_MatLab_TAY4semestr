clear;
s = tf ('s');
g = 1;

alpha = 0.1;
q = s;
% �������� ������������
calculate(alpha, q, 0, g);
% �������� ��������� ����� ������� ������������
calculate(alpha, q*alpha, 200, g);


function calculate(alpha, q, shift_, g)
    t = (0:0.01:10)';
    W_yg = (q^2*18*alpha+3*q^2+3*q+1)/(q+1)^3;
    [y,t] = step(W_yg, t);
    step_info = stepinfo(W_yg,'SettlingTimeThreshold', 0.05);
    tau_r = step_info.SettlingTime
    t_r = alpha * tau_r

    W = 1/(q+1)^3;
    [y_table,t] = step(W, t);
    step_info_table = stepinfo(W,'SettlingTimeThreshold', 0.05);
    tau_r_table = step_info_table.SettlingTime
    t_r_table = alpha * tau_r_table

    % ������
    figure('position', [250+shift_, 250, 1000+shift_, 700]);
    hold on;

    plot(t, squeeze(y), t, squeeze(y_table), 'LineWidth', 2), grid;
    xline(tau_r, '-.b', 'Linewidth', 1);
    xline(tau_r_table, '-.re', 'Linewidth', 1);
    yline(g - 0.05*g);
    yline(g + 0.05*g);
    plot(tau_r, 1 - 0.05*1, 'oblack', 'Linewidth', 3);
    plot(tau_r_table, 1 - 0.05*1, 'oblack', 'Linewidth', 3);

    xlabel('time (seconds)');
    ylabel('Amplitude');
    title('System reaction');
    legend('W_{yg}','W_{table}','SettlingTime','SettlingTime');

    hold off;
end


