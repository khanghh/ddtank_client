package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import road7th.utils.DateUtils;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.event.WonderfulActivityEvent;
   import wonderfulActivity.views.IRightView;
   
   public class DaySupplyAwardItem extends Sprite implements IRightView
   {
       
      
      private var _id:String;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _data:Object;
      
      private var _bg:Bitmap;
      
      private var _coinsText:FilterFrameText;
      
      private var _totalText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _getImage:Bitmap;
      
      private var _hBox:HBox;
      
      public function DaySupplyAwardItem(param1:String = ""){super();}
      
      public function init() : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      private function update() : void{}
      
      public function updateActivityData(param1:WonderfulActivityEvent = null) : void{}
      
      public function dispose() : void{}
      
      public function content() : Sprite{return null;}
      
      public function setState(param1:int, param2:int) : void{}
   }
}
