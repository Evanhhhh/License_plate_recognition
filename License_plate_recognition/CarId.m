% ******************************************************
% author: Evan
% title   : 车牌识别
% *******************************************************

function varargout = CarId(varargin)
% CARID MATLAB code for CarId.fig
%      CARID, by itself, creates a new CARID or raises the existing
%      singleton*.
%
%      H = CARID returns the handle to a new CARID or the handle to
%      the existing singleton*.
%
%      CARID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CARID.M with the given input arguments.
%
%      CARID('Property','Value',...) creates a new CARID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CarId_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CarId_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CarId

% Last Modified by GUIDE v2.5 01-Apr-2023 12:44:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...   %模式
                   'gui_OpeningFcn', @CarId_OpeningFcn, ...
                   'gui_OutputFcn',  @CarId_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
%%
% --- Executes just before CarId is made visible.
function CarId_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CarId (see VARARGIN)

% Choose default command line output for CarId
handles.output = hObject;


%隐藏坐标轴
set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');
set(handles.axes4,'visible','off');
set(handles.axes5,'visible','off');
set(handles.axes6,'visible','off');
set(handles.axes7,'visible','off');
set(handles.axes8,'visible','off');
set(handles.axes9,'visible','off');
set(handles.axes10,'visible','off');
set(handles.axes11,'visible','off');
set(handles.axes12,'visible','off');
set(handles.axes14,'visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CarId wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CarId_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
varargout{1} = handles.output;
%% 

%======================my code========================%

function openLocal_Callback(hObject,eventdata,handles) 
%关于uigetfile
%打开一个模态对话框，其中列出了当前文件夹中的文件。用户可以在这里选择或输入文件的名称。如果文件存在并且有效，当用户点击打开时，uigetfile
%将返回文件名。如果用户点击取消或窗口关闭按钮 (X)，uigetfile 将返回 0。
[filename, pathname]=uigetfile({'*.jpg; *.png; *.bmp; *.tif';'*.png';'All Image Files';'*.*'},'请选择图片路径');
if pathname==0
    return;
end
I=imread([pathname filename]);
%显示原图
    axes(handles.axes1)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('原图');
    handles.I=I;        %更新图像
% Update handles structure
guidata(hObject, handles);

%% 功能开关选择 
function checkbox1_Callback(hObject, eventdata, handles) %#ok<*INUSD>
if ( get(hObject,'Value') )
handles.FunctionSwitch= 1;   %#ok<*NASGU>
else
handles.FunctionSwitch= 0;
end
guidata(hObject, handles);
%%
%下面在使用原图方法: handles.I
%预处理 进行灰度处理和边缘检测
function btnGray1_Callback(hObject, eventdata, handles) %#ok<*INUSL>
    I=handles.I;
    I = rgb2gray(I);
    axes(handles.axes2)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);           %解决图像太大无法显示的问题
    title('预灰度处理');
    figure,imhist(I);title('灰度图直方图');
    handles.gray1=I;     %更新原图
% Update handles structure
guidata(hObject, handles);
%%
% 边缘检测.
function btnEdge_Callback(hObject, eventdata, handles)
    I=handles.gray1;
%     关于edge
%     指定要检测的边缘的方向。Sobel 和 Prewitt 方法可以检测垂直方向和/或水平方向的边缘。
%     Roberts 方法可以检测与水平方向成 45 度角和/或 135 度角的边缘。
%     第三个参数为二值化阈值，把比该值大的置为1
%     仅当 method 是 'Sobel'、'Prewitt' 或 'Roberts' 时，此语法才有效。
    if handles.FunctionSwitch==1
       edit2_a=get(handles.edit2,'string');
       edit2_aa=str2double(edit2_a);
       I = edge(I, 'Sobel', edit2_aa, 'both');
       axes(handles.axes3)     %将Tag值为axes1的坐标轴置为当前
       imshow(I,[]);   %解决图像太大无法显示的问题.
       title('预处理边缘检测');
    else
       axes(handles.axes3)     %将Tag值为axes1的坐标轴置为当前
       imshow(I,[]);   %解决图像太大无法显示的问题.
       title('跳过边缘检测');
    end
        handles.edge=I;     %更新原图
       % Update handles structure
    
