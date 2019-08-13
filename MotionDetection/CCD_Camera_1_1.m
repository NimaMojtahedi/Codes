function varargout = CCD_Camera_1_1(varargin)


% By Nima Mojtahedi student of Tübingen University Department Physiology 2


% CCD_CAMERA MATLAB code for CCD_Camera.fig
%      CCD_CAMERA, by itself, creates a new CCD_CAMERA or raises the existing
%      singleton*.
%
%      H = CCD_CAMERA returns the handle to a new CCD_CAMERA or the handle to
%      the existing singleton*.
%
%      CCD_CAMERA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CCD_CAMERA.M with the given input arguments.
%
%      CCD_CAMERA('Property','Value',...) creates a new CCD_CAMERA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CCD_Camera_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CCD_Camera_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CCD_Camera

% Last Modified by GUIDE v2.5 26-Feb-2015 10:09:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CCD_Camera_OpeningFcn, ...
                   'gui_OutputFcn',  @CCD_Camera_OutputFcn, ...
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


% --- Executes just before CCD_Camera is made visible.
function CCD_Camera_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CCD_Camera (see VARARGIN)

% Choose default command line output for CCD_Camera
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CCD_Camera wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CCD_Camera_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
img=imread(strcat(pwd,'\bc.jpeg'));
imshow(img,'Parent',handles.axes1);
warning('off','all')
set(handles.edit18,'enable','off')
set(handles.edit4,'enable','off')
set(handles.edit19,'enable','off')

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile('*.avi','Select Video');
Data=guidata(hObject);
Data.PathName=PathName;
Data.FileName=FileName;
set(handles.edit1,'String',strcat(PathName,FileName))

guidata(hObject,Data);


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
iMg=NaN;
%NumberOfFrames=Data.FrameNumber;
viDeo=Data.Video;
if (isfield(Data,'NThreshold') & Data.NThreshold>0)
    Thresh=Data.NThreshold;
else
    Thresh=.05;
end
rc=Data.RectangleInfo;
        if isfield(Data,'MedianKernel') & Data.MedianKernel>0
            Kernel=[Data.MedianKernel Data.MedianKernel];
        else
            Kernel=[3 3];
        end
        if isfield(Data,'MedianKernelRep') & Data.MedianKernelRep>0
            Rep=Data.MedianKernelRep;
        else
            Rep=1;
        end
for i=Data.StartFrame:Data.EndFrame
    Images=read(viDeo,i);
    if isequal(get(handles.radiobutton1,'Value'),1)
        for p=1:Rep
    Image=medfilt2(Images(rc(2):rc(2)+rc(4),rc(1):rc(1)+rc(3),1),Kernel);
        end
    else
    end
    % MEAN calculates mean intensity in subtracted image from previous
    % frame --> Hier I used median filter after subtraction
    MEAN(i,1)=mean(mean(medfilt2(im2bw(abs(Image-iMg),Thresh))));
    iMg=Image;
    h100=waitbar(i/(Data.EndFrame-Data.StartFrame));
end
delete(h100)
figure(100)
% plot(MEAN(Data.StartFrame:end,1))
% hold on 
plot(medfilt1(MEAN(Data.StartFrame:end,1),3))
title([' Mean Intensity for Subtracted Image from Previous Frame for Video  ',Data.FileName])
Data.Mean=medfilt1(MEAN(Data.StartFrame:end,1),3);
guidata(hObject,Data);



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SliderNumber=get(hObject,'Value');
Data=guidata(hObject);
Video=Data.Video;

Data.SliderNumber=SliderNumber;
ImG=read(Video,floor(SliderNumber));
imshow(ImG(:,:,1),'parent',handles.axes1)
rectangle('Position',Data.RectangleInfo,'LineWidth',1.5,'EdgeColor',[.5 .8 .9],'Parent',handles.axes1);
set(handles.edit2,'String',floor(SliderNumber));
guidata(hObject,Data);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
cur=pwd;
set(handles.edit3,'String','Please Wait, File is Loading ...')
pause(.001)
cd(Data.PathName)

