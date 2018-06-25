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
      
      public function ChickActivationItems()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemsPanel = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.itemsScrollPanel");
         addChild(_itemsPanel);
         _items = new Sprite();
         _itemsPanel.setView(_items);
         _itemsPanel.invalidateViewport();
      }
      
      public function update($arr:Array) : void
      {
         _arrData = $arr;
         updateView();
         _itemsPanel.invalidateViewport();
      }
      
      private function updateView() : void
      {
         var i:int = 0;
         var _cell:* = null;
         ObjectUtils.disposeAllChildren(_items);
         if(_arrData)
         {
            for(i = 0; i < _arrData.length; )
            {
               _cell = createCell(_arrData[i]);
               _cell.x = i % 5 * 105;
               _cell.y = int(i / 5) * 80 + 5;
               _items.addChild(_cell);
               i++;
            }
         }
      }
      
      private function createCell($info:ChickActivationInfo) : BagCell
      {
         var itemInfo:InventoryItemInfo = ChickActivationManager.instance.model.getInventoryItemInfo($info);
         if(itemInfo == null)
         {
            return null;
         }
         var _cell:BagCell = new BagCell(0,itemInfo,true,ComponentFactory.Instance.creatBitmap("assets.chickActivation.itemBg"));
         _cell.width = 64;
         _cell.height = 64.1;
         _cell.setCount(itemInfo.Count);
         return _cell;
      }
      
      public function get arrData() : Array
      {
         return _arrData;
      }
      
      public function dispose() : void
      {
         if(_items)
         {
            ObjectUtils.disposeAllChildren(_items);
            ObjectUtils.disposeObject(_items);
            _items = null;
         }
         ObjectUtils.disposeObject(_itemsPanel);
         _itemsPanel = null;
         _arrData = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
