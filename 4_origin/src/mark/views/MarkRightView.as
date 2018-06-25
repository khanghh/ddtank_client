package mark.views
{
   import com.pickgliss.utils.ObjectUtils;
   import mark.MarkMgr;
   import mark.data.MarkBagData;
   import mark.event.MarkEvent;
   import mark.items.MarkSuitItem;
   import mark.mornUI.views.MarkRightViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkRightView extends MarkRightViewUI
   {
       
      
      private var _bag:MarkBagView = null;
      
      private var _bagId:int = -1;
      
      public function MarkRightView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         listBags.renderHandler = new Handler(render);
         listBags.selectHandler = new Handler(select);
         initEvent();
         updateChips();
      }
      
      private function render(item:MarkSuitItem, index:int) : void
      {
         item.data = listBags.array[index];
      }
      
      private function select(index:int) : void
      {
         if(!_bag)
         {
            _bag = new MarkBagView();
         }
         var bagData:MarkBagData = listBags.array[index];
         _bag.data = bagData;
         if(listBags.array[index].chips.length > 0)
         {
            _bag.listBag.scrollTo(0);
         }
         _bagId = listBags.array[index].type;
         _bag.visible = true;
         addChild(_bag);
         MarkMgr.inst.reqOperationStatus(0,bagData.type);
      }
      
      private function initEvent() : void
      {
         MarkMgr.inst.addEventListener("remove_view",disposeView);
         MarkMgr.inst.addEventListener("updateChips",updateChips);
         MarkMgr.inst.addEventListener("putOnChip",updateChips);
         MarkMgr.inst.addEventListener("putOffChip",updateChips);
         MarkMgr.inst.addEventListener("updateOperation",updateChips);
      }
      
      private function removeEvent() : void
      {
         MarkMgr.inst.removeEventListener("remove_view",disposeView);
         MarkMgr.inst.removeEventListener("updateChips",updateChips);
         MarkMgr.inst.removeEventListener("putOnChip",updateChips);
         MarkMgr.inst.removeEventListener("putOffChip",updateChips);
         MarkMgr.inst.removeEventListener("updateOperation",updateChips);
      }
      
      private function updateStatus() : void
      {
         var bags:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = MarkMgr.inst.model.bags;
         for each(var bag in MarkMgr.inst.model.bags)
         {
            if(bag.type > 1000)
            {
               bags.push(bag);
            }
         }
         listBags.array = bags;
         if(listBags.array != null && listBags.array.length > 0)
         {
            listBags.repeatY = bags.length;
         }
      }
      
      private function updateChips(evt:MarkEvent = null) : void
      {
         updateStatus();
         if(_bag)
         {
            _bag.data = MarkMgr.inst.model.bags[_bagId];
         }
      }
      
      private function disposeView(evt:MarkEvent) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_bag)
         {
            _bag.dispose();
            _bag = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
