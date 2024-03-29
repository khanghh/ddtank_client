package store.view.embed
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.controls.BeadAdvanceCell;
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import beadSystem.tips.BeadUpgradeTip;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getQualifiedClassName;
   
   public class EmbedUpLevelCell extends BaseCell
   {
       
      
      private var _shiner:ShineObject;
      
      private var _beadPic:MovieClip;
      
      private var _dragBeadPic:MovieClip;
      
      private var _invenItemInfo:InventoryItemInfo;
      
      private var _nameTxt:FilterFrameText;
      
      private var _lockIcon:Bitmap;
      
      private var _upTip:BeadUpgradeTip;
      
      private var _previewArray:Bitmap;
      
      private var _upgradeMC:MovieClip;
      
      private var _max:int = 21;
      
      private var _itemInfo:InventoryItemInfo;
      
      public function EmbedUpLevelCell(){super(null);}
      
      private function __startPlay(param1:Event) : void{}
      
      private function __onUpgradeComplete(param1:Event) : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      public function set itemInfo(param1:InventoryItemInfo) : void{}
      
      public function get itemInfo() : InventoryItemInfo{return null;}
      
      private function createBeadPic(param1:ItemTemplateInfo) : void{}
      
      private function disposeBeadPic() : void{}
      
      private function disposeDragBeadPic() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function dragStart() : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      override protected function updateSize(param1:Sprite) : void{}
      
      public function get invenItemInfo() : InventoryItemInfo{return null;}
      
      public function set invenItemInfo(param1:InventoryItemInfo) : void{}
      
      private function dragHidePicTxt() : void{}
      
      private function dragShowPicTxt() : void{}
      
      override public function dispose() : void{}
   }
}
