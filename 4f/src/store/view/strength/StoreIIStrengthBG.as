package store.view.strength
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.common.BuyItemButton;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import quest.TaskManager;
   import store.IStoreViewBG;
   import store.ShowSuccessExp;
   import store.StoneCell;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.data.StoreEquipExperience;
   import store.view.ConsortiaRateManager;
   import trainer.controller.NewHandQueue;
   import trainer.controller.WeakGuildManager;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   import vip.VipController;
   
   public class StoreIIStrengthBG extends Sprite implements IStoreViewBG
   {
      
      public static const WEAPONUPGRADESPLAY:String = "weaponUpgradesPlay";
       
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _strength_btn:BaseButton;
      
      private var _strength_btn_shineEffect:IEffect;
      
      private var _strengHelp:BaseButton;
      
      private var _bg:MutipleImage;
      
      private var _gold_txt:FilterFrameText;
      
      private var _pointArray:Vector.<Point>;
      
      private var _strthShine:MovieImage;
      
      private var _startStrthTip:MutipleImage;
      
      private var _consortiaSmith:MySmithLevel;
      
      private var _strengthStoneCellBg1:Bitmap;
      
      private var _strengthStoneText1:FilterFrameText;
      
      private var _strengthenEquipmentCellBg:Image;
      
      private var _strengthenEquipmentCellText:FilterFrameText;
      
      private var _isInjectSelect:SelectedCheckButton;
      
      private var _progressLevel:StoreStrengthProgress;
      
      private var _lastStrengthTime:int = 0;
      
      private var _showSuccessExp:ShowSuccessExp;
      
      private var _starMovie:MovieClip;
      
      private var _weaponUpgrades:MovieClip;
      
      private var _sBuyStrengthStoneCell:BuyItemButton;
      
      private var _strengthEquipmentTxt:Bitmap;
      
      private var _vipDiscountTxt:FilterFrameText;
      
      private var _vipDiscountBg:Image;
      
      private var _vipDiscountIcon:Image;
      
      private var _aler:StrengthSelectNumAlertFrame;
      
      public function StoreIIStrengthBG(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvents() : void{}
      
      private function userGuide() : void{}
      
      private function preClothesTip() : void{}
      
      private function preWeaponTip() : void{}
      
      private function exeWeaponTip() : Boolean{return false;}
      
      private function finWeaponTip() : void{}
      
      private function preStoneTip() : void{}
      
      private function exeStoneTip() : Boolean{return false;}
      
      private function finStoneTip() : void{}
      
      private function disposeUserGuide() : void{}
      
      private function getCellsPoint() : void{}
      
      public function get isAutoStrength() : Boolean{return false;}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      public function get area() : Array{return null;}
      
      private function updateProgress(param1:InventoryItemInfo) : void{}
      
      private function isAdaptToItem(param1:InventoryItemInfo) : Boolean{return false;}
      
      private function isAdaptToStone(param1:InventoryItemInfo) : Boolean{return false;}
      
      private function itemIsAdaptToStone(param1:InventoryItemInfo) : Boolean{return false;}
      
      private function showNumAlert(param1:InventoryItemInfo, param2:int) : void{}
      
      private function sellFunction(param1:int, param2:InventoryItemInfo, param3:int) : void{}
      
      private function notSellFunction() : void{}
      
      public function dragDrop(param1:BagCell) : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
      
      private function showArr() : void{}
      
      private function hideArr() : void{}
      
      public function refreshData(param1:Dictionary) : void{}
      
      public function updateData() : void{}
      
      public function startShine(param1:int) : void{}
      
      public function stopShine() : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      private function __isInjectSelectClick(param1:MouseEvent) : void{}
      
      private function __strengthClick(param1:MouseEvent) : void{}
      
      private function _responseV(param1:FrameEvent) : void{}
      
      private function okFastPurchaseGold() : void{}
      
      private function _bingResponse(param1:FrameEvent) : void{}
      
      private function sendSocket() : void{}
      
      private function checkTipBindType() : Boolean{return false;}
      
      private function checkLevel() : Boolean{return false;}
      
      private function __itemInfoChange(param1:Event) : void{}
      
      private function _showDontClickTip() : Boolean{return false;}
      
      private function getCountExpI() : void{}
      
      public function consortiaRate() : void{}
      
      private function _consortiaLoadComplete(param1:Event) : void{}
      
      public function getStrengthItemCellInfo() : InventoryItemInfo{return null;}
      
      public function starMoviePlay() : void{}
      
      private function __starMovieFrame(param1:Event) : void{}
      
      private function removeStarMovie() : void{}
      
      private function weaponUpgradesPlay(param1:Event) : void{}
      
      private function __weaponUpgradesFrame(param1:Event) : void{}
      
      private function removeWeaponUpgradesMovie() : void{}
      
      public function dispose() : void{}
   }
}
