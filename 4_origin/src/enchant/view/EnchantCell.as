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
      
      public function EnchantCell(type:int, index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         _type = type;
         if(_type == 0)
         {
            _itemBagType = 1;
         }
         else if(_type == 1)
         {
            _itemBagType = 0;
         }
         super(index,info,showLoading,bg,mouseOverEffBoolean);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!info)
         {
            return;
         }
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendMoveGoods(12,_type,_itemBagType,0);
      }
      
      protected function __clickHandler(event:Event) : void
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
