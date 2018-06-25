package consortiaDomain.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class NextWaveMonsterView extends Sprite implements Disposeable
   {
       
      
      private var _tf:FilterFrameText;
      
      private var _timer:Timer;
      
      public function NextWaveMonsterView()
      {
         super();
         UICreatShortcut.creatAndAdd("consortiadomain.nextWave.bg",this);
         _tf = UICreatShortcut.creatTextAndAdd("consortiadomain.nextWave.timeText","",this);
         _timer = new Timer(1000,2147483647);
         _timer.addEventListener("timer",onTimeTick);
         _timer.start();
      }
      
      private function onTimeTick(event:TimerEvent) : void
      {
         var beginTime:* = null;
         var timeArr:* = null;
         var monsterBornArr:* = null;
         var activeOpenSec:int = 0;
         var coldDownSec:int = 0;
         this.visible = false;
         var activeState:int = ConsortiaDomainManager.instance.activeState;
         if(activeState == 1)
         {
            monsterBornArr = ConsortiaDomainManager.instance.model.monsterBornArr;
            beginTime = ConsortiaDomainManager.instance.model.BeginTime;
            if(monsterBornArr && beginTime)
            {
               activeOpenSec = (TimeManager.Instance.NowTime() - beginTime.time) / 1000;
               var _loc10_:int = 0;
               var _loc9_:* = monsterBornArr;
               for each(var bornSec in monsterBornArr)
               {
                  if(bornSec > activeOpenSec)
                  {
                     timeArr = TimeManager.getHHMMSSArr(bornSec - activeOpenSec);
                     _tf.text = LanguageMgr.GetTranslation("consortiadomain.nextWave.time",timeArr[0],timeArr[1],timeArr[2]);
                     this.visible = true;
                     break;
                  }
               }
            }
         }
         else if(activeState == -10 || activeState == -5 || activeState == -4 || activeState == -3 || activeState == -2 || activeState == -1)
         {
            beginTime = ConsortiaDomainManager.instance.model.BeginTime;
            if(beginTime)
            {
               coldDownSec = (ConsortiaDomainManager.instance.model.BeginTime.time - TimeManager.Instance.NowTime()) / 1000;
               if(coldDownSec > 0)
               {
                  timeArr = TimeManager.getHHMMSSArr(coldDownSec);
                  _tf.text = LanguageMgr.GetTranslation("consortiadomain.activeOpen.time",timeArr[0],timeArr[1],timeArr[2]);
                  this.visible = true;
               }
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_tf);
         _tf = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimeTick);
            _timer = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
