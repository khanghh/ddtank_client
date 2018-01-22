package ddt.view.qqTips
{
   import calendar.CalendarManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.DesktopManager;
   import ddt.manager.PathManager;
   import ddt.manager.QQtipsManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import times.TimesManager;
   
   public class QQTipsView extends Sprite implements Disposeable
   {
       
      
      private var _qqInfo:QQTipsInfo;
      
      private var _bg:Bitmap;
      
      private var _closeBtn:BaseButton;
      
      private var _titleTxt:FilterFrameText;
      
      private var _outUrlTxt:TextField;
      
      protected var _moveRect:Sprite;
      
      private var _linkBtn:BaseButton;
      
      public function QQTipsView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function remvoeEvents() : void{}
      
      private function __colseClick(param1:MouseEvent) : void{}
      
      private function __CloseView(param1:Event) : void{}
      
      private function __onKeyDown(param1:KeyboardEvent) : void{}
      
      protected function __onFrameMoveStart(param1:MouseEvent) : void{}
      
      protected function __onFrameMoveStop(param1:MouseEvent) : void{}
      
      protected function __onMoveWindow(param1:MouseEvent) : void{}
      
      public function set qqInfo(param1:QQTipsInfo) : void{}
      
      private function __onLinkBtnClicked(param1:MouseEvent) : void{}
      
      private function onIOError(param1:IOErrorEvent) : void{}
      
      private function __playINmoudle() : void{}
      
      private function gotoPage(param1:String) : void{}
      
      public function get qqInfo() : QQTipsInfo{return null;}
      
      public function show() : void{}
      
      public function set moveRect(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
