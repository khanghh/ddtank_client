package campbattle.view
{
   import campbattle.CampBattleControl;
   import campbattle.event.MapEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ClickDoor extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      public function ClickDoor()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creat("camp.campBattle.Clickdoor");
         _mc.stop();
         addChild(_mc);
         addEventListener("click",clickHander);
         if(CampBattleControl.instance.model.doorIsOpen)
         {
            _mc.gotoAndStop(2);
            _mc.mouseChildren = false;
            _mc.buttonMode = true;
         }
      }
      
      public function doorStatus() : void
      {
         _mc.gotoAndStop(2);
         _mc.mouseChildren = false;
         _mc.buttonMode = true;
      }
      
      private function clickHander(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.playButtonSound();
         CampBattleControl.instance.dispatchEvent(new MapEvent("to_other_map",[x + _mc.width / 2,y + _mc.height * 3 / 4]));
      }
      
      public function dispose() : void
      {
         removeEventListener("click",clickHander);
         if(_mc)
         {
            _mc.stop();
            while(_mc.numChildren)
            {
               ObjectUtils.disposeObject(_mc.getChildAt(0));
            }
         }
         ObjectUtils.disposeObject(_mc);
         _mc = null;
      }
   }
}
