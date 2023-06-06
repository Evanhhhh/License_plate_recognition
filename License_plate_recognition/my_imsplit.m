function [ split_img ] = my_imsplit( img )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

% ��ȡͼ��Ĵ�С
[m, n] = size(img);
top = 1;
bottom = m;
left = 1;
right = n;

% ��ȡ�ַ��Ķ���λ��
while sum(img(top, :)) == 0 && top <= m
    top = top + 1;
end

if ((top-10)>=1)
    top = top-10;
else
    top=1;
end

% ��ȡ�ַ��ĵײ�λ��
while sum(img(bottom, :)) == 0 && bottom >= 1
    bottom = bottom -1;
end

if ((bottom+10)<=m)
    bottom = bottom+10;
else
    bottom=m;
end

% ��ȡ�ַ�����߽�
while sum(img(:, left)) == 0 && left <= n
    left = left + 1;
end

% ��ȡ�ַ����ұ߽�
while sum(img(:, right)) == 0 && right >= 1
    right = right - 1;
end

% �õ���͸�
width = right - left;
height = bottom - top;
split_img = imcrop(img, [left top width height]);

end