vd=VideoReader(Data.FileName);
imG=read(vd,1);
Data.RectangleInfo=[1 1 [(size(imG(:,:,1),2)-1) (size(imG(:,:,1),1)-1)]];
set(handles.edit3,'String','File Loaded')
imshow(imG,'Parent',handles.axes1);
Data.Video=vd;
Data.ConfInter=.95;
FrameNumber=vd.NumberOfFrames;
Data.FrameNumber=FrameNumber;
Data.StartFrame=1;
Data.EndFrame=FrameNumber;
Data.SliderNumber=1;
set(handles.slider1,'max',FrameNumber,'min',1,'value',1,'sliderstep',[1/(FrameNumber-1) 1/(FrameNumber-1)]);

cd(cur)
% for j=1:FrameNumber
%     III=read(vd,j);
%     D3VideoImages(:,:,j)=III(:,:,1);
%     k=waitbar(j/FrameNumber);
%     delete(k)
% end
% 
% Data.ThreeDVideoImages=D3VideoImages;
guidata(hObject,Data);


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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
if isfield(Data,'Mean') 
    if isfield(Data,'BThreshold')
        meaN=Data.Mean;
        for j=1:size(meaN,1)
            if meaN(j,1)>Data.BThreshold
                meaN(j,1)=1;
            else
                meaN(j,1)=0;
            end
        end
        Data.BSignal=meaN;
        figure(67)
        plot(meaN)
        title('Binary Signal')
        ylim([0 1.5])
    end
end
guidata(hObject,Data);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
iMg=NaN;
%NumberOfFrames=Data.FrameNumber;
viDeo=Data.Video;
for i=Data.StartFrame:Data.EndFrame
    Images=read(viDeo,i);
    Image=(Images(:,:,1));
    % MEAN calculates mean intensity in subtracted image from previous
    % frame --> Hier I used median filter after subtraction
    MEAN(i,1)=mean(mean(medfilt2(im2bw(abs(Image-iMg),.04))));
    iMg=Image;
    h100=waitbar(i/NumberOfFrames);
end
delete(h100)
figure(100)
plot(MEAN)
title([' Mean Intensity for Subtracted Image from Previous Frame for Video  ',Data.FileName])


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
chk=get(hObject,'Value');
if isequal(chk,1)
    set(handles.edit4,'enable','on');
else
    set(handles.edit4,'enable','off');
end

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
Data=guidata(hObject);
Data.NThreshold=str2double(get(hObject,'String'));
guidata(hObject,Data);

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
Data=guidata(hObject);
Data.StartFrame=str2double(get(hObject,'String'));
guidata(hObject,Data);

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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
Data=guidata(hObject);
Data.EndFrame=str2double(get(hObject,'String'));
guidata(hObject,Data);

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
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
Data=guidata(hObject);
Data.HStartFrame=str2double(get(hObject,'String'));
guidata(hObject,Data);

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
Data=guidata(hObject);
Data.HEndFrame=str2double(get(hObject,'String'));
guidata(hObject,Data);

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


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
rc=Data.RectangleInfo;
if isfield(Data,'HStartFrame') & isfield(Data,'HEndFrame')
    if Data.HStartFrame>0 & Data.HEndFrame>0
        Ig=NaN;
        if isfield(Data,'MedianKernel') & Data.MedianKernel>0
            Kernel=[Data.MedianKernel Data.MedianKernel];
        else
            Kernel=[3 3];
        end
        if isfield(Data,'MedianKernelRep') & Data.MedianKernelRep>0
            Rep=Data.MedianKernelRep;
        else
            Rep=1;
        end
        for ii=Data.HStartFrame:Data.HEndFrame
        
           img=(read(Data.Video,ii));
           if isequal(get(handles.radiobutton1,'Value'),1)
               for p=1:Rep
           img=medfilt2(img(:,:,1),Kernel);
               end
           else
           end
           iig=img(rc(2):rc(2)+rc(4),rc(1):rc(1)+rc(3),1)-Ig;
           Image(:,:,ii-Data.HStartFrame+1)=iig;
           Ig=img(rc(2):rc(2)+rc(4),rc(1):rc(1)+rc(3),1);
        end
        [cotss,xx]=ImgHist(Image);
        csum=cumsum(cotss(2:256,1));
        if isfield(Data,'ConfInter') & Data.ConfInter>0
            if Data.ConfInter>50
                
            ConfInter=(Data.ConfInter)/100;
            else
             ConfInter=(100-Data.ConfInter)/100;
            end
        else
            ConfInter=0.95;
        end
        pros=find(abs(csum-ConfInter*csum(end,1))==min(abs(csum-ConfInter*csum(end,1))));
        set(handles.edit14,'String',num2str(pros))
        Data.NoiseLevel=pros;
        guidata(hObject,Data)
