package petsBag.view.item
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.BagInfo;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import farm.viewx.FarmFieldBlock;
   import flash.events.MouseEvent;
   import petsBag.cmd.CmdShowPetFoodNumberSelectFrame;
   import petsBag.view.PetFoodNumberSelectFrame;
   
   public class FeedItem extends BaseCell
   {
       
      
      protected var _tbxCount:FilterFrameText;
      
      private var _shiner:ShineObject;
      
      public function FeedItem(){super(null,null,null);}
      
      private function initView() : void{}
      
      public function startShine() : void{}
      
      public function stopShine() : void{}
      
      public function updateCount() : void{}
      
      override protected function initEvent() : void{}
      
      private function __updateStoreBag(param1:BagEvent) : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      override protected function removeEvent() : void{}
      
      public function get itemInfo() : InventoryItemInfo{return null;}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function needMaxFood(param1:int, param2:int) : int{return 0;}
      
      protected function __onFoodAmountResponse(param1:FrameEvent) : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      override public function dispose() : void{}
   }
}
