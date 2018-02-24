package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class JoinIsPowerView extends Sprite implements IRightView
   {
       
      
      private var _back:Bitmap;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _getButton:SimpleBitmapButton;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusArr:Array;
      
      private var _giftCondition:int;
      
      private var _giftNeedMinId:String;
      
      private var _hbox:HBox;
      
      public function JoinIsPowerView(){super();}
      
      public function init() : void{}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function content() : Sprite{return null;}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      private function initViewWithData() : void{}
      
      private function createBagCell(param1:int, param2:GiftRewardInfo) : BagCell{return null;}
      
      public function updateAwardState() : void{}
      
      private function changeBtnState() : void{}
      
      protected function __getAwardHandler(param1:MouseEvent) : void{}
      
      public function setData(param1:* = null) : void{}
      
      public function dispose() : void{}
   }
}