%         hold on
%         plot(pros,1:cotss(1,1),'*r')
%         hold off
        
    else
        error(' Please Check Start and End Frame Numbers ')
    end
else
    error('Please Select Start and End Frame Numbers')
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
% cla(handles.axes1)
% imshow(read(Data.Video,1),'Parent',handles.axes1);

Img=read(Data.Video,1);
h=figure(731);
[I RectangleInfo]=imcrop(Img(:,:,1));
delete(h);
imshow(read(Data.Video,Data.SliderNumber),'Parent',handles.axes1);
Data.RectangleInfo=RectangleInfo;
set(handles.edit12,'String',num2str(RectangleInfo))
rectangle('Position',RectangleInfo,'LineWidth',1.5,'EdgeColor',[.5 .8 .9],'Parent',handles.axes1);
guidata(hObject,Data);

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



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double
Data=guidata(hObject);
Data.ConfInter=str2double(get(hObject,'String'));
guidata(hObject,Data);

% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
c=clock;
SV.TimeDate=[c(1) c(2) c(3) c(4) c(5) c(6)];
if isfield(Data,'MedianKernel')
 SV.MedianKernel=Data.MedianKernel;
end
 if isfield(Data,'MedianKernelRep')
 SV.MedianKernelRep=Data.MedianKernelRep;
 end
if isfield(Data,'RectangleInfo')
 SV.RectangleInfo=Data.RectangleInfo;
 end
 if isfield(Data,'HStartFrame')
     SV.HStartFrame=Data.HStartFrame;
 end
 if isfield(Data,'HEndFrame')
     SV.HEndFrame=Data.HEndFrame;
 end
 
 if isfield(Data,'ConfInter')
      SV.ConfInter=Data.ConfInter;
 end
 if isfield(Data,'NoiseLevel')
      SV.NoiseLevel=Data.NoiseLevel;
 end
 if isfield(Data,'StartFrame')
      SV.StartFrame=Data.StartFrame;
 end
 if isfield(Data,'EndFrame')
      SV.EndFrame=Data.EndFrame;
 end
 if isfield(Data,'NThreshold')
      SV.NThreshold=Data.NThreshold;
 end
 if isfield(Data,'BThreshold')
      SV.BThreshold=Data.BThreshold;
 end
 if isfield(Data,'Mean')
      SV.Mean=Data.Mean;
 end
 if isfield(Data,'BSignal')
      SV.BSignal=Data.BSignal;
 end
 if isfield(Data,'LED')
      SV.LED=Data.LED;
 end
 if isfield(Data,'Video')
      SV.FrameRate=Data.Video.FrameRate;
 end
  if isfield(Data,'CalciumLEDThreshold')
      SV.CalciumLEDThreshold=Data.CalciumLEDThreshold;
  end
  if isfield(Data,'CalciumLEDStart')
      SV.CalciumLEDStart=Data.CalciumLEDStart;
      SV.CalciumLEDEnd=Data.CalciumLEDEnd;
  end
  if isfield(Data,'VideoLEDStart')
      SV.VideoLEDStart=Data.VideoLEDStart;
      SV.VideoLEDEnd=Data.VideoLEDEnd;
  end
  if isfield(Data,'VideoLEDThreshold')
      SV.VideoLEDThreshold=Data.VideoLEDThreshold;
  end
 if isfield(Data,'OriginalVideoInterpolatedSignal')
      SV.OriginalVideoInterpolatedSignal=Data.OriginalVideoInterpolatedSignal;
 end
 if isfield(Data,'OriginalBinaryVideoInterpolatedSignal')
      SV.OriginalBinaryVideoInterpolatedSignal=Data.OriginalBinaryVideoInterpolatedSignal;
 end
 if isfield(Data,'VideoLEDInterpolated')
      SV.VideoLEDInterpolated=Data.VideoLEDInterpolated;
 end
 if isfield(Data,'CalciumLEDSignal')
      SV.CalciumLEDSignal=Data.CalciumLEDSignal;
 end
