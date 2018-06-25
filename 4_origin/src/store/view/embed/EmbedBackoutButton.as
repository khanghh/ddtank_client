package store.view.embed
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.interfaces.IDragable;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class EmbedBackoutButton extends TextButton implements IDragable
   {
       
      
      private var _enabel:Boolean;
      
      private var _dragTarget:EmbedStoneCell;
      
      private var myColorMatrix_filter:ColorMatrixFilter;
      
      private var lightingFilter:ColorMatrixFilter;
      
      public var isAction:Boolean;
      
      public function EmbedBackoutButton()
      {
         super();
         init();
      }
      
      override protected function init() : void
      {
         super.init();
         buttonMode = true;
         addBackoutBtnEvent();
         myColorMatrix_filter = ComponentFactory.Instance.creatFilters("ddtstore.StoreEmbedBG.MyColorFilter")[0];
         lightingFilter = ComponentFactory.Instance.creatFilters("ddtstore.StoreEmbedBG.LightFilter")[0];
      }
      
      private function __mouseOver(evt:MouseEvent) : void
      {
         this.filters = [lightingFilter];
      }
      
      private function __mouseOut(evt:MouseEvent) : void
      {
         this.filters = null;
      }
      
      public function dragStop(effect:DragEffect) : void
      {
         this.mouseEnabled = true;
         this.isAction = false;
      }
      
      override public function set enable(b:Boolean) : void
      {
         .super.enable = b;
         buttonMode = b;
         if(b)
         {
            addBackoutBtnEvent();
            this.filters = null;
         }
         else
         {
            removeBackoutBtnEvent();
            this.filters = [myColorMatrix_filter];
         }
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function getDragData() : Object
      {
         return this;
      }
      
      private function removeBackoutBtnEvent() : void
      {
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
      
      private function addBackoutBtnEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeBackoutBtnEvent();
         if(_dragTarget)
         {
            ObjectUtils.disposeObject(_dragTarget);
         }
         _dragTarget = null;
         lightingFilter = null;
         myColorMatrix_filter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
