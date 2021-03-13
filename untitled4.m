function varargout = untitled4(varargin)
% UNTITLED4 MATLAB code for untitled4.fig
%      UNTITLED4, by itself, creates a new UNTITLED4 or raises the existing
%      singleton*.
%
%      H = UNTITLED4 returns the handle to a new UNTITLED4 or the handle to
%      the existing singleton*.
%
%      UNTITLED4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED4.M with the given input arguments.
%
%      UNTITLED4('Property','Value',...) creates a new UNTITLED4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled4

% Last Modified by GUIDE v2.5 18-Jul-2019 13:54:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled4_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled4_OutputFcn, ...
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


% --- Executes just before untitled4 is made visible.
function untitled4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled4 (see VARARGIN)

% Choose default command line output for untitled4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
path = 'C:\Users\BADHAN\Desktop\others\MyRiceDiseaseThesisCodeMatlab';
filter = '*.jpg','*.png';
selectedFile = uigetfile(fullfile(path , filter));
axes(handles.axes1);
img=imread(selectedFile);
imshow(img);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global threshold_image
global mask
lab = rgb2lab(img);
l=lab(:,:,1);
a=lab(:,:,2);
b=lab(:,:,3);
mask = Thresholding(a);
threshold_image= maskout(img,mask);
axes(handles.axes2);
imshow(threshold_image);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global threshold_image
global H2
global V2
global D2
global H1
global V1
global D1

[c,s]=wavedec2(threshold_image,2,'db6');
[H1,V1,D1] = detcoef2('all',c,s,2);
A1 = appcoef2(c,s,'db6',2);
axes(handles.axes3);
imshow(H1);
axes(handles.axes4);
imshow(V1);
axes(handles.axes5);
imshow(D1);
[c1,s1]=wavedec2(threshold_image,2,'db6');
[H2,V2,D2] = detcoef2('all',c1,s1,1);
A2 = appcoef2(c1,s1,'db6',1);
axes(handles.axes6);
imshow(H2);
axes(handles.axes7);
imshow(V2);
axes(handles.axes8);
imshow(D2);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global threshold_image
global mask
global H2
global V2
global D2
global H1
global V1
global D1
global TestingDataSet
mask_counts=sum(mask(:)) ;

redChannelH = H2(:, :, 1);
greenChannelH = H2(:, :, 2);
blueChannelH = H2(:, :, 3);
meanRH=sum(redChannelH(:))/mask_counts ; 
meanGH=sum(greenChannelH(:))/mask_counts;
meanBH=sum(blueChannelH(:))/mask_counts;


if ndims(H2) == 3
               G3=rgb2gray(H2);
            end


glcmsH = graycomatrix(G3);
statsH = graycoprops(glcmsH,{'Contrast','Correlation','Energy','Homogeneity'});
ContrastH=statsH.Contrast;
CorrelationH=statsH.Correlation;
EnergyH=statsH.Energy;
HomogeneityH=statsH.Homogeneity;
Standard_DeviationH = std2(H2);
SkewnessH = skewness(double(H2(:)));
EntropyH = entropy(H2);

%----------------Vertical Feature Exraction-------------------
mask_counts=sum(mask(:)) ;

redChannelV = V2(:, :, 1);
greenChannelV = V2(:, :, 2);
blueChannelV = V2(:, :, 3);
meanRV=sum(redChannelV(:))/mask_counts ; 
meanGV=sum(greenChannelV(:))/mask_counts;
meanBV=sum(blueChannelV(:))/mask_counts;


if ndims(V2) == 3
               G1=rgb2gray(V2);
            end

glcmsV = graycomatrix(G1);
statsV = graycoprops(glcmsV,{'Contrast','Correlation','Energy','Homogeneity'});
ContrastV=statsV.Contrast;
CorrelationV=statsV.Correlation;
EnergyV=statsV.Energy;
HomogeneityV=statsV.Homogeneity;
Standard_DeviationV = std2(V2);
SkewnessV = skewness(double(V2(:)));
EntropyV = entropy(V2);


