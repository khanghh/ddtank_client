package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.interfaces.ICell;
   import ddt.interfaces.IDragable;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class BreakGoodsBtn extends TextButton implements IDragable
   {
       
      
      private var _dragTarget:BagCell;
      
      private var _enabel:Boolean;
      
      private var win:BreakGoodsView;
      
      private var myColorMatrix_filter:ColorMatrixFilter;
      
      private var lightingFilter:ColorMatrixFilter;
      
      public function BreakGoodsBtn()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         buttonMode = true;
         initEvent();
      }
      
      private function __mouseClick(event:MouseEvent) : void
      {
         if(!PlayerManager.Instance.Self.bagLocked)
         {
            dragStart(event.stageX,event.stageY);
         }
      }
      
      public function dragStart(stageX:Number, stageY:Number) : void
      {
         DragManager.startDrag(this,this,ComponentFactory.Instance.creatBitmap("bagAndInfo.bag.breakIconAsset"),stageX,stageY,"move");
      }
      
      public function dragStop(effect:DragEffect) : void
      {
         var cell:* = null;
         if(effect.action == "move" && effect.target is ICell)
         {
            cell = effect.target as BagCell;
            if(cell)
            {
               if(cell.itemInfo.Count > 1 && cell.itemInfo.BagType != 11 && cell.itemInfo.BagType != 511)
               {
                  _dragTarget = cell;
                  SoundManager.instance.play("008");
                  _dragTarget = cell;
                  SoundManager.instance.play("008");
                  win = ComponentFactory.Instance.creatComponentByStylename("breakGoodsView");
                  win.cell = cell;
                  win.show();
               }
            }
         }
      }
      
      private function breakBack() : void
      {
         if(!_dragTarget)
         {
         }
         if(stage)
         {
            dragStart(stage.mouseX,stage.mouseY);
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
      
      private function removeEvents() : void
      {
         removeEventListener("click",__mouseClick);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__mouseClick);
         addEventListener("addedToStage",__addToStage);
         addEventListener("removedFromStage",__removeFromStage);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_dragTarget)
         {
            _dragTarget.locked = false;
         }
         PlayerManager.Instance.Self.Bag.unLockAll();
         if(win != null)
         {
            win.dispose();
         }
         win = null;
         super.dispose();
      }
      
      private function __addToStage(evt:Event) : void
      {
      }
      
      private function __removeFromStage(evt:Event) : void
      {
      }
      
      private function cancelBack() : void
      {
         if(_dragTarget)
         {
            _dragTarget.locked = false;
         }
      }
   }
}
