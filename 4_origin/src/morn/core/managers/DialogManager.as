package morn.core.managers
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import morn.core.components.Box;
   import morn.core.components.Dialog;
   import morn.core.utils.ObjectUtils;
   
   public class DialogManager extends Sprite
   {
       
      
      private var _box:Box;
      
      private var _mask:Box;
      
      private var _maskBg:Sprite;
      
      public function DialogManager()
      {
         _box = new Box();
         _mask = new Box();
         _maskBg = new Sprite();
         super();
         addChild(_box);
         _mask.addChild(_maskBg);
         _maskBg.addChild(ObjectUtils.createBitmap(10,10,0,0.4));
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(e:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         stage.addEventListener("resize",onResize);
         onResize(null);
      }
      
      private function onResize(e:Event) : void
      {
         var i:int = 0;
         var item:* = null;
         var bitmap:* = null;
         var _loc5_:* = stage.stageWidth;
         _mask.width = _loc5_;
         _box.width = _loc5_;
         _loc5_ = stage.stageHeight;
         _mask.height = _loc5_;
         _box.height = _loc5_;
         for(i = _box.numChildren - 1; i > -1; )
         {
            item = _box.getChildAt(i) as Dialog;
            if(item.popupCenter)
            {
               item.x = (stage.stageWidth - item.width) * 0.5;
               item.y = (stage.stageHeight - item.height) * 0.5;
            }
            i--;
         }
         for(i = _mask.numChildren - 1; i > -1; )
         {
            item = _mask.getChildAt(i) as Dialog;
            if(item)
            {
               if(item.popupCenter)
               {
                  item.x = (stage.stageWidth - item.width) * 0.5;
                  item.y = (stage.stageHeight - item.height) * 0.5;
               }
            }
            else
            {
               bitmap = _maskBg.getChildAt(0) as Bitmap;
               bitmap.width = stage.stageWidth;
               bitmap.height = stage.stageHeight;
            }
            i--;
         }
      }
      
      public function show(dialog:Dialog, closeOther:Boolean = false) : void
      {
         if(closeOther)
         {
            _box.removeAllChild();
         }
         if(dialog.popupCenter)
         {
            dialog.x = (stage.stageWidth - dialog.width) * 0.5;
            dialog.y = (stage.stageHeight - dialog.height) * 0.5;
         }
         _box.addChild(dialog);
      }
      
      public function popup(dialog:Dialog, closeOther:Boolean = false) : void
      {
         if(closeOther)
         {
            _mask.removeAllChild(_maskBg);
         }
         if(dialog.popupCenter)
         {
            dialog.x = (stage.stageWidth - dialog.width) * 0.5;
            dialog.y = (stage.stageHeight - dialog.height) * 0.5;
         }
         _mask.addChild(dialog);
         _mask.swapChildrenAt(_mask.getChildIndex(_maskBg),_mask.numChildren - 2);
         addChild(_mask);
      }
      
      public function close(dialog:Dialog) : void
      {
         dialog.remove();
         if(_mask.numChildren > 1)
         {
            _mask.swapChildrenAt(_mask.getChildIndex(_maskBg),_mask.numChildren - 2);
         }
         else
         {
            _mask.remove();
         }
      }
      
      public function closeAll() : void
      {
         _box.removeAllChild();
         _mask.removeAllChild(_maskBg);
         _mask.remove();
      }
   }
}
