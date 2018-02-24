package latentEnergy
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class LatentEnergyMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _replaceBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      protected var _bagPanel:ScrollPanel;
      
      private var _bagList:LatentEnergyBagListView;
      
      private var _proBagList:LatentEnergyBagListView;
      
      private var _leftDrapSprite:LatentEnergyLeftDragSprite;
      
      private var _rightDrapSprite:LatentEnergyRightDragSprite;
      
      private var _itemPlace:int;
      
      private var _itemCell:LatentEnergyItemCell;
      
      private var _equipCell:LatentEnergyEquipCell;
      
      private var _moreLessIconMcList:Vector.<MovieClip>;
      
      private var _leftProTxtList:Vector.<FilterFrameText>;
      
      private var _rightProTxtList:Vector.<FilterFrameText>;
      
      private var _noProTxt:String;
      
      private var _delayIndex:int;
      
      private var _equipBagInfo:BagInfo;
      
      private var _isDispose:Boolean = false;
      
      public function LatentEnergyMainView(){super();}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function initThis() : void{}
      
      private function initView() : void{}
      
      private function refreshBagList() : void{}
      
      private function createTxtView() : void{}
      
      public function set itemPlace(param1:int) : void{}
      
      private function createAcceptDragSprite() : void{}
      
      private function initEvent() : void{}
      
      private function bagInfoChangeHandler(param1:BagEvent) : void{}
      
      private function equipInfoChangeHandler(param1:Event) : void{}
      
      private function propInfoChangeHandler(param1:BagEvent) : void{}
      
      private function openHandler(param1:MouseEvent) : void{}
      
      private function doOpenHandler() : void{}
      
      private function __confirm(param1:FrameEvent) : void{}
      
      private function openBtnEnableHandler() : void{}
      
      private function replaceHandler(param1:MouseEvent) : void{}
      
      private function itemChangeHandler(param1:Event) : void{}
      
      private function equipChangeHandler(param1:Event) : void{}
      
      private function refreshCurProView() : void{}
      
      private function refreshNewProView() : void{}
      
      protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      private function cellClickHandler(param1:CellEvent) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      public function clearCellInfo() : void{}
      
      public function refreshListData() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