guidata(hObject, handles);
%%  边缘检测参数调试
function edit2_Callback(hObject, eventdata, handles)

guidata(hObject, handles);
%% 车牌定位
%  图像腐蚀.
function btnFushi_Callback(hObject, eventdata, handles)
    I=handles.edge;
% 关于imerode() 腐蚀图像
% J = imerode(I,SE) 腐蚀灰度图像、二值图像或压缩二值图像 I，返回腐蚀图像 J。
% SE 是结构元素对象或结构元素对象的数组，由 strel 或 offsetstrel 函数返回。
    if handles.FunctionSwitch==1
      %se=[1;1;1];
      edit3_a=get(handles.edit3,'string');
      edit3_aa=round(str2double(edit3_a));
      SE = strel('rectangle',[edit3_aa,1]);
      I = imerode(I, SE);
      axes(handles.axes4)     %将Tag值为axes1的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题
      title('车牌定位图像腐蚀');
    else
      axes(handles.axes4)     %将Tag值为axes1的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题
      title('跳过图像腐蚀');
    end
    handles.Fushi=I;     %更新原图
guidata(hObject, handles);

%% 车牌定位
% 平滑处理
function btnSoft_Callback(hObject, eventdata, handles)
    I=handles.Fushi;
 % imclose函数，即闭运算：用结构元素对图像先膨胀，再腐蚀。
 % 闭运算可以用来融合窄的缺口和细长的弯口，去掉小洞，填补轮廓上的缝隙
 % 本部分的结构元素采用一个大小为 [n n] 的矩形结构
    if handles.FunctionSwitch==1
       edit4_a=get(handles.edit4,'string');
       edit4_aa=round(str2double(edit4_a));
       se = strel('rectangle', [edit4_aa, edit4_aa]);
       I = imclose(I, se);     %使用闭运算进行平滑处理
       axes(handles.axes5)     %将Tag值为axes1的坐标轴置为当前
       imshow(I,[]);   %解决图像太大无法显示的问题
       title('车牌定位平滑处理');
    else
       axes(handles.axes5)     %将Tag值为axes1的坐标轴置为当前
       imshow(I,[]);   %解决图像太大无法显示的问题
       title('跳过平滑处理');
    end
    handles.Soft=I;     %更新原图

guidata(hObject, handles);

%% 车牌定位
% 移除对象
function btnRemove_Callback(hObject, eventdata, handles)
% bwareaopen 函数可以用于 从二值图像中删除小对象
% 格式 BW2 = bwareaopen(BW,P) 从二值图像 BW 中删除少于 P 个像素的所有连通分量（对象），
% 并生成另一个二值图像 BW2。此运算称为面积开运算。
    I=handles.Soft;
    if handles.FunctionSwitch==1
      edit5_a=get(handles.edit5,'string');
      edit5_aa=double(str2double(edit5_a)) ;
      I = bwareaopen(I, edit5_aa);
      axes(handles.axes6)     %将Tag值为axes6的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题.
      title('车牌定位移除对象');
    else
      axes(handles.axes6)     %将Tag值为axes6的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题.
      title('跳过移除对象');
    end
    handles.Remove=I;     %更新原图

guidata(hObject, handles);

%% 车牌定位
%  定位剪切
function btnCut_Callback(hObject, eventdata, handles)

img7=handles.Remove;

[y, x, z] = size(img7);
img8 = double(img7);    % 转成双精度浮点型

% 车牌的蓝色区域
% Y方向
blue_Y = zeros(y, 1);
for i = 1:y
    for j = 1:x
        if(img8(i, j) == 1) % 判断车牌位置区域
            blue_Y(i, 1) = blue_Y(i, 1) + 1;    % 像素点统计
        end
    end
end

