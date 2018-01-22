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
         this._box = new Box();
         this._mask = new Box();
         this._maskBg = new Sprite();
         super();
         addChild(this._box);
         this._mask.addChild(this._maskBg);
         this._maskBg.addChild(ObjectUtils.createBitmap(10,10,0,0.4));
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize(null);
      }
      
      private function onResize(param1:Event) : void
      {
         var _loc3_:Dialog = null;
         var _loc4_:Bitmap = null;
         this._box.width = this._mask.width = stage.stageWidth;
         this._box.height = this._mask.height = stage.stageHeight;
         var _loc2_:int = this._box.numChildren - 1;
         while(_loc2_ > -1)
         {
            _loc3_ = this._box.getChildAt(_loc2_) as Dialog;
            if(_loc3_.popupCenter)
            {
               _loc3_.x = (stage.stageWidth - _loc3_.width) * 0.5;
               _loc3_.y = (stage.stageHeight - _loc3_.height) * 0.5;
            }
            _loc2_--;
         }
         _loc2_ = this._mask.numChildren - 1;
         while(_loc2_ > -1)
         {
            _loc3_ = this._mask.getChildAt(_loc2_) as Dialog;
            if(_loc3_)
            {
               if(_loc3_.popupCenter)
               {
                  _loc3_.x = (stage.stageWidth - _loc3_.width) * 0.5;
                  _loc3_.y = (stage.stageHeight - _loc3_.height) * 0.5;
               }
            }
            else
            {
               _loc4_ = this._maskBg.getChildAt(0) as Bitmap;
               _loc4_.width = stage.stageWidth;
               _loc4_.height = stage.stageHeight;
            }
            _loc2_--;
         }
      }
      
      public function show(param1:Dialog, param2:Boolean = false) : void
      {
         if(param2)
         {
            this._box.removeAllChild();
         }
         if(param1.popupCenter)
         {
            param1.x = (stage.stageWidth - param1.width) * 0.5;
            param1.y = (stage.stageHeight - param1.height) * 0.5;
         }
         this._box.addChild(param1);
      }
      
      public function popup(param1:Dialog, param2:Boolean = false) : void
      {
         if(param2)
         {
            this._mask.removeAllChild(this._maskBg);
         }
         if(param1.popupCenter)
         {
            param1.x = (stage.stageWidth - param1.width) * 0.5;
            param1.y = (stage.stageHeight - param1.height) * 0.5;
         }
         this._mask.addChild(param1);
         this._mask.swapChildrenAt(this._mask.getChildIndex(this._maskBg),this._mask.numChildren - 2);
         addChild(this._mask);
      }
      
      public function close(param1:Dialog) : void
      {
         param1.remove();
         if(this._mask.numChildren > 1)
         {
            this._mask.swapChildrenAt(this._mask.getChildIndex(this._maskBg),this._mask.numChildren - 2);
         }
         else
         {
            this._mask.remove();
         }
      }
      
      public function closeAll() : void
      {
         this._box.removeAllChild();
         this._mask.removeAllChild(this._maskBg);
         this._mask.remove();
      }
   }
}
