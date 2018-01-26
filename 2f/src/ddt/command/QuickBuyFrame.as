package ddt.command
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class QuickBuyFrame extends Frame
   {
       
      
      public var canDispose:Boolean;
      
      protected var _view:QuickBuyFrameView;
      
      protected var _shopItemInfo:ShopItemInfo;
      
      protected var _submitButton:TextButton;
      
      protected var _unitPrice:Number;
      
      protected var _buyFrom:int;
      
      protected var _recordLastBuyCount:Boolean;
      
      private var _flag:Boolean;
      
      public function QuickBuyFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvnets() : void{}
      
      private function _numberClose(param1:Event) : void{}
      
      private function _numberEnter(param1:Event) : void{}
      
      public function setTitleText(param1:String) : void{}
      
      public function hideSelectedBand() : void{}
      
      public function set itemID(param1:int) : void{}
      
      public function setIsStoneExploreView(param1:Boolean) : void{}
      
      public function setItemID(param1:int, param2:int, param3:int = 1) : void{}
      
      public function set stoneNumber(param1:int) : void{}
      
      public function set maxLimit(param1:int) : void{}
      
      protected function perPrice() : void{}
      
      public function set recordLastBuyCount(param1:Boolean) : void{}
      
      protected function doPay(param1:Event) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      private function doMoney() : void{}
      
      private function cancelMoney() : void{}
      
      public function set buyFrom(param1:int) : void{}
      
      public function get buyFrom() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