% 找到Y坐标的最小值
img_Y1 = 1;
while (blue_Y(img_Y1) < 5) && (img_Y1 < y)
    img_Y1 = img_Y1 + 1;
end

% 找到Y坐标的最大值
img_Y2 = y;
while (blue_Y(img_Y2) < 5) && (img_Y2 > img_Y1)
    img_Y2 = img_Y2 - 1;
end

% x方向
blue_X = zeros(1, x);
for j = 1:x
    for i = 1:y
        if(img8(i, j) == 1) % 判断车牌位置区域
            blue_X(1, j) = blue_X(1, j) + 1;
        end
    end
end

% 找到x坐标的最小值
img_X1 = 1;
while (blue_X(1, img_X1) < 5) && (img_X1 < x)
    img_X1 = img_X1 + 1;
end

% 找到x坐标的最小值
img_X2 = x;
while (blue_X(1, img_X2) < 5) && (img_X2 > img_X1)
    img_X2 = img_X2 - 1;
end

% 对图像进行裁剪
img9 = handles.I(img_Y1:img_Y2, img_X1:img_X2, :);
axes(handles.axes7)     %将Tag值为axes1的坐标轴置为当前
imshow(img9,[]);   %解决图像太大无法显示的问题.
title('图像裁剪');
% 保存提取出来的车牌图像
imwrite(img9, '车牌图像.jpg');
handles.Cut=img9;     %更新原图



% 车牌颜色识别

% 分离RGB通道
r = img9(:,:,1);
g = img9(:,:,2);
b = img9(:,:,3);

% 计算各通道的平均值
mean_r = mean(r(:));
mean_g = mean(g(:));
mean_b = mean(b(:));

% 根据平均值进行颜色分类
if mean_b > mean_g && mean_b > mean_r
    numberplate_color=1;
    color='蓝色';
    disp('车牌颜色：蓝色');
    msgbox('车牌颜色：蓝色','识别出的车牌颜色')
elseif mean_g > mean_b && mean_g > mean_r
    numberplate_color=3;
    color='绿色';
    disp('车牌颜色：绿色');
    msgbox('车牌颜色：绿色','识别出的车牌颜色')
elseif mean_r > 170 && mean_g > 170 && mean_b > 170
    numberplate_color=4;
    color='白色';
    disp('车牌颜色：白色');
    msgbox('车牌颜色：白色','识别出的车牌颜色')
else
    numberplate_color=2;
    color='黄色';
    disp('车牌颜色：黄色');
    msgbox('车牌颜色：黄色','识别出的车牌颜色')
end


handles.numberplate_color=numberplate_color;
handles.color=color;

% Update handles structure
guidata(hObject, handles);


 %% 车牌定位
 % 重新裁剪
function re_split_Callback(hObject, eventdata, handles)
    I=handles.Cut;
    handles.I=I;     %更新原图
guidata(hObject, handles);

%% 车牌识别
% 灰度处理
function btnGray2_Callback(hObject, eventdata, handles)
    
    I=handles.Cut;
    I = rgb2gray(I);
    axes(handles.axes8)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.
    title('车牌识别灰度处理');
    handles.gray2=I;     %更新原图

guidata(hObject, handles);

%% 车牌识别
%  直方图均衡化
function btnBalance_Callback(hObject, eventdata, handles)
    I=handles.gray2;
% histeq 使用直方图均衡增强对比度
% J = histeq(I,n) 变换灰度图像 I，以使输出灰度图像 J 具有 n 个 bin 的直方图大致平坦。
% 当 n 远小于 I 中的离散灰度级数时，J 的直方图更平坦。
    if handles.FunctionSwitch==1
      edit6_a=get(handles.edit6,'string');
      edit6_aa=double(str2double(edit6_a));  
      I = histeq(I,edit6_aa);
      axes(handles.axes9)     %将Tag值为axes1的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题.
      title('车牌识别直方图均衡化');
      figure,subplot(1,2,1),imhist(handles.gray2);title('灰度直方图');
      subplot(1,2,2),imhist(I);title('均衡化后的直方图');
    else
      axes(handles.axes9)     %将Tag值为axes1的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题.
      title('跳过直方图均衡化');
    end
    handles.balance=I;     %更新原图

