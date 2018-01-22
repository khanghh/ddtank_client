package store.godRefining.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.BuyItemButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import store.StoreCell;
   
   public class GodRefiningFineQuenchView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _cellBg:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _cBuyluckyBtn:BuyItemButton;
      
      private var _successTipText:FilterFrameText;
      
      private var _successNumText:FilterFrameText;
      
      private var _tipText:FilterFrameText;
      
      private var _needNumText:FilterFrameText;
      
      private var _startFineQuenchBtn:BaseButton;
      
      private var _items:Vector.<StoreCell>;
      
      public function GodRefiningFineQuenchView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function updateView() : void{}
      
      public function refreshData(param1:Dictionary) : void{}
      
      public function quitStartDrag(param1:CEvent) : void{}
      
      private function getCurCellIndex(param1:ItemTemplateInfo) : int{return 0;}
      
      private function getAllCurCellIndex(param1:ItemTemplateInfo) : Array{return null;}
      
      public function quitStopDrag(param1:CEvent) : void{}
      
      public function startShine(param1:int) : void{}
      
      public function stopShine() : void{}
      
      private function __startFineQuenchBtnHandler(param1:MouseEvent) : void{}
      
      public function equipDoubleClickMove(param1:CEvent) : void{}
      
      public function propDoubleClickMove(param1:CEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
