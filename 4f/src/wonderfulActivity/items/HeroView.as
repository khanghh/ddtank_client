package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class HeroView extends Sprite implements IRightView
   {
       
      
      private var _back:Bitmap;
      
      private var _activeTimeBit:Bitmap;
      
      private var _activetimeFilter:FilterFrameText;
      
      private var _getButton:SimpleBitmapButton;
      
      private var _cartoonList:Vector.<MovieClip>;
      
      private var _cartoonVisibleArr:Array;
      
      private var _bagCellGrayArr:Array;
      
      private var _bagCellArr:Array;
      
      private var _mcNum:int;
      
      private var _info:SelfInfo;
      
      private var _fightPowerArr:Array;
      
      private var _gradeArr:Array;
      
      private var _numPower:int = 0;
      
      private var _numGrade:int = 0;
      
      private var _activityInfo1:GmActivityInfo;
      
      private var _activityInfo2:GmActivityInfo;
      
      private var _activityInfoArr:Array;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusPowerArr:Array;
      
      private var _statusGradeArr:Array;
      
      public function HeroView(){super();}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function init() : void{}
      
      private function initViewWithData() : void{}
      
      private function checkData() : Boolean{return false;}
      
      private function initView() : void{}
      
      private function createBagCell(param1:int, param2:GiftBagInfo) : BagCell{return null;}
      
      private function initData() : void{}
      
      private function initCartoonPlayArr(param1:Array, param2:Array) : void{}
      
      private function initItem() : void{}
      
      private function __getAward(param1:MouseEvent) : void{}
      
      public function content() : Sprite{return null;}
      
      public function dispose() : void{}
   }
}
