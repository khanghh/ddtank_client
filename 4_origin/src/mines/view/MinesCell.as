package mines.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class MinesCell extends BagCell
   {
       
      
      protected var _index:int;
      
      public var DoubleClickEnabled:Boolean = true;
      
      public var mouseSilenced:Boolean = false;
      
      public function MinesCell(param1:Sprite, param2:int)
      {
         super(0,null,false,param1);
         _index = param2;
         if(_cellMouseOverBg)
         {
            ObjectUtils.disposeObject(_cellMouseOverBg);
         }
         _cellMouseOverBg = null;
         tipDirctions = "7,5,2,6,4,1";
         PicPos = new Point(-77,-77);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(!DoubleClickEnabled)
         {
            return;
         }
         if(info == null)
         {
            return;
         }
         (param1.currentTarget as BagCell).info = null;
      }
      
      public function get itemBagType() : int
      {
         return 52;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
