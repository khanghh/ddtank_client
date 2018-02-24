package enchant.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class EnchantCell extends BagCell
   {
       
      
      private var _type:int;
      
      private var _itemBagType:int;
      
      public function EnchantCell(param1:int, param2:int, param3:ItemTemplateInfo = null, param4:Boolean = true, param5:DisplayObject = null, param6:Boolean = true){super(null,null,null,null,null);}
      
      override protected function initEvent() : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      protected function __clickHandler(param1:Event) : void{}
      
      override protected function removeEvent() : void{}
   }
}
