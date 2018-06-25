package beadSystem.views
{
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class BeadAdvancedListView extends Sprite implements Disposeable
   {
      
      public static const BEAD_SELECT_CHANGE:String = "beadSelectChange";
       
      
      private var _infos:DictionaryData;
      
      private var _panel:ScrollPanel;
      
      private var _beadItemContainerAll:VBox;
      
      private var _itemArray:Array;
      
      public function BeadAdvancedListView()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _panel = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBeadListView.itemlist");
         _beadItemContainerAll = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBeadListView.itemContainerAll");
         _panel.setView(_beadItemContainerAll);
         addChild(_panel);
      }
      
      public function set beadInfos(infos:DictionaryData) : void
      {
         var item:* = null;
         _infos = infos;
         if(_infos == null || _beadItemContainerAll == null)
         {
            return;
         }
         _beadItemContainerAll.removeAllChild();
         var index:int = 0;
         _itemArray = [];
         var _loc6_:int = 0;
         var _loc5_:* = _infos.list;
         for each(var info in _infos.list)
         {
            index++;
            item = new BeadAdvancedItem(index);
            item.addEventListener("click",itemClickHandler);
            item.info = info;
            _beadItemContainerAll.addChild(item);
            _itemArray.push(item);
         }
         _panel.invalidateViewport();
         if(_itemArray.length > 0)
         {
            (_itemArray[0] as BeadAdvancedItem).dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function itemClickHandler(evt:MouseEvent) : void
      {
         var temItem:* = null;
         if(evt.target is BeadAdvancedItem)
         {
            temItem = evt.target as BeadAdvancedItem;
            if(temItem.isSelect)
            {
               return;
            }
            var _loc5_:int = 0;
            var _loc4_:* = _itemArray;
            for each(var item in _itemArray)
            {
               if(item.isSelect)
               {
                  item.isSelect = false;
               }
            }
            temItem.isSelect = true;
            this.dispatchEvent(new CEvent("beadSelectChange",temItem.info));
         }
      }
      
      public function dispose() : void
      {
         _infos = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         _beadItemContainerAll = null;
         if(_itemArray)
         {
            while(_itemArray.length > 0)
            {
               ObjectUtils.disposeObject(_itemArray.shift());
            }
            _itemArray = null;
         }
      }
   }
}
