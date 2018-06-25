package yyvip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yyvip.YYVipManager;
   
   public class YYVipEntryBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _isCanUsable:Boolean = true;
      
      public function YYVipEntryBtn()
      {
         super();
         _btn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.yyVIPBtn");
         _btn.tipData = LanguageMgr.GetTranslation("ddt.hallStateView.yyVipText");
         addChild(_btn);
         _btn.addEventListener("click",clickHandler,false,0,true);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_isCanUsable)
         {
            YYVipManager.instance.loadResModule();
            _count = 60;
            _timer.start();
            _isCanUsable = false;
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.openMainFrame.limitTipTxt",_count));
         }
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         _count = Number(_count) - 1;
         if(_count <= 0)
         {
            _timer.reset();
            _timer.stop();
            _isCanUsable = true;
            _count = 0;
         }
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
         }
         _timer = null;
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
         }
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