guidata(hObject, handles);

%% 车牌识别
% 二值化图像
function btnDouble_Callback(hObject, eventdata, handles)
    I=handles.balance;
 % imbinarize函数 通过阈值化将二维灰度图像或三维体二值化  
 %通过将所有高于全局阈值的值替换为 1 并将所有其他值设置为 0，从二维或三维灰度图像 I 创建二值图像。
 % 默认情况下，imbinarize 使用 Otsu 方法，该方法选择特定阈值来最小化阈值化的黑白像素的类内方差
 % imbinarize(I,T) 使用阈值 T 从图像 I 创建二值图像。T 可以是指定为标量亮度值的全局图像阈值，
 % 也可以是指定为亮度值矩阵的局部自适应阈值
    edit8_a=get(handles.edit8,'string');
    edit8_aa=double(str2double(edit8_a));
    
    % 非蓝色车牌图像取反
    if handles.numberplate_color~=1
       I=imcomplement(I);
    end
    
    I = imbinarize(I, edit8_aa);
    axes(handles.axes10)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.
    title('车牌识别图像二值化');
    handles.double=I;     %更新原图

guidata(hObject, handles);

%% 车牌识别
% 移除对象
% --- Executes on button press in remove2.
function remove2_Callback(hObject, eventdata, handles)
% bwareaopen 函数可以用于 从二值图像中删除小对象
% 格式 BW2 = bwareaopen(BW,P) 从二值图像 BW 中删除少于 P 个像素的所有连通分量（对象），
% 并生成另一个二值图像 BW2。此运算称为面积开运算。
    I=handles.double;
    if handles.FunctionSwitch==1
      edit11_a=get(handles.edit11,'string');
      edit11_aa=double(str2double(edit11_a)) ;
      I = bwareaopen(I, edit11_aa);
      axes(handles.axes11)     %将Tag值为axes6的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题.
      title('车牌识别移除对象');
    else
      axes(handles.axes11)     %将Tag值为axes6的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题.
      title('跳过移除对象');
    end
    handles.Remove2=I;     %更新原图
guidata(hObject, handles);


%% 车牌识别
% 中值滤波
function btnMid_Callback(hObject, eventdata, handles)
    I=handles.Remove2;
% medfilt2 二维中位数滤波
% J = medfilt2(I,[m n]) 执行中位数滤波，
% 其中每个输出像素包含输入图像中对应像素周围的 m×n 邻域中的中位数值。
    if handles.FunctionSwitch==1
      edit9_a=get(handles.edit9,'string');
      edit9_aa=double(str2double(edit9_a));  
      I = medfilt2(I,[1 edit9_aa]);
      I = medfilt2(I,[edit9_aa 1 ]);
      axes(handles.axes12)     %将Tag值为axes1的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题.
      imwrite(I,"中值滤波.jpg")
      title('车牌识别中值滤波');
    else
      axes(handles.axes12)     %将Tag值为axes1的坐标轴置为当前
      imshow(I,[]);   %解决图像太大无法显示的问题.
      title('跳过中值滤波');
    end
    handles.Mid=I;     %更新原图

guidata(hObject, handles);

%% 车牌识别
%  图像切割
function btnCut2_Callback(hObject, eventdata, handles)
I=handles.Mid;
I = my_imsplit(I);  %切割图像
[m, n] = size(I);

figure;
imshow(I);

s = sum(I);    %sum(x)就是竖向相加，求每列的和，结果是行向量;
j = 1;
k1 = 1;
k2 = 1;
while j ~= n
    while s(j) == 0
        j = j + 1;
    end
    k1 = j;
    while s(j) ~= 0 && j <= n-1
        j = j + 1;
    end
    k2 = j + 1;
    if k2 - k1 > round(n / 6.5)
        [val, num] = min(sum(I(:, [k1+5:k2-5])));
        I(:, k1+num+5) = 0;
    end
