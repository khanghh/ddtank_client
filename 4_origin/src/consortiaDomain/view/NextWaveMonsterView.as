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
      
      private function onTimeTick(param1:TimerEvent) : void
      {
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         this.visible = false;
         var _loc7_:int = ConsortiaDomainManager.instance.activeState;
         if(_loc7_ == 1)
         {
            _loc3_ = ConsortiaDomainManager.instance.model.monsterBornArr;
            _loc5_ = ConsortiaDomainManager.instance.model.BeginTime;
            if(_loc3_ && _loc5_)
            {
               _loc4_ = (TimeManager.Instance.NowTime() - _loc5_.time) / 1000;
               var _loc10_:int = 0;
               var _loc9_:* = _loc3_;
               for each(var _loc6_ in _loc3_)
               {
                  if(_loc6_ > _loc4_)
                  {
                     _loc8_ = TimeManager.getHHMMSSArr(_loc6_ - _loc4_);
                     _tf.text = LanguageMgr.GetTranslation("consortiadomain.nextWave.time",_loc8_[0],_loc8_[1],_loc8_[2]);
                     this.visible = true;
                     break;
                  }
               }
            }
         }
         else if(_loc7_ == -10 || _loc7_ == -5 || _loc7_ == -4 || _loc7_ == -3 || _loc7_ == -2 || _loc7_ == -1)
         {
            _loc5_ = ConsortiaDomainManager.instance.model.BeginTime;
            if(_loc5_)
            {
               _loc2_ = (ConsortiaDomainManager.instance.model.BeginTime.time - TimeManager.Instance.NowTime()) / 1000;
               if(_loc2_ > 0)
               {
                  _loc8_ = TimeManager.getHHMMSSArr(_loc2_);
                  _tf.text = LanguageMgr.GetTranslation("consortiadomain.activeOpen.time",_loc8_[0],_loc8_[1],_loc8_[2]);
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
