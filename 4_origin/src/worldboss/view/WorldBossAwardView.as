package worldboss.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class WorldBossAwardView extends Sprite implements Disposeable
   {
       
      
      private var _leftView:WorldBossAwardOptionLeftView;
      
      private var _rightView:WorldBossAwardOptionRightView;
      
      public function WorldBossAwardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leftView = new WorldBossAwardOptionLeftView();
         addChild(_leftView);
         _rightView = new WorldBossAwardOptionRightView();
         addChild(_rightView);
      }
      
      private function addEvent() : void
      {
         _rightView.addEventListener("close",__gotoBack);
      }
      
      private function __gotoBack(e:Event) : void
      {
         dispose();
      }
      
      public function dispose() : void
      {
         if(_leftView)
         {
            ObjectUtils.disposeObject(_leftView);
         }
         _leftView = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
