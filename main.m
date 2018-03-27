function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 27-Dec-2017 17:20:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
% global x;
% global y;
% global z;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% 数据处理
global x;
global y;
global z;
[FileName,PathName] = uigetfile('*.txt','Select the DATA code file');
fileID = fopen(strcat(PathName,FileName));
data = textscan(fileID,'%s %8.1f %f %7.1f','delimiter',',','HeaderLines',2);
x = data{1,2}(1:2:end,1);
y = data{1,3}(1:2:end,1);
z = data{1,4}(1:2:end,1);
x = x - mean(x);
y = y - mean(y);
z = z - mean(z);
% x = x(160:270);
% y = y(160:270);
% z = z(160:270);
figure;
subplot(3,1,1);plot(x);title('x轴原始数据');
subplot(3,1,2);plot(y);title('y轴原始数据');
subplot(3,1,3);plot(z);title('z轴原始数据');

%频谱分析
% pinpu(x);
% pinpu(y);
% pinpu(z);

%LMS滤波算法
% LMS(x');
% LMS(y');
% LMS(z');

%5点取中值均值滤波
% fiveAvi(x);
% fiveAvi(y);
% fiveAvi(z);



%窗函数滤波
% bhi = fir1(34,0.3);
% chebX = filter(bhi,1,x);
% fx = conv(x,bhi);
% figure;
% subplot(2,1,1);plot(x);title('原始信号');
% subplot(2,1,2);plot(fx);title(' Hamming窗函数滤波结果');
% N=length(x); %样点个数
% fs=10;%采样频率
% df=fs/(N-1);%分辨率
% f=(0:N-1)*df;%其中每点的频率
% X=fft(x(1:N))/N*2;%真实的幅值
% FX=fft(fx(1:N))/N*2;%真实的幅值
% figure;
% subplot(2,1,1);plot(f(1:N/2),abs(X(1:N/2)));title('原始图像频谱分析');
% subplot(2,1,2);plot(f(1:N/2),abs(FX(1:N/2)));title('Hamming窗函数滤波结果频谱分析')
% 


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
%5点取中值
global x;
global y;
global z;

fiveMedian(x,y,z);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% 5点均值滤波
global x;
global y;
global z;
fiveAvi(x,y,z);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
%Hamming窗函数滤波结果
global x;
global y;
global z;
bhi = fir1(34,0.3);
hammingx = conv(x,bhi);
hammingy = conv(y,bhi);
hammingz = conv(z,bhi);
figure;
subplot(3,1,1);plot(hammingx(18:end-17));title(' x轴数据Hamming窗函数滤波结果');
subplot(3,1,2);plot(hammingy(18:end-17));title(' y轴数据Hamming窗函数滤波结果');
subplot(3,1,3);plot(hammingz(18:end-17));title(' z轴数据Hamming窗函数滤波结果');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% Hanning窗滤波结果
global x;
global y;
global z;
Window=hann(35);
bhi = fir1(34,0.3,Window);
hanningx = conv(x,bhi);
hanningy = conv(y,bhi);
hanningz = conv(z,bhi);
figure;
subplot(3,1,1);plot(hanningx(18:end-17));title(' x轴数据Hanning窗函数滤波结果');
subplot(3,1,2);plot(hanningy(18:end-17));title(' y轴数据Hanning窗函数滤波结果');
subplot(3,1,3);plot(hanningz(18:end-17));title(' z轴数据Hanning窗函数滤波结果');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% Blackman窗函数滤波
global x;
global y;
global z;
Window=blackman(35);
bhi = fir1(34,0.3,Window);
blackmanx = conv(x,bhi);
blackmany = conv(y,bhi);
blackmanz = conv(z,bhi);
figure;
subplot(3,1,1);plot(blackmanx(18:end-17));title(' x轴数据Blackman窗函数滤波结果');
subplot(3,1,2);plot(blackmany(18:end-17));title(' y轴数据Blackman窗函数滤波结果');
subplot(3,1,3);plot(blackmanz(18:end-17));title(' z轴数据Blackman窗函数滤波结果');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% Kaiser窗函数滤波
global x;
global y;
global z;
Window=kaiser(35);
bhi = fir1(34,0.3,Window);
kaiserx = conv(x,bhi);
kaisery = conv(y,bhi);
kaiserz = conv(z,bhi);
figure;
subplot(3,1,1);plot(kaiserx(18:end-17));title(' x轴数据Kaiser窗函数滤波结果');
subplot(3,1,2);plot(kaisery(18:end-17));title(' y轴数据Kaiser窗函数滤波结果');
subplot(3,1,3);plot(kaiserz(18:end-17));title(' z轴数据Kaiser窗函数滤波结果');


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
%Bartlett滤波
global x;
global y;
global z;
Window=bartlett(35);
bhi = fir1(34,0.3,Window);
bartlettx = conv(x,bhi);
bartletty = conv(y,bhi);
bartlettz = conv(z,bhi);
figure;
subplot(3,1,1);plot(bartlettx(18:end-17));title(' x轴数据Bartlett窗函数滤波结果');
subplot(3,1,2);plot(bartletty(18:end-17));title(' y轴数据Bartlett窗函数滤波结果');
subplot(3,1,3);plot(bartlettz(18:end-17));title(' z轴数据Bartlett窗函数滤波结果');


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% boxcar（矩形窗）
global x;
global y;
global z;
Window=boxcar(35);
bhi = fir1(34,0.3,Window);
boxcarx = conv(x,bhi);
boxcary = conv(y,bhi);
boxcarz = conv(z,bhi);
figure;
subplot(3,1,1);plot(boxcarx(18:end-17));title(' x轴数据矩形窗函数滤波结果');
subplot(3,1,2);plot(boxcary(18:end-17));title(' y轴数据矩形窗函数滤波结果');
subplot(3,1,3);plot(boxcarz(18:end-17));title(' z轴数据矩形窗函数滤波结果');


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% LMS滤波
global x;
global y;
global z;
LMS(x,y,z);


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% 维纳滤波
global x;
global y;
global z;
wiener(x,y,z);


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% 小波去燥
global x;
global y;
global z;
xiaobo(x,y,z);
