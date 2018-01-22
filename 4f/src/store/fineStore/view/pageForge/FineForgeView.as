package store.fineStore.view.pageForge
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.store.FineSuitVo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.FineSuitManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import road7th.comm.PackageIn;
   import store.fineStore.view.ForgeEffectItem;
   
   public class FineForgeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _movieBg:MutipleImage;
      
      private var _infoBg:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _progress:MovieClip;
      
      private var _progressText:FilterFrameText;
      
      private var _forgeBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _select:SelectedCheckButton;
      
      private var _hBox:HBox;
      
      private var _materialList:Array;
      
      private var _effect:Sprite;
      
      private var _efListSp:Sprite;
      
      private var _scroll:ScrollPanel;
      
      private var _mouseOver:Sprite;
      
      private var _list:Array;
      
      private var _cell:Array;
      
      private var _index:int = 0;
      
      private var _butImage:Bitmap;
      
      private var _effectList:Array;
      
      private var _forgeAction:MovieClip;
      
      private var _cellAction:MovieClip;
      
      private var order:Array;
      
      private var _progressTips:Component;
      
      private var _forgeProgress:int;
      
      private var _timer:int;
      
      public function FineForgeView(){super();}
      
      private function init() : void{}
      
      protected function onMOOut(param1:MouseEvent) : void{}
      
      protected function onMOOver(param1:MouseEvent) : void{}
      
      private function __onCellClick(param1:MouseEvent) : void{}
      
      private function __onCellOver(param1:MouseEvent) : void{}
      
      private function __onCellOut(param1:MouseEvent) : void{}
      
      private function forgeResultAction() : void{}
      
      private function __onProgressAction(param1:Event) : void{}
      
      public function forgeSucceed() : void{}
      
      private function __onEnterForgeAction(param1:Event) : void{}
      
      private function moveComplete() : void{}
      
      private function __onEnterCellAction(param1:Event) : void{}
      
      private function __onClickForgeBtn(param1:MouseEvent) : void{}
      
      private function __onClickCell(param1:MouseEvent) : void{}
      
      private function __onChangeSuitExp(param1:PkgEvent) : void{}
      
      private function __onBagUpdate(param1:BagEvent) : void{}
      
      private function updateInfo() : void{}
      
      private function updateInfoOver() : void{}
      
      private function updateSuitExp() : void{}
      
      private function updateMaterialCount() : void{}
      
      private function updateCellBgView() : void{}
      
      private function updateTipsData() : void{}
      
      private function get currentSelectedCell() : FineForgeCell{return null;}
      
      private function get currentIndex() : int{return 0;}
      
      private function get needForgeCellId() : int{return 0;}
      
      private function setForgeCellInfo(param1:BagCell, param2:int) : void{}
      
      private function get forgeProgress() : int{return 0;}
      
      private function getforgeEffectState(param1:int) : int{return 0;}
      
      private function getTipsDataListView() : Array{return null;}
      
      private function disposeForgeAction() : void{}
      
      private function disposeCellAction() : void{}
      
      private function disposeProgressAction() : void{}
      
      public function dispose() : void{}
   }
}