end

y1 = 10;   %10
y2 = 0.05;  %0.25
flag = 0;
word1 = [];
while flag == 0
    [m, n] = size(I);
    left = 1;
    width = 0;
    while sum(I(:, width+1)) ~= 0 || width<n/9
        width = width + 1;
    end
    if width < y1
        I(:, [1:width]) = 0;
        I = my_imsplit(I);
    else
        temp = my_imsplit(imcrop(I, [1,1,width,m]));
        [m, n] = size(temp);
        all = sum(sum(temp));
        two_thirds=sum(sum(temp([round(m/3):2*round(m/3)],:)));
        if two_thirds/all > y2
            flag = 1;
            word1 = temp;
        end
        I(:, [1:width]) = 0;
        I = my_imsplit(I);
    end
end

 % 分割出第二个字符
 [word2,I]=getword(I);
 % 分割出第三个字符
 [word3,I]=getword(I);
 % 分割出第四个字符
 [word4,I]=getword(I);
 % 分割出第五个字符
 [word5,I]=getword(I);
 % 分割出第六个字符
 [word6,I]=getword(I);
 % 分割出第七个字符
 [word7,I]=getword(I);
 
 % 新能源汽车加一个字符
 if handles.numberplate_color==3
  [word8,I]=getword(I);
 end
 
 figure;

 word1=imresize(word1,[40 20]);%imresize对图像做缩放处理，常用调用格式为：B=imresize(A,ntimes,method)；其中method可选nearest,bilinear（双线性）,bicubic,box,lanczors2,lanczors3等
 word2=imresize(word2,[40 20]);
 word3=imresize(word3,[40 20]);
 word4=imresize(word4,[40 20]);
 word5=imresize(word5,[40 20]);
 word6=imresize(word6,[40 20]);
 word7=imresize(word7,[40 20]);

 
if handles.numberplate_color==3
   word8=imresize(word8,[40 20]);
end

 subplot(5,8,17),imshow(word1),title('1');
 subplot(5,8,18),imshow(word2),title('2');
 subplot(5,8,19),imshow(word3),title('3');
 subplot(5,8,20),imshow(word4),title('4');
 subplot(5,8,21),imshow(word5),title('5');
 subplot(5,8,22),imshow(word6),title('6');
 subplot(5,8,23),imshow(word7),title('7');

 
if handles.numberplate_color==3
   subplot(5,8,24),imshow(word8),title('8');
end
 
 imwrite(word1,'1.jpg'); % 创建七位车牌字符图像
 imwrite(word2,'2.jpg');
 imwrite(word3,'3.jpg');
 imwrite(word4,'4.jpg');
 imwrite(word5,'5.jpg');
 imwrite(word6,'6.jpg');
 imwrite(word7,'7.jpg');

 
if handles.numberplate_color==3
  imwrite(word8,'8.jpg');
end

 %% 车牌识别
 % 算法选择
 % --- Executes when selected object is changed in uibuttongroup5.
function uibuttongroup5_SelectionChangedFcn(hObject, eventdata, handles)
 strr=get(hObject,'tag');
switch strr
    case 'radiobutton1'
          handles.algorithm=1;

    case 'radiobutton2'
          handles.algorithm=2;
end
 guidata(hObject, handles);
 

%% 车牌识别
% 模板匹配
function btnSelect_Callback(hObject, eventdata, handles)
%  liccode=char(['0':'9' 'A':'H' 'J':'N' 'P':'Z'  '鲁京粤']);%建立自动识别字符代码表；'鲁
%  liccode=char(['0':'9' 'A':'Z' '川鄂赣贵桂黑沪吉冀津晋京警辽鲁蒙闽宁陕苏皖湘豫粤浙']);%建立自动识别字符代码表；'京津沪渝港澳吉辽鲁豫冀鄂湘晋青皖苏赣浙闽粤琼台陕甘云川贵黑藏蒙桂新宁'
  liccode=char(['0':'9' 'A':'S' 'U':'Z' '川贵黑京警鲁蒙闽苏豫粤浙']);%建立自动识别字符代码表；'京津沪渝港澳吉辽鲁豫冀鄂湘晋青皖苏赣浙闽粤琼台陕甘云川贵黑藏蒙桂新宁'

