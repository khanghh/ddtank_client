package collectionTask.view
{
   import collectionTask.CollectionTaskManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ProgressSprite extends Sprite implements Disposeable
   {
       
      
      private var _progressMc:MovieClip;
      
      private var _currentFrame:int;
      
      private var _completeFunc:Function;
      
      public function ProgressSprite(param1:Function){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      protected function __enterHandler(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
