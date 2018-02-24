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
      
      public function MarkSuitItem(){super();}
      
      override protected function initialize() : void{}
      
      public function set data(param1:MarkBagData) : void{}
      
      private function updateStaus(param1:MarkEvent = null) : void{}
      
      override public function dispose() : void{}
   }
}
