package ddt.command
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ShineObject extends Sprite
   {
       
      
      private var _shiner:MovieClip;
      
      private var _addToBottom:Boolean;
      
      public function ShineObject(param1:MovieClip, param2:Boolean = true)
      {
         _shiner = param1;
         _addToBottom = param2;
         super();
         init();
         initEvents();
      }
      
      private function init() : void
      {
         addChild(_shiner);
         _shiner.stop();
      }
      
      private function initEvents() : void
      {
         addEventListener("addedToStage",__addToStage);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("addedToStage",__addToStage);
      }
      
      private function __addToStage(param1:Event) : void
      {
         if(parent)
         {
            this.scaleX = 1 / parent.scaleX;
            this.scaleY = 1 / parent.scaleY;
            this._shiner.x = (parent.width * parent.scaleX - this._shiner.width) * 0.5;
            this._shiner.y = (parent.height * parent.scaleY - this._shiner.height) * 0.5;
            if(_addToBottom)
            {
               parent.addChildAt(this,0);
            }
         }
      }
      
      public function shine(param1:Boolean = false) : void
      {
         if(_shiner)
         {
            if(!SoundManager.instance.isPlaying("044") && param1)
            {
               SoundManager.instance.play("044",false,true,100);
            }
            _shiner.play();
         }
      }
      
      public function stopShine() : void
      {
         if(_shiner)
         {
            SoundManager.instance.stop("044");
            _shiner.gotoAndStop(1);
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_shiner)
         {
            _shiner.stop();
            ObjectUtils.disposeObject(_shiner);
         }
         _shiner = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
