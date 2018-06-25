package wonderfulActivity.items{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.data.GiftRewardInfo;   import wonderfulActivity.data.GmActivityInfo;   import wonderfulActivity.data.SendGiftInfo;   import wonderfulActivity.views.IRightView;      public class NewGameBenifitView extends Sprite implements IRightView   {                   private var _back:Bitmap;            private var _activeTimeBit:Bitmap;            private var _activetimeFilter:FilterFrameText;            private var _rectangle:Rectangle;            private var _pBar:Bitmap;            private var _progressBar:Bitmap;            private var _progressBarBitmapData:BitmapData;            private var _progressFrame:Bitmap;            private var _progressComplete:Bitmap;            private var _progressTip:NewGameBenifitTipSprite;            private var _progressCompleteNum:int;            private var _progressWidthArr:Array;            private var _itemArr:Array;            private var _itemLightArr:Array;            private var _currentTarget;            private var _awardArr:Array;            private var _activityInfo:GmActivityInfo;            private var _getButton:SimpleBitmapButton;            private var _bagCellDic:Dictionary;            private var _giftInfoDic:Dictionary;            private var _statusArr:Array;            private var _chargeNumArr:Array;            public function NewGameBenifitView() { super(); }
            public function setState(type:int, id:int) : void { }
            public function init() : void { }
            private function initViewWithData() : void { }
            private function checkData() : Boolean { return false; }
            private function initView() : void { }
            private function initData() : void { }
            private function initProgressBar(totalMoney:int) : void { }
            private function __getAward(event:MouseEvent) : void { }
            private function initItem() : void { }
            private function initAward() : void { }
            private function createBagCell(order:int, gift:GiftRewardInfo) : BagCell { return null; }
            private function itemClickHandler(event:MouseEvent) : void { }
            private function setCurrentData(index:int) : void { }
            public function content() : Sprite { return null; }
            public function dispose() : void { }
   }}