package farm.viewx.helper
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import ddtBuried.BuriedManager;
   import flash.display.DisplayObject;
   
   public class HelperBeginFrame extends BaseAlerFrame
   {
       
      
      private var _explainText:FilterFrameText;
      
      private var _explainText2:FilterFrameText;
      
      private var _explainText3:FilterFrameText;
      
      private var _bgTitle:DisplayObject;
      
      public var modelType:int;
      
      private var _seedID:int;
      
      private var _seedTime:int;
      
      private var _needCount:int;
      
      private var _haveCount:int;
      
      private var _getCount:int;
      
      private var _needMoney:int;
      
      private var _moneyType:int;
      
      private var _moneyTypeText:String;
      
      private var _ifNeed:Boolean;
      
      private var _isDDTMoney:Boolean = false;
      
      private var _showPayMoneyBG:Image;
      
      private var _selectItem:DoubleSelectedItem;
      
      public function HelperBeginFrame(){super();}
      
      public function show() : void{}
      
      private function intView() : void{}
      
      private function intEvent() : void{}
      
      protected function __framePesponse(param1:FrameEvent) : void{}
      
      private function submit() : void{}
      
      private function __poorManResponse(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function removeView() : void{}
      
      public function get seedID() : int{return 0;}
      
      public function set seedID(param1:int) : void{}
      
      public function get seedTime() : int{return 0;}
      
      public function set seedTime(param1:int) : void{}
      
      public function get needCount() : int{return 0;}
      
      public function set needCount(param1:int) : void{}
      
      public function get haveCount() : int{return 0;}
      
      public function set haveCount(param1:int) : void{}
      
      public function get getCount() : int{return 0;}
      
      public function set getCount(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
