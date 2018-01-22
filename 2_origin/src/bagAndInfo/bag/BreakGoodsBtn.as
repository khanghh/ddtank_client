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
      
      private function __mouseClick(param1:MouseEvent) : void
      {
         if(!PlayerManager.Instance.Self.bagLocked)
         {
            dragStart(param1.stageX,param1.stageY);
         }
      }
      
      public function dragStart(param1:Number, param2:Number) : void
      {
         DragManager.startDrag(this,this,ComponentFactory.Instance.creatBitmap("bagAndInfo.bag.breakIconAsset"),param1,param2,"move");
      }
      
      public function dragStop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(param1.action == "move" && param1.target is ICell)
         {
            _loc2_ = param1.target as BagCell;
            if(_loc2_)
            {
               if(_loc2_.itemInfo.Count > 1 && _loc2_.itemInfo.BagType != 11 && _loc2_.itemInfo.BagType != 511)
               {
                  _dragTarget = _loc2_;
                  SoundManager.instance.play("008");
                  _dragTarget = _loc2_;
                  SoundManager.instance.play("008");
                  win = ComponentFactory.Instance.creatComponentByStylename("breakGoodsView");
                  win.cell = _loc2_;
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
      
      private function __addToStage(param1:Event) : void
      {
      }
      
      private function __removeFromStage(param1:Event) : void
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
