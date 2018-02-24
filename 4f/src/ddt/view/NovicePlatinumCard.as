package ddt.view
{
   import activeEvents.data.ActiveEventsInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.RequestVairableCreater;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.net.URLVariables;
   
   public class NovicePlatinumCard extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _activityCardPSWII:Bitmap;
      
      private var _divisionLine:Bitmap;
      
      private var _iconGive:Bitmap;
      
      private var _textInput:TextInput;
      
      private var _awardTxt:FilterFrameText;
      
      private var _activeGetBtn:TextButton;
      
      private var _activeCloseBtn:TextButton;
      
      private var _activeEventsInfo:ActiveEventsInfo;
      
      public function NovicePlatinumCard(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      protected function __activeSocket(param1:PkgEvent) : void{}
      
      private function __input(param1:TextEvent) : void{}
      
      private function __onChange(param1:Event) : void{}
      
      protected function __textInputKeyDown(param1:KeyboardEvent) : void{}
      
      protected function __activeGetBtnClick(param1:MouseEvent = null) : void{}
      
      public function setup() : void{}
      
      protected function __loadComplete(param1:LoaderEvent) : void{}
      
      protected function __loadError(param1:LoaderEvent) : void{}
      
      public function show() : void{}
      
      protected function __activeCloseBtnClick(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
