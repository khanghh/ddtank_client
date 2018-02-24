package store.view.fusion
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import quest.TaskManager;
   import store.IStoreViewBG;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.StrengthDataManager;
   import store.data.PreviewInfoII;
   import store.events.StoreIIEvent;
   import store.view.shortcutBuy.ShortcutBuyFrame;
   import trainer.controller.NewHandQueue;
   import trainer.controller.WeakGuildManager;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   
   public class StoreIIFusionBG extends Sprite implements IStoreViewBG
   {
      
      private static const ITEMS:Array = [11301,11302,11303,11304,11201,11202,11203,11204];
      
      private static const ZOMM:Number = 0.75;
      
      public static var lastIndexFusion:int = -1;
       
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _accessoryFrameII:AccessoryFrameII;
      
      private var _fusion_btn:BaseButton;
      
      private var _fusion_btn_shineEffect:IEffect;
      
      private var _fusionHelp:BaseButton;
      
      private var fusionArr:MutipleImage;
      
      private var gold_txt:FilterFrameText;
      
      private var _goldIcon:Image;
      
      private var _goodName:FilterFrameText;
      
      private var _goodRate:FilterFrameText;
      
      private var _autoFusion:Boolean;
      
      private var _autoSelect:Boolean;
      
      private var _autoCheck:SelectedCheckButton;
      
      private var _pointArray:Vector.<Point>;
      
      private var _gold:int = 400;
      
      private var _maxCell:int = 0;
      
      private var _ckAutoSplit:SelectedCheckButton;
      
      private var _isAutoSplit:Boolean = false;
      
      private var _bg:Image;
      
      private var _fusionTitle:Bitmap;
      
      private var _goldTipText:FilterFrameText;
      
      private var _previewPanelBg:Image;
      
      private var _previewNameLabel:FilterFrameText;
      
      private var _previewRateLabel:FilterFrameText;
      
      private var _windowTime:int;
      
      private var _itemsPreview:Array;
      
      private var _alertBand:Boolean = false;
      
      public function StoreIIFusionBG(){super();}
      
      public static function autoSplitSend(param1:int, param2:int, param3:int, param4:String, param5:int, param6:Boolean = false, param7:IStoreViewBG = null) : void{}
      
      public static function getRemainIndexByEmpty(param1:int, param2:IStoreViewBG) : String{return null;}
      
      private static function findDiff(param1:Array) : Array{return null;}
      
      private static function getAutoSplitSendParam(param1:String, param2:int) : Array{return null;}
      
      private static function getRemainCellNumber(param1:int) : int{return 0;}
      
      private static function clearFusion(param1:IStoreViewBG, param2:Array = null) : void{}
      
      public function get isAutoSplit() : Boolean{return false;}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvents() : void{}
      
      private function userGuide() : void{}
      
      private function preItemTip() : void{}
      
      private function exeItemTip() : Boolean{return false;}
      
      private function finItemTip() : void{}
      
      private function disposeUserGuide() : void{}
      
      private function getCellsPoint() : void{}
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void{}
      
      public function dragDrop(param1:BagCell) : void{}
      
      private function __moveGoods(param1:InventoryItemInfo, param2:int) : void{}
      
      private function _alerSell(param1:FusionSelectEvent) : void{}
      
      private function _alerNotSell(param1:FusionSelectEvent) : void{}
      
      private function _showDontClickTip() : Boolean{return false;}
      
      private function showIt() : void{}
      
      public function get area() : Array{return null;}
      
      public function refreshData(param1:Dictionary) : void{}
      
      private function __fusionFinish(param1:Event) : void{}
      
      private function __checkAuto() : void{}
      
      public function updateData() : void{}
      
      public function startShine(param1:int) : void{}
      
      public function stopShine() : void{}
      
      private function showArr() : void{}
      
      private function hideArr() : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      private function __upPreview(param1:PkgEvent) : void{}
      
      private function _showPreview() : void{}
      
      private function _clearPreview() : void{}
      
      private function __accessoryItemClick(param1:StoreIIEvent) : void{}
      
      private function __itemInfoChange(param1:Event) : void{}
      
      private function checkItemEmpty() : int{return 0;}
      
      private function isAllBinds() : int{return 0;}
      
      private function __fusionClick(param1:MouseEvent) : void{}
      
      private function checkfunsion() : void{}
      
      private function _responseV(param1:FrameEvent) : void{}
      
      private function okFastPurchaseGold() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function testingSXJ() : Boolean{return false;}
      
      private function sendFusionRequest() : void{}
      
      private function __previewRequest() : void{}
      
      private function __selectedChanged(param1:Event) : void{}
      
      private function __autoSplit(param1:Event) : void{}
      
      public function set autoSelect(param1:Boolean) : void{}
      
      public function get autoSelect() : Boolean{return false;}
      
      public function set autoFusion(param1:Boolean) : void{}
      
      public function get autoFusion() : Boolean{return false;}
      
      public function dispose() : void{}
   }
}