uisave('SV')



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentpath=pwd;
Data=guidata(hObject);
if ~isfield(Data,'Video')
    error('Please Load Vidoe file First');
end
[filename, pathname] = ...
     uigetfile('*.mat','File Selector');
 
 cd(pathname)
 Da=load(filename);
 SV=Da.SV;
 cd(currentpath)
  if isfield(SV,'RectangleInfo')
 Data.RectangleInfo=SV.RectangleInfo;
  end
   if isfield(SV,'HStartFrame')
 Data.HStartFrame=SV.HStartFrame;
 Data.HEndFrame=SV.HEndFrame;
   end
   if isfield(SV,'ConfInter')
 Data.ConfInter=SV.ConfInter;
   end
    if isfield(SV,'NoiseLevel')
 Data.NoiseLevel=SV.NoiseLevel;
    end
     if isfield(SV,'StartFrame')
 Data.StartFrame=SV.StartFrame;
     end
      if isfield(SV,'EndFrame')
 Data.EndFrame=SV.EndFrame;
      end
       if isfield(SV,'NThreshold')
 Data.NThreshold=SV.NThreshold;
       end
        if isfield(SV,'BThreshold')
 Data.BThreshold=SV.BThreshold;
        end
        if isfield(SV,'MedianKernel')
 Data.MedianKernel=SV.MedianKernel;
        end
        if isfield(SV,'MedianKernelRep')
 Data.MedianKernelRep=SV.MedianKernelRep;
        end
 guidata(hObject,Data)
 % Set all Information in right places
 set(handles.edit1,'String',pathname);
 if isfield(Data,'RectangleInfo')
 set(handles.edit12,'String',num2str(Data.RectangleInfo))
 end
 if isfield(Data,'HStartFrame')
     set(handles.edit8,'String',num2str(Data.HStartFrame))
 end
 if isfield(Data,'HEndFrame')
     set(handles.edit9,'String',num2str(Data.HEndFrame))
 end
 
 if isfield(Data,'ConfInter')
     set(handles.edit13,'String',num2str(Data.ConfInter))
 end
 if isfield(Data,'NoiseLevel')
     set(handles.edit14,'String',num2str(Data.NoiseLevel))
 end
 if isfield(Data,'StartFrame')
     set(handles.edit5,'String',num2str(Data.StartFrame))
 end
 if isfield(Data,'EndFrame')
     set(handles.edit7,'String',num2str(Data.EndFrame))
 end
 if isfield(Data,'NThreshold')
     set(handles.edit4,'String',num2str(Data.NThreshold))
 end
 if isfield(Data,'BThreshold')
     set(handles.edit15,'String',num2str(Data.BThreshold))
 end
 if isfield(Data,'MedianKernelRep')
     set(handles.edit19,'String',num2str(Data.MedianKernelRep))
 end
 if isfield(Data,'MedianKernel')
     set(handles.edit18,'String',num2str(Data.MedianKernel))
 end
display('File Loaded');
function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double
Data=guidata(hObject);
Data.BThreshold=str2double(get(hObject,'String'));
guidata(hObject,Data);

% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
vdo=Data.Video;
Ig=read(vdo,1000);
Img=Ig(:,:,1);
Ni=zeros(Data.FrameNumber,1);
h66=figure(131);
[I rect]=imcrop(Img);
delete(h66)
for l=1:Data.FrameNumber
    nI=read(vdo,l);
    Ni(l,1)=mean(mean(nI(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),1)));
    h21=waitbar(l/Data.FrameNumber);
end
    delete(h21)
    Data.LED=Ni;
    figure(337)
    plot(Ni)
    title('Mean Intensity of LED for All Frames')
    guidata(hObject,Data);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
FrameRate=Data.Video.FrameRate;
startframe=Data.StartFrame;
endframe=Data.EndFrame;
t=[(startframe-1)/FrameRate:1/FrameRate:(endframe-1)/FrameRate];
tt=[0:1/FrameRate:(Data.FrameNumber-1)/FrameRate];
if ~isfield(Data,'Mean')
    error('Mean Component does not exist')