%----------------Digonal Feature Exraction-------------------
mask_counts=sum(mask(:)) ;

redChannelD = D2(:, :, 1);
greenChannelD = D2(:, :, 2);
blueChannelD = D2(:, :, 3);
meanRD=sum(redChannelD(:))/mask_counts ; 
meanGD=sum(greenChannelD(:))/mask_counts;
meanBD=sum(blueChannelD(:))/mask_counts;


if ndims(D2) == 3
               G2=rgb2gray(D2);
            end

glcmsD = graycomatrix(G2);
statsD = graycoprops(glcmsD,{'Contrast','Correlation','Energy','Homogeneity'});
ContrastD=statsD.Contrast;
CorrelationD=statsD.Correlation;
EnergyD=statsD.Energy;
HomogeneityD=statsD.Homogeneity;
Standard_DeviationD = std2(D2);
SkewnessD = skewness(double(D2(:)));
EntropyD = entropy(D2);

%level2 feature-----------

maskcounts1=sum(mask(:)) ;

redChannelH1 = H1(:, :, 1);
greenChannelH1 = H1(:, :, 2);
blueChannelH1 = H1(:, :, 3);
meanRH1=sum(redChannelH1(:))/maskcounts1 ; 
meanGH1=sum(greenChannelH1(:))/maskcounts1;
meanBH1=sum(blueChannelH1(:))/maskcounts1;


if ndims(H1) == 3
               G31=rgb2gray(H1);
            end
%figure,imshow(G31);title('Horizontal');

glcmsH1 = graycomatrix(G31);
statsH1 = graycoprops(glcmsH1,{'Contrast','Correlation','Energy','Homogeneity'});
ContrastH1=statsH1.Contrast;
CorrelationH1=statsH1.Correlation;
EnergyH1=statsH1.Energy;
HomogeneityH1=statsH1.Homogeneity;
Standard_DeviationH1 = std2(H1);
SkewnessH1 = skewness(double(H1(:)));
EntropyH1 = entropy(H1);
%----------------ShowFeature----------------------
feat_diseaseH = [meanRH1,meanGH1,meanBH1,ContrastH1,CorrelationH1,EnergyH1,HomogeneityH1,Standard_DeviationH1,SkewnessH1,EntropyH1];
           disp(feat_diseaseH);

%----------------Vertical Feature Exraction-------------------
maskcounts1 =sum(mask(:)) ;

redChannelV1 = V1(:, :, 1);
greenChannelV1 = V1(:, :, 2);
blueChannelV1 = V1(:, :, 3);
meanRV1=sum(redChannelV1(:))/maskcounts1 ; 
meanGV1=sum(greenChannelV1(:))/maskcounts1;
meanBV1=sum(blueChannelV1(:))/maskcounts1;


if ndims(V1) == 3
               G11=rgb2gray(V1);
            end
%figure,imshow(G11);title('Vertical');

glcmsV1 = graycomatrix(G11);
statsV1 = graycoprops(glcmsV1,{'Contrast','Correlation','Energy','Homogeneity'});
ContrastV1=statsV1.Contrast;
CorrelationV1=statsV1.Correlation;
EnergyV1=statsV1.Energy;
HomogeneityV1=statsV1.Homogeneity;
Standard_DeviationV1 = std2(V1);
SkewnessV1 = skewness(double(V1(:)));
EntropyV1 = entropy(V1);
%----------------ShowFeature----------------------
feat_diseaseV = [meanRV1,meanGV1,meanBV1,ContrastV1,CorrelationV1,EnergyV1,HomogeneityV1,Standard_DeviationV1,SkewnessV1,EntropyV1];
           disp(feat_diseaseV);


%----------------Digonal Feature Exraction-------------------
maskcounts1=sum(mask(:)) ;

redChannelD1 = D1(:, :, 1);
greenChannelD1 = D1(:, :, 2);
blueChannelD1 = D1(:, :, 3);
meanRD1=sum(redChannelD1(:))/maskcounts1 ; 
meanGD1=sum(greenChannelD1(:))/maskcounts1;
meanBD1=sum(blueChannelD1(:))/maskcounts1;


