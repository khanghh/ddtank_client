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
   
   public class CampStatueBtn extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      public var _arrowMc:MovieClip;
      
      public function CampStatueBtn()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creat("camp.campBattle.ClickItem");
         _mc.buttonMode = true;
         _mc.stop();
         addChild(_mc);
         _arrowMc = _mc.arrowmc;
         _mc.addEventListener("click",clickHander);
         _mc.addEventListener("mouseOver",mouseOverHander);
         _mc.addEventListener("mouseOut",mouseOutHander);
      }
      
      private function mouseOutHander(event:MouseEvent) : void
      {
         _mc.gotoAndStop(1);
      }
      
      private function mouseOverHander(event:MouseEvent) : void
      {
         _mc.gotoAndStop(2);
      }
      
      private function clickHander(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         SoundManager.instance.playButtonSound();
         if(!CampBattleControl.instance.model.isCapture)
         {
            CampBattleControl.instance.dispatchEvent(new MapEvent("capture_statue",[1469,1000]));
         }
         else
         {
            CampBattleControl.instance.dispatchEvent(new MapEvent("statue_goto_fight",[1469,1000]));
         }
      }
      
      public function dispose() : void
      {
         if(_mc)
         {
            _mc.removeEventListener("click",clickHander);
            _mc.removeEventListener("mouseOver",mouseOverHander);
            _mc.removeEventListener("mouseOut",mouseOutHander);
            _mc.stop();
            while(_mc.numChildren)
            {
               ObjectUtils.disposeObject(_mc.getChildAt(0));
            }
         }
         ObjectUtils.disposeObject(_mc);
         _mc = null;
         if(_arrowMc)
         {
            _arrowMc.stop();
            while(_arrowMc.numChildren)
            {
               ObjectUtils.disposeObject(_arrowMc.getChildAt(0));
            }
         }
         ObjectUtils.disposeObject(_arrowMc);
         _arrowMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
