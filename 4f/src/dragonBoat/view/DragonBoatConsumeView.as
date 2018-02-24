package dragonBoat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class DragonBoatConsumeView extends BaseAlerFrame
   {
       
      
      private var _item:InventoryItemInfo;
      
      private var _itemMax:int;
      
      private var _txt:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _bottomPromptTxt:FilterFrameText;
      
      private var _textWord1:FilterFrameText;
      
      private var _ownMoney:FilterFrameText;
      
      private var _ownMoney2:FilterFrameText;
      
      private var _tag:int;
      
      public function DragonBoatConsumeView(){super();}
      
      private function initView() : void{}
      
      public function setView(param1:int) : void{}
      
      private function highViewSet() : void{}
      
      private function initEvent() : void{}
      
      private function changeMaxHandler(param1:MouseEvent) : void{}
      
      private function inputTextChangeHandler(param1:Event) : void{}
      
      private function responseHandler(param1:FrameEvent) : void{}
      
      private function enterKeyHandler() : void{}
      
      private function inputKeyDownHandler(param1:KeyboardEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