end
if ~isfield(Data,'LED')
    error('LED Component does not exist')
end
if ~isfield(Data,'BSignal')
    error('Binary Signal Component does not exist')
end
figure(666)
subplot(3,1,1)
plot(t,Data.Mean)
hold on
%plot(1:size(Data.Mean,1),Data.BThreshold,'r')
plot(t,Data.BThreshold,'r')
hold off
title('Mean Intensity Value')
%xlim([startframe/FrameRate endframe/FrameRate])
subplot(3,1,2)
plot(t,Data.BSignal)
title('Binary Signal')
ylim([0 1.5])
%xlim([startframe/FrameRate endframe/FrameRate])
subplot(3,1,3)
plot(tt,Data.LED)

title('LED')
%xlim([1/FrameRate size(Data.Mean,1)/FrameRate])


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
c=clock;
[Spath]=uigetdir;
crp=pwd;
cd(Spath)
 fid=fopen([Data.FileName(1:end-4) '.txt'],'wt');
 fprintf(fid,'%s','Information is Related to Video ');
 fprintf(fid,'%s',Data.FileName );
 fprintf(fid,'\n\n');
 fprintf(fid,'%s','Time & Date [Year , Month , Day , Hour , Min , Sec] ');
 fprintf(fid,'%d',c );
 %**********************************************************************
 if isfield(Data,'MedianKernel')
 fprintf(fid,'%s','Median Kernal Size which applied to Original Image:  ');
 fprintf(fid,'%d',Data.MedianKernel);
 fprintf(fid,'\n\n');
 end
 %*******************************************************************
  if isfield(Data,'MedianKernelRep')
 fprintf(fid,'%s','Median Kernal Repition which applied to Original Image:  ');
 fprintf(fid,'%d',Data.MedianKernelRep);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'RectangleInfo')
 fprintf(fid,'%s','Main Crop Rectangle Information:  ');
 fprintf(fid,'%f %f %f %f ',Data.RectangleInfo);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'HStartFrame')
 fprintf(fid,'%s','Threshold start and End Frame Numbers:  ');
 fprintf(fid,'%d ',Data.HStartFrame);
 fprintf(fid,'%d ',Data.HEndFrame);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'ConfInter')
 fprintf(fid,'%s','Percentage for Confidence Interval:  ');
 fprintf(fid,'%d',Data.ConfInter);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'NoiseLevel')
 fprintf(fid,'%s','Noise Level In sclae of Gray Value (0-255):  ');
 fprintf(fid,'%d',Data.NoiseLevel);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'NThreshold')
 fprintf(fid,'%s','Threshold Value for Reducing Background Noise in Subtracted Images (0-1):  ');
 fprintf(fid,'%f',Data.NThreshold);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'StartFrame')
 fprintf(fid,'%s','start and End Frame Numbers For Analyze:  ');
 fprintf(fid,'%d ',Data.StartFrame);
 fprintf(fid,'%d ',Data.EndFrame);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'BThreshold')
 fprintf(fid,'%s','Threshold Value For calculating Binary Signal From Original Signal:  ');
 fprintf(fid,'%f',Data.BThreshold);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'Video')
 fprintf(fid,'%s','Video Frame Rate:  ');
 fprintf(fid,'%f',Data.Video.FrameRate);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'CalciumLEDThreshold')
 fprintf(fid,'%s','Calcium LED Threshold Level:  ');
 fprintf(fid,'%f',Data.CalciumLEDThreshold);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'CalciumLEDStart')
 fprintf(fid,'%s','Calcium LED Start and End Points:  ');
 fprintf(fid,'%d ',Data.CalciumLEDStart);
 fprintf(fid,'%d ',Data.CalciumLEDEnd);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'VideoLEDStart')
 fprintf(fid,'%s','Video LED Start and End Points:  ');
 fprintf(fid,'%d ',Data.VideoLEDStart);
 fprintf(fid,'%d ',Data.VideoLEDEnd);
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'VideoLEDThreshold')
 fprintf(fid,'%s','Video LED Threshold Level:  ');
 fprintf(fid,'%f',Data.VideoLEDThreshold);
 fprintf(fid,'\n\n');
 end
 
 if isfield(Data,'Mean')
 fprintf(fid,'%s','Original Mean Intensity Signal:  \n');
 for i=1:size(Data.Mean,1)
     fprintf(fid,'%f\n ',Data.Mean(i,1));
 end
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'BSignal')
 fprintf(fid,'%s','Binary Signal:  \n');
 for i=1:size(Data.BSignal,1)
     fprintf(fid,'%d\n ',Data.BSignal(i,1));
 end
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'LED')
 fprintf(fid,'%s','LED Intensity Value:  \n');
 for i=1:size(Data.LED,1)
     fprintf(fid,'%f\n ',Data.LED(i,1));
 end
 fprintf(fid,'\n\n');
 end
 
 if isfield(Data,'OriginalVideoInterpolatedSignal')
 fprintf(fid,'%s','Original Video Interpolated Signal:  \n');
 for i=1:size(Data.OriginalVideoInterpolatedSignal,1)
     fprintf(fid,'%f\n ',Data.OriginalVideoInterpolatedSignal(i,1));
 end
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'OriginalBinaryVideoInterpolatedSignal')
 fprintf(fid,'%s','Original Binary Video Interpolated Signal:  \n');
 for i=1:size(Data.OriginalBinaryVideoInterpolatedSignal,1)
     fprintf(fid,'%f\n ',Data.OriginalBinaryVideoInterpolatedSignal(i,1));
 end
 fprintf(fid,'\n\n');
 end
 if isfield(Data,'VideoLEDInterpolated')
 fprintf(fid,'%s','Video LED Interpolated Signal: \n ');
 for i=1:size(Data.VideoLEDInterpolated,1)
     fprintf(fid,'%f\n ',Data.VideoLEDInterpolated(i,1));
 end
 fprintf(fid,'\n\n');
 end
  if isfield(Data,'CalciumLEDSignal')
 fprintf(fid,'%s','Calcium LED Signal:  \n');
 for i=1:size(Data.CalciumLEDSignal,1)
     fprintf(fid,'%f\n ',Data.CalciumLEDSignal(i,1));
 end
 fprintf(fid,'\n\n');
 end
 
 fclose(fid);
 
 cd(crp);
