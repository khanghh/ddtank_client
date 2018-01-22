package store.view.strength
{
   import bagAndInfo.cell.CellContentCreator;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import store.StoreCell;
   
   public class StreangthItemCell extends StoreCell
   {
       
      
      protected var _stoneType:String = "";
      
      protected var _actionState:Boolean;
      
      public function StreangthItemCell(param1:int){super(null,null);}
      
      public function set stoneType(param1:String) : void{}
      
      public function set actionState(param1:Boolean) : void{}
      
      public function get actionState() : Boolean{return false;}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      protected function isAdaptToStone(param1:InventoryItemInfo) : Boolean{return false;}
      
      protected function reset() : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override public function dispose() : void{}
   }
}
