package store.view.embed
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.ShortcutBuyEvent;
   import ddt.events.StoreEmbedEvent;
   import ddt.manager.DragManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import store.IStoreViewBG;
   import store.StoneCell;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.data.StoreModel;
   import store.events.EmbedBackoutEvent;
   import store.events.EmbedEvent;
   import store.events.StoreIIEvent;
   
   public class StoreEmbedBG extends Sprite implements IStoreViewBG
   {
      
      public static const EMBED_MONEY:Number = 2000;
      
      public static const EMBED_BACKOUT_MONEY:Number = 500;
      
      public static const FIVE:int = 5;
      
      public static const SIX:int = 6;
      
      public static const NEED_GOLD:int = 2000;
       
      
      private var _items:Array;
      
      private var _area:StoreDragInArea;
      
      private var _stoneCells:Vector.<EmbedStoneCell>;
      
      private var _embedItemCell:EmbedItemCell;
      
      private var _quick:QuickBuyFrame;
      
      private var _embedBackoutDownItem:TextButton;
      
      private var _openFiveHoleBtn:MultipleButton;
      
      private var _openSixHoleBtn:MultipleButton;
      
      private var _embedStoneCell:EmbedStoneCell;
      
      private var _embedBackoutMouseIcon:ScaleFrameImage;
      
      private var _help:BaseButton;
      
      private var _embedBackoutBtn:EmbedBackoutButton;
      
      private var _bg:Image;
      
      private var _equipmentCellText:FilterFrameText;
      
      private var _currentHolePlace:int;
      
      private var _templateID:int;
      
      private var _pointArray:Vector.<Point>;
      
      private var _drill:InventoryItemInfo;
      
      private var _embedTxt:Bitmap;
      
      private var _hole5ExpBar:HoleExpBar;
      
      private var _hole6ExpBar:HoleExpBar;
      
      private var _stoneInfo:InventoryItemInfo;
      
      private var _openHoleNumber:int = 0;
      
      private var _drillPlace:int = 0;
      
      private var _itemPlace:int = 0;
      
      private var _drillID:int;
      
      private var _isEmbedBreak:Boolean = false;
      
      public function StoreEmbedBG(){super();}
      
      public function holeLvUp(param1:int) : void{}
      
      private function init() : void{}
      
      private function initEvents() : void{}
      
      private function __itemChange(param1:StoreEmbedEvent) : void{}
      
      private function getCellsPoint() : void{}
      
      private function __embedBackoutBtnClick(param1:MouseEvent) : void{}
      
      private function __itemInfoChange(param1:Event) : void{}
      
      private function initHoleType() : void{}
      
      private function updateHoles() : void{}
      
      private function updateOpenFiveSixHole() : void{}
      
      private function confirmIsBindWhenOpenHole() : void{}
      
      private function __confireIsBindWhenOpenHoleResponse(param1:FrameEvent) : void{}
      
      private function getDrillByLevel(param1:int) : InventoryItemInfo{return null;}
      
      private function _openFiveHoleClick(param1:MouseEvent) : void{}
      
      private function _openSixHoleClick(param1:MouseEvent) : void{}
      
      public function openHoleSucces(param1:int, param2:int, param3:int) : void{}
      
      private function _showAlert() : void{}
      
      private function sendOpenHole(param1:int, param2:int, param3:int) : void{}
      
      private function getOpenHoleStone() : InventoryItemInfo{return null;}
      
      private function _responseVI(param1:FrameEvent) : void{}
      
      public function dragDrop(param1:BagCell) : void{}
      
      private function __embed(param1:EmbedEvent) : void{}
      
      private function _responseIII(param1:FrameEvent) : void{}
      
      private function cancelEmbed1() : void{}
      
      private function __embed2() : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
      
      private function __EmbedBackout(param1:EmbedBackoutEvent) : void{}
      
      private function __EmbedBackoutFrame(param1:Event) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function __EmbedBackoutDownItemOver(param1:EmbedBackoutEvent) : void{}
      
      private function __EmbedShowTip(param1:MouseEvent) : void{}
      
      private function __EmbedBackoutDownItemDown(param1:EmbedBackoutEvent) : void{}
      
      private function __EmbedBackoutDownItemOut(param1:EmbedBackoutEvent) : void{}
      
      private function __EmbedBackoutDownItemOutGo(param1:Event) : void{}
      
      public function refreshData(param1:Dictionary) : void{}
      
      public function sendEmbed() : void{}
      
      private function _responseV(param1:FrameEvent) : void{}
      
      private function okFastPurchaseGold() : void{}
      
      private function cancelQuickBuy() : void{}
      
      private function removeFromStageHandler(param1:Event) : void{}
      
      private function __shortCutBuyHandler(param1:ShortcutBuyEvent) : void{}
      
      private function __shortCutBuyMoneyOkHandler(param1:ShortcutBuyEvent) : void{}
      
      private function __shortCutBuyMoneyCancelHandler(param1:ShortcutBuyEvent) : void{}
      
      private function cancelFastPurchaseGold() : void{}
      
      public function sendEmbedBackout() : void{}
      
      private function _responseIV(param1:FrameEvent) : void{}
      
      private function cancelEmbedBackout() : void{}
      
      private function removeEvents() : void{}
      
      public function updateData() : void{}
      
      public function get area() : Array{return null;}
      
      public function startShine() : void{}
      
      public function stoneStartShine(param1:int, param2:InventoryItemInfo) : void{}
      
      public function stopShine() : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      public function dispose() : void{}
   }
}
