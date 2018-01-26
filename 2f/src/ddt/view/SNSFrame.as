package ddt.view
{
   import academy.AcademyManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLVariables;
   
   public class SNSFrame extends BaseAlerFrame
   {
       
      
      private var _inputBG:Bitmap;
      
      private var _SNSFrameBg1:Scale9CornerImage;
      
      private var _shareBtn:TextButton;
      
      private var _visibleBtn:SelectedCheckButton;
      
      private var _text:FilterFrameText;
      
      private var _textinput:FilterFrameText;
      
      private var _alertInfo:AlertInfo;
      
      private var _textInputBgPoint:Point;
      
      private var _inputText:TextArea;
      
      public var typeId:int;
      
      public var backgroundServerTxt:String;
      
      public function SNSFrame(){super();}
      
      private function initView() : void{}
      
      private function _getStr() : String{return null;}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function _clickInputText(param1:MouseEvent) : void{}
      
      private function _clickStage(param1:MouseEvent) : void{}
      
      protected function __shareBtnClick(param1:MouseEvent) : void{}
      
      protected function __visibleBtnClick(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function set receptionistTxt(param1:String) : void{}
      
      public function show() : void{}
      
      private function sendDynamic() : void{}
      
      override public function dispose() : void{}
   }
}
