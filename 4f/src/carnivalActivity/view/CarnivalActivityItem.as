package carnivalActivity.view
{
   import bagAndInfo.cell.BagCell;
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class CarnivalActivityItem extends Sprite implements Disposeable
   {
       
      
      protected var _bg:Bitmap;
      
      protected var _getBtn:BaseButton;
      
      protected var _giftCurInfo:GiftCurInfo;
      
      protected var _sumCount:int;
      
      protected var _allGiftAlreadyGetCount:int;
      
      protected var _playerAlreadyGetCount:int;
      
      protected var _condtion:int;
      
      protected var _currentCondtion:int;
      
      protected var _goodContent:Sprite;
      
      protected var _descTxt:FilterFrameText;
      
      protected var _awardCountTxt:FilterFrameText;
      
      protected var _type:int;
      
      protected var _info:GiftBagInfo;
      
      protected var _index:int;
      
      protected var _alreadyGetBtn:BaseButton;
      
      protected var _statusArr:Array;
      
      public function CarnivalActivityItem(param1:int, param2:GiftBagInfo, param3:int){super();}
      
      protected function initData() : void{}
      
      protected function initView() : void{}
      
      protected function initItem() : void{}
      
      protected function createBagCell(param1:int, param2:GiftRewardInfo) : BagCell{return null;}
      
      public function updateView() : void{}
      
      protected function initEvent() : void{}
      
      protected function __getAwardHandler(param1:MouseEvent) : void{}
      
      protected function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
