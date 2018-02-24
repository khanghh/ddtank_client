package chickActivation.view
{
   import bagAndInfo.cell.BagCell;
   import chickActivation.ChickActivationManager;
   import chickActivation.data.ChickActivationInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Sprite;
   
   public class ChickActivationItems extends Sprite implements Disposeable
   {
       
      
      private var _arrData:Array;
      
      private var _items:Sprite;
      
      private var _itemsPanel:ScrollPanel;
      
      public function ChickActivationItems(){super();}
      
      private function initView() : void{}
      
      public function update(param1:Array) : void{}
      
      private function updateView() : void{}
      
      private function createCell(param1:ChickActivationInfo) : BagCell{return null;}
      
      public function get arrData() : Array{return null;}
      
      public function dispose() : void{}
   }
}
