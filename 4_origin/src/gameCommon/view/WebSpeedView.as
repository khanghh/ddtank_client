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
      
      private function __stateChanged(event:WebSpeedEvent) : void
      {
         _bg.setFrame(_info.stateId);
         var data:Object = {};
         data["stateTxt"] = _info.state;
         data["delayTxt"] = LanguageMgr.GetTranslation("tank.game.WebSpeedView.delay") + _info.delay.toString();
         data["fpsTxt"] = LanguageMgr.GetTranslation("tank.game.WebSpeedView.frame") + _info.fps.toString();
         data["explain1"] = LanguageMgr.GetTranslation("tank.game.WebSpeedView.explain1");
         data["explain2"] = LanguageMgr.GetTranslation("tank.game.WebSpeedView.explain2");
         _bg.tipData = data;
      }
      
      private function __frame(event:Event) : void
      {
         var difference:Number = getTimer() - _startTime;
         _count = Number(_count) + 1;
         _startTime = getTimer();
         if(_count < 1500)
         {
            return;
         }
         _info.fps = int(1000 / difference);
         _count = 0;
      }
   }
}
