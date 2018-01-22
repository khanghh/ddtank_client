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
      
      public function set beadInfos(param1:DictionaryData) : void
      {
         var _loc3_:* = null;
         _infos = param1;
         if(_infos == null || _beadItemContainerAll == null)
         {
            return;
         }
         _beadItemContainerAll.removeAllChild();
         var _loc2_:int = 0;
         _itemArray = [];
         var _loc6_:int = 0;
         var _loc5_:* = _infos.list;
         for each(var _loc4_ in _infos.list)
         {
            _loc2_++;
            _loc3_ = new BeadAdvancedItem(_loc2_);
            _loc3_.addEventListener("click",itemClickHandler);
            _loc3_.info = _loc4_;
            _beadItemContainerAll.addChild(_loc3_);
            _itemArray.push(_loc3_);
         }
         _panel.invalidateViewport();
         if(_itemArray.length > 0)
         {
            (_itemArray[0] as BeadAdvancedItem).dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         if(param1.target is BeadAdvancedItem)
         {
            _loc3_ = param1.target as BeadAdvancedItem;
            if(_loc3_.isSelect)
            {
               return;
            }
            var _loc5_:int = 0;
            var _loc4_:* = _itemArray;
            for each(var _loc2_ in _itemArray)
            {
               if(_loc2_.isSelect)
               {
                  _loc2_.isSelect = false;
               }
            }
            _loc3_.isSelect = true;
            this.dispatchEvent(new CEvent("beadSelectChange",_loc3_.info));
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
