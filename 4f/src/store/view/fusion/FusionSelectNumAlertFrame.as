package store.view.fusion
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class FusionSelectNumAlertFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _bg:Bitmap;
      
      private var _btn1:BaseButton;
      
      private var _btn2:BaseButton;
      
      private var _inputText:FilterFrameText;
      
      private var _inputBg:Image;
      
      private var _maxNum:int = 0;
      
      private var _minNum:int = 1;
      
      private var _nowNum:int = 1;
      
      public var index:int;
      
      private var _goodsinfo:InventoryItemInfo;
      
      public function FusionSelectNumAlertFrame(){super();}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      public function show(param1:int = 5, param2:int = 1) : void{}
      
      public function upSee() : void{}
      
      private function removeView() : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __addToStageHandler(param1:Event) : void{}
      
      private function _changeInput(param1:Event) : void{}
      
      private function __enterHanlder(param1:KeyboardEvent) : void{}
      
      private function click_btn1(param1:MouseEvent) : void{}
      
      private function click_btn2(param1:MouseEvent) : void{}
      
      private function _upbtView() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      private function __confirm() : void{}
      
      public function get goodsinfo() : InventoryItemInfo{return null;}
      
      public function set goodsinfo(param1:InventoryItemInfo) : void{}
      
      override public function dispose() : void{}
   }
}