%**************************************************************************
%**************************************************************************
%*************************** Calcium Image ********************************
%**************************************************************************
%**************************************************************************

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[CFileName,CPathName,FilterIndex] = uigetfile('*.sif;*.SIF;*.Sif;*.mat;*.h5','Pick a file');

Data=guidata(hObject);
Data.CPathName=CPathName;
Data.CFileName=CFileName;
set(handles.edit17,'String',strcat(CPathName,CFileName))
dots = regexp(CFileName,'\.');
format=CFileName(dots(end)+1:end);
if isequal(format,'h5')
h5info=hdf5info([CPathName CFileName]);
% dset = hdf5read(h5info.GroupHierarchy.Groups.Datasets(1));
dset = hdf5read(h5info.GroupHierarchy.Datasets(1));
Data.Calcium=dset;
elseif isequal(format,'mat')
    ldd=load([CPathName CFileName]);
    if isstruct(ldd)
        if fieldnames(ldd)>1
             xx = inputdlg('Enter space-separated numbers:',...
             'Sample', [1 50]);             
            Data.Calcium=getfield(ldd,char(xx));
        else
            Data.Calcium=ldd.fieldnames(ldd);
        end
    end
            
        
else
    absfilepath=strcat(CPathName,CFileName);
 rc=atsif_readfromfile(absfilepath); % attempt to open the file
 if (rc == 22002) % check that the file was successfully opened
  signal=0;
  [rc,present]=atsif_isdatasourcepresent(signal);  % check there is a signal present
  if present
    [rc,no_frames]=atsif_getnumberframes(signal);  % query the number of frames contained in the file (e.g. in the instance of a kinetic series there may be more than 1
    if (no_frames > 0)
        [rc,size]=atsif_getframesize(signal);
        [rc,left,bottom,right,top,hBin,vBin]=atsif_getsubimageinfo(signal,0); % get the dimensions of the frame to open
        xaxis=0;
        for i=1:no_frames
        [rc,data]=atsif_getframe(signal,i-1,size); % retrieve the frame data
        [rc,pattern]=atsif_getpropertyvalue(signal,'ReadPattern');
        if isequal(str2num(pattern),0)
            display('Data is in Signal Form');
        elseif isequal(str2num(pattern),4)
            %display('Data is in Image Form');
            width = ((right - left)+1)/hBin;
            height = ((top-bottom)+1)/vBin;
            newdata(:,:,i)=reshape(data,width,height); % reshape the 1D array to a 2D array for display
            %imagesc(newdata);
            waitbar(i/no_frames);
        end
    end
  end
  end
 end
 Data.Calcium=newdata;
    
end

guidata(hObject,Data);
display('File Loaded')

function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
if ~isfield(Data,'Mean');
    error('Original Signal does NOT Exist');
end
if ~isfield(Data,'BSignal');
    error('Binary Signal does NOt Exist');
end
if ~isfield(Data,'LED');
    error('LED Signal does NOT Exist');
end
if ~isfield(Data,'Calcium');
    error('Calcium Signal does NOT Exist');
end

Cl=Data.Calcium;

Cli=squeeze(mean(mean(Cl,1),2));
CThreshold=(min(Cli)+max(Cli))/2;
BCLED=Cli>CThreshold;
CLEDStart=min(find(BCLED));
CLEDEnd=max(find(BCLED));
TotalCLEDPoints=CLEDEnd-CLEDStart;
OriginalVSignal=Data.Mean;
VideoLED=Data.LED;
VLEDThreshold=(min(VideoLED)+max(VideoLED))/2;
BVLED=VideoLED>VLEDThreshold;
VLEDStart=min(find(BVLED));
VLEDEnd=max(find(BVLED));
if isequal(CLEDEnd,size(Cl,3))
    Exti=.011;
    CEndtime=Exti*size(Cl,3);
    VLEDEnd=floor(CEndtime*Data.Video.FrameRate);
end
TotalVLEDPoints=VLEDEnd-VLEDStart;
interlinspace=linspace(1,TotalVLEDPoints,TotalCLEDPoints);
OrgVInterplotated=zeros(size(Cl,3),1);
OrgVInterplotated(:)=-1;
VLEDInterpolated=zeros(size(Cl,3),1);
VLEDInterpolated(:)=-1;
OrgVInterplotated(CLEDStart:CLEDEnd-1,1)=interp1(OriginalVSignal(VLEDStart:VLEDEnd,1),interlinspace)';
VLEDInterpolated(CLEDStart:CLEDEnd-1,1)=interp1(VideoLED(VLEDStart:VLEDEnd,1),interlinspace);
OrgBVInterpolated=OrgVInterplotated>Data.BThreshold;
%********************************************************************************
Data.CalciumLEDThreshold=CThreshold;
Data.CalciumLEDStart=CLEDStart;
Data.CalciumLEDEnd=CLEDEnd;
Data.TotalCalciumLEDPoints=TotalCLEDPoints;
Data.VideoLEDThreshold=VLEDThreshold;
Data.TotalVideoLEDPoints=TotalVLEDPoints;
Data.OriginalVideoInterpolatedSignal=OrgVInterplotated;
Data.OriginalBinaryVideoInterpolatedSignal=OrgBVInterpolated;
Data.VideoLEDInterpolated=VLEDInterpolated;
Data.VideoLEDStart=VLEDStart;
Data.VideoLEDEnd=VLEDEnd;
Data.CalciumLEDSignal=Cli;
guidata(hObject,Data);

figure(777)
subplot(4,1,1)
plot(OrgVInterplotated)
hold on
%plot(1:size(Data.Mean,1),Data.BThreshold,'r')
plot(1:size(OrgVInterplotated,1),Data.BThreshold,'r')
hold off
title('Interpolated Original Video')
%xlim([startframe/FrameRate endframe/FrameRate])
subplot(4,1,2)
plot(VLEDInterpolated)
title('Video Interpolated LED')

%xlim([startframe/FrameRate endframe/FrameRate])
subplot(4,1,3)
plot(Cli)

title(' Calcium LED')

subplot(4,1,4)
plot(OrgBVInterpolated)
ylim([0 1.5])
title('Interpolated Original Binary Video')


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nFileName,nPathName,FilterIndex] = uigetfile();
cp=pwd;
cd(nPathName)
sv=load(nFileName);
dst=sv.SV;
if isfield(dst,'CalciumLEDSignal')
    display('Data Contains Calcium Images Information');
    figure(888)
    subplot(4,1,1)
    plot(dst.OriginalVideoInterpolatedSignal)
    hold on
    %plot(1:size(Data.Mean,1),Data.BThreshold,'r')
    plot(1:size(dst.OriginalVideoInterpolatedSignal,1),dst.BThreshold,'r')
    hold off
    title('Interpolated Original Video')
    %xlim([startframe/FrameRate endframe/FrameRate])
    subplot(4,1,2)
    plot(dst.VideoLEDInterpolated)
    title('Video Interpolated LED')

    %xlim([startframe/FrameRate endframe/FrameRate])
    subplot(4,1,3)
    plot(dst.CalciumLEDSignal)
    title(' Calcium LED')

    subplot(4,1,4)
    plot(dst.OriginalBinaryVideoInterpolatedSignal)
    ylim([0 1.5])
    title('Interpolated Original Binary Video')
