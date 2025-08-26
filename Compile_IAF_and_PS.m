function extractIAF=(data_path,);

%% this function will extract IAF for participants and store the resulting value in metadata; 
% it also plots a summary figure at the end with the individual power
% spectra and an average across participants

% input
%addpath('D:\code\scripts_yifan');
labnum=18;
subnum=[1:2 5:22];
%subnum=7;
data_path='D:\data';

figure;
for n=1:length(subnum)
    [paf,psd,f]=IAF_estimate(data_path,labnum,subnum(n));
    IAF(n,:)=paf;
    PS_pre_ec(n,:)=psd(1,:);
    PS_pre_eo(n,:)=psd(2,:);
    PS_post_ec(n,:)=psd(3,:);
    PS_post_eo(n,:)=psd(4,:);
    subplot(5,4,n);
    plot(f,psd);legend Pre_EC Pre_EO Post_EC Post_EO
    title(strcat(['Participant-' num2str(subnum(n))]));
end

mean_PS_pre(1,:)=mean(PS_pre_ec,1);
mnse_PS_pre(1,:)=std(PS_pre_ec,0,1)./sqrt(numel(subnum));
mean_PS_pre(2,:)=mean(PS_pre_eo,1);
mnse_PS_pre(2,:)=std(PS_pre_eo,0,1)./sqrt(numel(subnum));

mean_PS_post(1,:)=mean(PS_post_ec,1);
mnse_PS_post(1,:)=std(PS_post_ec,0,1)./sqrt(numel(subnum));
mean_PS_post(2,:)=mean(PS_post_eo,1);
mnse_PS_post(2,:)=std(PS_post_eo,0,1)./sqrt(numel(subnum));

%% Plot mean and SE for sanity checking; i.e. if eyes closed doesn't show higher alpha power than eyes open you're in trouble ... 
figure;
% plot for Pre eyes close and eyes open
subplot(2,1,1);
cols=['b' 'r'];
for k=1:2
    plot(f, mean_PS_pre(k,:), cols(k), 'LineWidth', 2); hold on;
    
    % Shaded area for ±SE
    x = f;
    y1 = mean_PS_pre(k,:) - mnse_PS_pre(k,:);
    y2 = mean_PS_pre(k,:) + mnse_PS_pre(k,:);
    fill([x', fliplr(x')], [y1, fliplr(y2)], cols(k), 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Mean and Standard Error');
    grid on;
end

legend('Mean EC', '±SE EC', 'Mean EO', '±SE EO');
title('Pre');
hold off

% plot for Post eyes close and eyes open
subplot(2,1,2);
cols=['b' 'r'];
for k=1:2
    plot(f, mean_PS_pre(k,:), cols(k), 'LineWidth', 2); hold on;
    
    % Shaded area for ±SE
    x = f;
    y1 = mean_PS_pre(k,:) - mnse_PS_pre(k,:);
    y2 = mean_PS_pre(k,:) + mnse_PS_pre(k,:);
    fill([x', fliplr(x')], [y1, fliplr(y2)], cols(k), 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Mean and Standard Error');
    grid on;
end

legend('Mean EC', '±SE EC', 'Mean EO', '±SE EO');
hold off
title('Post');
