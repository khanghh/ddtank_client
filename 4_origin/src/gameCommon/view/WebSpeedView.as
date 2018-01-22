package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.events.WebSpeedEvent;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   import gameCommon.GameControl;
   import room.model.WebSpeedInfo;
   
   public class WebSpeedView extends Sprite
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _info:WebSpeedInfo;
      
      private var _startTime:Number;
      
      private var _count:uint = 1500;
      
      public function WebSpeedView()
      {
         _info = GameControl.Instance.Current.selfGamePlayer.webSpeedInfo;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.game.webSpdIcon");
         addChild(_bg);
         _bg.setFrame(1);
         _startTime = getTimer();
         __stateChanged(null);
      }
      
      public function dispose() : void
      {
         _info.removeEventListener("stateChange",__stateChanged);
         removeEventListener("enterFrame",__frame);
         _info = null;
         _bg.dispose();
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function initEvent() : void
      {
         _info.addEventListener("stateChange",__stateChanged);
         addEventListener("enterFrame",__frame);
      }
      
      private function __stateChanged(param1:WebSpeedEvent) : void
      {
         _bg.setFrame(_info.stateId);
         var _loc2_:Object = {};
         _loc2_["stateTxt"] = _info.state;
         _loc2_["delayTxt"] = LanguageMgr.GetTranslation("tank.game.WebSpeedView.delay") + _info.delay.toString();
         _loc2_["fpsTxt"] = LanguageMgr.GetTranslation("tank.game.WebSpeedView.frame") + _info.fps.toString();
         _loc2_["explain1"] = LanguageMgr.GetTranslation("tank.game.WebSpeedView.explain1");
         _loc2_["explain2"] = LanguageMgr.GetTranslation("tank.game.WebSpeedView.explain2");
         _bg.tipData = _loc2_;
      }
      
      private function __frame(param1:Event) : void
      {
         var _loc2_:Number = getTimer() - _startTime;
         _count = Number(_count) + 1;
         _startTime = getTimer();
         if(_count < 1500)
         {
            return;
         }
         _info.fps = int(1000 / _loc2_);
         _count = 0;
      }
   }
}
