package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class PetsAwakenInfoCell extends Sprite implements Disposeable
   {
       
      
      private var _equipCell:PetsAwakenEquipCell;
      
      private var _awakenSucessMovie:MovieClip;
      
      private var _bg:Bitmap;
      
      public function PetsAwakenInfoCell(){super();}
      
      private function initView() : void{}
      
      public function set iteminfo(param1:InventoryItemInfo) : void{}
      
      public function get cellInfo() : InventoryItemInfo{return null;}
      
      public function dispose() : void{}
   }
}
