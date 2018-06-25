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
      
      public function ProgressSprite(fun:Function)
      {
         _completeFunc = fun;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _progressMc = ComponentFactory.Instance.creat("asset.collectionTask.progressMc");
         addChild(_progressMc);
         CollectionTaskManager.Instance.isCollecting = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterHandler);
      }
      
      protected function __enterHandler(event:Event) : void
      {
         _currentFrame = Number(_currentFrame) + 1;
         if(_currentFrame >= 117)
         {
            dispose();
            if(_completeFunc != null)
            {
               _completeFunc(CollectionTaskManager.Instance.collectedId);
            }
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterHandler);
      }
      
      public function dispose() : void
      {
         CollectionTaskManager.Instance.isCollecting = false;
         removeEvent();
         ObjectUtils.disposeObject(_progressMc);
         _progressMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