if ndims(D1) == 3
               G21=rgb2gray(D1);
            end
%figure,imshow(G21);title('Diagonal');

glcmsD1 = graycomatrix(G21);
statsD1 = graycoprops(glcmsD1,{'Contrast','Correlation','Energy','Homogeneity'});
ContrastD1=statsD1.Contrast;
CorrelationD1=statsD1.Correlation;
EnergyD1=statsD1.Energy;
HomogeneityD1=statsD1.Homogeneity;
Standard_DeviationD1 = std2(D1);
SkewnessD1 = skewness(double(D1(:)));
EntropyD1 = entropy(D1);
%----------------ShowFeature----------------------
feat_diseaseD = [meanRD1,meanGD1,meanBD1,ContrastD1,CorrelationD1,EnergyD1,HomogeneityD1,Standard_DeviationD1,SkewnessD1,EntropyD1];
           disp(feat_diseaseD);

           
 %----------ShapeFeatureExtraction----------------          
I2=mask;%figure,imshow(I2);
cc= bwconncomp(I2,8);
n = cc.NumObjects;
 Area = zeros(n,1);
Perimeter = zeros(n,1);
MajorAxis = zeros(n,1);
MinorAxis = zeros(n,1);

k = regionprops(cc, 'Area','Perimeter','MajorAxisLength','MinorAxisLength');

for i = 1:n
     
    Area(i)= k(i).Area;
    Perimeter(i)= k(i).Perimeter;
    MajorAxis(i)= k(i).MajorAxisLength;
    MinorAxis(i)= k(i).MinorAxisLength;
    
     
end
MeanArea1=mean(Area)  ;MeanPerimeter1=mean(Perimeter)  ;MeanMajorAxis1= mean(MajorAxis)  ;MeanMinorAxis1= mean(MinorAxis);


%%%%%%%%%%%%%%%%%


 %--------------FinalResult---------------------
 
 TestingDataSet = table(meanRH,meanGH,meanBH	,ContrastH,	CorrelationH	,EnergyH,	HomogeneityH,	Standard_DeviationH,	SkewnessH,	EntropyH,	meanRV,	meanGV,	meanBV,	ContrastV,	CorrelationV,	EnergyV,	HomogeneityV,	Standard_DeviationV,	SkewnessV,	EntropyV,	meanRD,	meanGD,	meanBD,	ContrastD,	CorrelationD,	EnergyD,	HomogeneityD,	Standard_DeviationD,	SkewnessD,	EntropyD,	meanRH1,	meanGH1,	meanBH1,	ContrastH1,	CorrelationH1,	EnergyH1,	HomogeneityH1,	Standard_DeviationH1,	SkewnessH1	,EntropyH1	,meanRV1,	meanGV1,	meanBV1,	ContrastV1,	CorrelationV1,	EnergyV1,	HomogeneityV1,	Standard_DeviationV1,	SkewnessV1,	EntropyV1,	meanRD1,	meanGD1,	meanBD1,	ContrastD1,	CorrelationD1,	EnergyD1,	HomogeneityD1,	Standard_DeviationD1,	SkewnessD1,	EntropyD1,	MeanArea1,	MeanPerimeter1,	MeanMajorAxis1,	MeanMinorAxis1);

disp(TestingDataSet);
f1 = msgbox('Feature Extraction Completed','Success');




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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global trainedModel
TrainingDataset= readtable('RiceTrainingDataset1,2DecomNewNew4.xlsx');
trainedModel=EnsembleClassifierSubspaceDiscriminent1(TrainingDataset);
f = msgbox('Training Completed','Success');

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TestingDataSet
global trainedModel
yfit = trainedModel.predictFcn(TestingDataSet);
set(handles.edit1, 'String', yfit);
message = sprintf(' %s detected!', yfit{1});
msgbox(message);




function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
