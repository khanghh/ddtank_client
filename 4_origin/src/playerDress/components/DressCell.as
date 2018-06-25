package playerDress.components
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DressCell extends BagCell
   {
       
      
      public function DressCell(index:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true)
      {
         super(index,info,showLoading);
         _bg.visible = false;
         _picPos = new Point(2,0);
         initEvents();
      }
      
      private function initEvents() : void
      {
         addEventListener("interactive_click",onClick);
         addEventListener("interactive_double_click",onDoubleClick);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("interactive_click",onClick);
         removeEventListener("interactive_double_click",onDoubleClick);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
      }
      
      protected function onClick(evt:InteractiveEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",this));
      }
      
      protected function onDoubleClick(evt:InteractiveEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(info)
         {
            dispatchEvent(new CellEvent("doubleclick",this));
         }
      }
      
      override protected function createLoading() : void
      {
         super.createLoading();
         PositionUtils.setPos(_loadingasset,"ddt.personalInfocell.loadingPos");
      }
      
      override public function dispose() : void
      {
         removeEvents();
         super.dispose();
      }
   }
}
