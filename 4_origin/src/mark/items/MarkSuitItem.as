package mark.items
{
   import com.pickgliss.utils.ObjectUtils;
   import mark.MarkMgr;
   import mark.data.MarkBagData;
   import mark.event.MarkEvent;
   import mark.mornUI.items.MarkSuitItemUI;
   
   public class MarkSuitItem extends MarkSuitItemUI
   {
       
      
      private var _data:MarkBagData = null;
      
      public function MarkSuitItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         MarkMgr.inst.addEventListener("updateOperation",updateStaus);
      }
      
      public function set data(value:MarkBagData) : void
      {
         _data = value;
         clipSuit.index = _data.type % 1000 - 1;
         updateStaus();
      }
      
      private function updateStaus(event:MarkEvent = null) : void
      {
         if(!_data)
         {
            return;
         }
         if(MarkMgr.inst.model.newSuits.indexOf(_data.type) > -1)
         {
            btnBubble.visible = false;
            imgNew.visible = true;
         }
         else
         {
            btnBubble.visible = _data.chipCnt > 0;
            btnBubble.label = _data.chipCnt.toString();
            imgNew.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _data = null;
         MarkMgr.inst.removeEventListener("updateOperation",updateStaus);
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