else
    display('Data does NOT Contains Calcium Images Information');
    
    figure(999)
    subplot(3,1,1)
    plot(dst.Mean)
    hold on
    %plot(1:size(Data.Mean,1),Data.BThreshold,'r')
    plot(1:size(dst.Mean,1),dst.BThreshold,'r')
    hold off
    title('Mean Intensity Value')
    %xlim([startframe/FrameRate endframe/FrameRate])
    subplot(3,1,2)
    plot(dst.BSignal)
    title('Binary Signal')
    ylim([0 1.5])
    %xlim([startframe/FrameRate endframe/FrameRate])
    subplot(3,1,3)
    plot(dst.LED)

    title('LED')
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=guidata(hObject);
 if isfield(Data,'RectangleInfo')
 Data.RectangleInfo=[];
 end
 if isfield(Data,'HStartFrame')
 Data.RectangleInfo=[];
 end
 if isfield(Data,'ConfInter')
 Data.ConfInter=[];
 end
 if isfield(Data,'NoiseLevel')
 Data.NoiseLevel=[];
 end
 if isfield(Data,'NThreshold')
 Data.NThreshold=[];
 end
 if isfield(Data,'StartFrame')
 Data.StartFrame=[];
 end
 if isfield(Data,'BThreshold')
 Data.BThreshold=[];
 end
 if isfield(Data,'Video')
 Data.Video=[];
 end
 if isfield(Data,'CalciumLEDThreshold')
 Data.CalciumLEDThreshold=[];
 end
 if isfield(Data,'CalciumLEDStart')
 Data.CalciumLEDStart=[];
 end
 if isfield(Data,'VideoLEDStart')
 Data.VideoLEDStart=[];
 end
 if isfield(Data,'VideoLEDThreshold')
 Data.VideoLEDThreshold=[];
 end
 
 if isfield(Data,'Mean')
 Data.Mean=[];
 end
 if isfield(Data,'BSignal')
 Data.BSignal=[];
 end
 if isfield(Data,'LED')
 Data.LED=[];
 end
 
 if isfield(Data,'OriginalVideoInterpolatedSignal')
 Data.OriginalVideoInterpolatedSignal=[];
 end
 if isfield(Data,'OriginalBinaryVideoInterpolatedSignal')
 Data.OriginalBinaryVideoInterpolatedSignal=[];
 end
 if isfield(Data,'VideoLEDInterpolated')
 Data.VideoLEDInterpolated=[];
 end
  if isfield(Data,'CalciumLEDSignal')
 Data.CalciumLEDSignal=[];
 end
guidata(hObject,Data);

% --- Executes during object deletion, before destroying properties.
function pushbutton1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

chk=get(hObject,'Value');
if isequal(chk,1)
    set(handles.edit18,'enable','on');
    set(handles.edit19,'enable','on');
else
    set(handles.edit18,'enable','off');
    set(handles.edit19,'enable','off');
end

function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double
Data=guidata(hObject);
Data.MedianKernel=str2double(get(hObject,'String'));
guidata(hObject,Data);

% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double
Data=guidata(hObject);
Data.MedianKernelRep=str2double(get(hObject,'String'));
guidata(hObject,Data);


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
