package equipretrieve.view
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import equipretrieve.RetrieveController;
   import equipretrieve.RetrieveModel;
   import flash.display.Shape;
   
   public class RetrieveBagView extends BagView
   {
       
      
      protected var _equipPanel:ScrollPanel;
      
      protected var _propPanel:ScrollPanel;
      
      public function RetrieveBagView(){super();}
      
      override protected function set_breakBtn_enable() : void{}
      
      override protected function initBackGround() : void{}
      
      override protected function initBagList() : void{}
      
      override protected function initTabButtons() : void{}
      
      override protected function initEvent() : void{}
      
      override public function setBagType(param1:int) : void{}
      
      override protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      override protected function __cellClick(param1:CellEvent) : void{}
      
      private function _stopDrag(param1:CellEvent) : void{}
      
      public function resultPoint(param1:int, param2:Number, param3:Number) : void{}
      
      override public function dispose() : void{}
   }
}
