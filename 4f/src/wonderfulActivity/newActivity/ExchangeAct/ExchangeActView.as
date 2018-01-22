package wonderfulActivity.newActivity.ExchangeAct
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class ExchangeActView extends Sprite implements IRightView
   {
       
      
      private var _back:DisplayObject;
      
      private var _titleField:FilterFrameText;
      
      private var _buttonBack:DisplayObject;
      
      private var _exchangeButton:BaseButton;
      
      private var _container:Sprite;
      
      private var _actId:String;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _goodsExchange:ExchangeGoodsView;
      
      public function ExchangeActView(param1:String){super();}
      
      public function init() : void{}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      private function initViewWithData() : void{}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function content() : Sprite{return null;}
      
      public function updateAwardState() : void{}
      
      private function addEvent() : void{}
      
      private function __ExchangeGoodsChangeHandler(param1:ExchangeGoodsEvent) : void{}
      
      private function __exchange(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
