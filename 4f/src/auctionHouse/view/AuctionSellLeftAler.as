package auctionHouse.view
{
   import auctionHouse.event.AuctionSellEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AuctionSellLeftAler extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _btn1:BaseButton;
      
      private var _btn2:BaseButton;
      
      private var _inputText:FilterFrameText;
      
      private var _SellText:FilterFrameText;
      
      private var _SellText1:FilterFrameText;
      
      private var _maxNum:int = 0;
      
      private var _minNum:int = 1;
      
      private var _nowNum:int = 1;
      
      private var _sellInputBg:Scale9CornerImage;
      
      public function AuctionSellLeftAler(){super();}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      public function show(param1:int = 5, param2:int = 1) : void{}
      
      public function upSee() : void{}
      
      private function removeView() : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function _changeInput(param1:Event) : void{}
      
      private function click_btn1(param1:MouseEvent) : void{}
      
      private function click_btn2(param1:MouseEvent) : void{}
      
      private function _upbtView() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
