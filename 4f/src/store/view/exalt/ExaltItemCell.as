package store.view.exalt
{
   import bagAndInfo.cell.CellContentCreator;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.events.Event;
   import store.view.strength.StreangthItemCell;
   
   public class ExaltItemCell extends StreangthItemCell
   {
       
      
      public function ExaltItemCell(param1:int){super(null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function isAdaptToStone(param1:InventoryItemInfo) : Boolean{return false;}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
   }
}