subBw2 = zeros(40, 20);
 num = 1;   % 车牌位数
 
 % 判断车牌位数
 if handles.numberplate_color==3
   car_size=8;
 else
   car_size=7;     
 end
 
 for i = 1:car_size
    ii = int2str(i);    % 将整型数据转换为字符串型数据
    word = imread([ii,'.jpg']); % 读取之前分割出的字符的图片
    segBw2 = imresize(word, [40,20], 'nearest');    % 调整图片的大小
    segBw2 = imbinarize(segBw2, 0.5);    % 图像二值化
    if i == 1   % 字符第一位为汉字，定位汉字所在字段
        kMin = 36;
        kMax = 47;
    elseif i == 2   % 第二位为英文字母，定位字母所在字段
        kMin = 11;
        kMax = 35;
    elseif i >= 3   % 第三位开始就是数字或字母了，定位数字和字母所在字段
        kMin = 1;
        kMax = 35;
    end
    
    l = 1;
    disp(kMin);
    disp(kMax);
    for k = kMin : kMax
        fname = strcat('model\',liccode(k),'.jpg');  % 根据字符库找到图片模板
        samBw2 = imread(fname); % 读取模板库中的图片
        samBw2 = imbinarize(samBw2, 0.5);    % 图像二值化
        
        % 将待识别图片与模板图片做差
        for i1 = 1:40
            for j1 = 1:20
                subBw2(i1, j1) = segBw2(i1, j1) - samBw2(i1 ,j1);
            end
        end
        
        % 统计两幅图片不同点的个数，并保存下来
        Dmax = 0;
        for i2 = 1:40
            for j2 = 1:20
                if subBw2(i2, j2) ~= 0
                    Dmax = Dmax + 1;
                end
            end
        end
        error(l) = Dmax;
        l = l + 1;
        disp(Dmax);
        disp(liccode(k));
        disp(fname);
    end
    
    % 找到图片差别最少的图像
    errorMin = min(error);
    disp(errorMin);
    findc = find(error == errorMin);
%     error
%     findc
       
    % 根据字库，对应到识别的字符
    Code(num) = liccode(findc(1) + kMin - 1);
    num = num + 1;
    % 白色警车
    if handles.numberplate_color==4
        Code(7) = '警';
    end
    
 end
 
 handles.CodeID=Code;
 axes(handles.axes14)     %将Tag值为axes1的坐标轴置为当前
 imshow(handles.Cut,[]);   %解决图像太大无法显示的问题.
 title('车牌');

  if handles.FunctionSwitch==1
%    [IDCP,IDNUM,IDNAME]=IDFind(Code); 
   msg = ['车牌号：', Code, ', 这是一张', handles.color, '车牌'];
   msgbox(msg,'识别出的车牌号');
   disp(Code);
 else
   msgbox('车牌号：', Code, ', 这是一张', handles.color, '车牌', '识别出的车牌号');
   disp(Code);
 end
 
%  % 显示识别结果
%   if handles.FunctionSwitch==1
%    [IDCP,IDNUM,IDNAME]=IDFind(Code); 
%    msg = ['车牌号：', IDCP, ', 这是一张', handles.color, '车牌'];
%    msgbox(msg,'识别出的车牌号');
%    disp(IDCP);
%  else
%    msgbox('车牌号：', Code, ', 这是一张', handles.color, '车牌', '识别出的车牌号');
%    disp(IDCP);
%  end
 guidata(hObject, handles);





%%
%========================follow is Menu==============================


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf)

% --------------------------------------------------------------------
function ReStart_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Auther_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function Block_Callback(hObject, eventdata, handles)







% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

guidata(hObject, handles);

  
