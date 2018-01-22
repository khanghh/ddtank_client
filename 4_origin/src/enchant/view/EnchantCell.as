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
      
      public function EnchantCell(param1:int, param2:int, param3:ItemTemplateInfo = null, param4:Boolean = true, param5:DisplayObject = null, param6:Boolean = true)
      {
         _type = param1;
         if(_type == 0)
         {
            _itemBagType = 1;
         }
         else if(_type == 1)
         {
            _itemBagType = 0;
         }
         super(param2,param3,param4,param5,param6);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(!info)
         {
            return;
         }
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendMoveGoods(12,_type,_itemBagType,-1);
      }
      
      protected function __clickHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         dragStart();
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
   }
}
