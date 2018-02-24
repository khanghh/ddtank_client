package equipretrieve.view
{
   import bagAndInfo.bag.BreakGoodsBtn;
   import bagAndInfo.bag.SellGoodsBtn;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import equipretrieve.RetrieveModel;
   import flash.display.Sprite;
   
   public class RetrieveBagcell extends BagCell
   {
       
      
      public function RetrieveBagcell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Sprite = null){super(null,null,null,null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function get itemBagType() : int{return 0;}
   }
}
