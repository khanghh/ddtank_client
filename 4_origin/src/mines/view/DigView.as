package mines.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mines.MinesManager;
   import mines.mornui.view.DigViewUI;
   import morn.core.handlers.Handler;
   import trainer.view.NewHandContainer;
   
   public class DigView extends DigViewUI
   {
      
      public static var doAction:Boolean = false;
       
      
      private var showView:DigShowView;
      
      private var mc:MovieClip;
      
      private var _currentLevel:int;
      
      private var timer:Timer;
      
      public function DigView()
      {
         timer = new Timer(7000);
         super();
         addEvent();
      }
      
      private function addEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__onUpdateGrade);
         MinesManager.instance.addEventListener(MinesManager.INFOLABEL,changeInfoLabel);
         MinesManager.instance.addEventListener(MinesManager.LEVEL_UP_TOOL,levelUpTool);
      }
      
      override protected function initialize() : void
      {
         showBtn.clickHandler = new Handler(show);
         stopBtn.clickHandler = new Handler(stopDig);
         digBtn.clickHandler = new Handler(digHandler);
         costInfoLabel.text = LanguageMgr.GetTranslation("ddt.mines.digView.costInfo",ServerConfigManager.instance.getOnlineArmCostEnergy);
         progress.value = PlayerManager.Instance.Self.energy / 1500;
         proLabel.text = String(PlayerManager.Instance.Self.energy) + "/1500";
         floorLabel.text = LanguageMgr.GetTranslation("ddt.mines.digView.floor");
         combox.selectHandler = new Handler(changeHandler);
         combox.selectedIndex = MinesManager.instance.model.toolLevel - 1;
         createMc();
      }
      
      private function createMc() : void
      {
         _currentLevel = MinesManager.instance.model.toolLevel;
         mc = ClassUtils.CreatInstance("asset.mines.digView.digMc" + MinesManager.instance.model.toolLevel);
         mc.gotoAndStop(1);
         mc.visible = false;
         mc.mouseEnabled = false;
         PositionUtils.setPos(mc,"mines.digView.mcPos");
         addChild(mc);
      }
      
      private function changeHandler(param1:int) : void
      {
         if(combox.selectedIndex > MinesManager.instance.model.toolLevel - 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.digView.chooseLevel"));
            combox.selectedIndex = MinesManager.instance.model.toolLevel - 1;
         }
      }
      
      public function stopDig() : void
      {
         if(timer.running)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.digView.leaveStop"));
         }
         doAction = false;
         mc.gotoAndStop(1);
         mc.visible = false;
         timer.stop();
         timer.removeEventListener("timer",timerHandler);
      }
      
      private function levelUpTool(param1:Event) : void
      {
         if(_currentLevel == MinesManager.instance.model.toolLevel)
         {
            return;
         }
         this.removeChild(mc);
         createMc();
      }
      
      private function digHandler() : void
      {
         if(PlayerManager.Instance.Self.energy < ServerConfigManager.instance.getOnlineArmCostEnergy)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.digView.poweroff"));
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(650))
         {
            NewHandContainer.Instance.showArrow(650,-30,"mines.digView.arrowPos");
         }
         if(doAction)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.mines.digView.isDiging"));
            return;
         }
         doAction = true;
         timer.addEventListener("timer",timerHandler);
         timer.start();
         mc.visible = true;
         mc.play();
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         if(MinesManager.instance.model.isFull)
         {
            MinesManager.instance.model.isFull = false;
            mc.gotoAndStop(1);
            mc.visible = false;
            timer.stop();
            timer.removeEventListener("timer",timerHandler);
            return;
         }
         SocketManager.Instance.out.sendDigHandler(combox.selectedIndex + 1);
         param1.updateAfterEvent();
      }
      
      public function changeInfoLabel(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:String = "";
         _loc5_ = 0;
         while(_loc5_ < MinesManager.instance.model.digShowList.length)
         {
            _loc3_ = "";
            if(MinesManager.instance.model.digShowList[_loc5_][1] == 0)
            {
               if(PlayerManager.Instance.Self.energy < ServerConfigManager.instance.getOnlineArmCostEnergy)
               {
                  _loc3_ = _loc3_ + LanguageMgr.GetTranslation("ddt.mines.digView.poweroff");
               }
               else
               {
                  _loc3_ = _loc3_ + LanguageMgr.GetTranslation("ddt.mines.digView.bagFull");
               }
            }
            else
            {
               _loc4_ = MinesManager.instance.model.digShowList[_loc5_][0] + "*" + MinesManager.instance.model.digShowList[_loc5_][1];
               _loc3_ = _loc3_ + LanguageMgr.GetTranslation("ddt.mines.digView.dig.something",_loc4_);
            }
            _loc3_ = _loc3_ + "\n";
            _loc2_ = _loc2_ + _loc3_;
            _loc5_++;
         }
         infoLabel.htmlText = _loc2_;
      }
      
      protected function __onUpdateGrade(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Energy"])
         {
            progress.value = PlayerManager.Instance.Self.energy / 1500;
            proLabel.text = String(PlayerManager.Instance.Self.energy) + "/1500";
         }
      }
      
      private function show() : void
      {
         showView = ClassUtils.CreatInstance("mines.view.DigShowView");
         LayerManager.Instance.addToLayer(showView,3,false,1);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onUpdateGrade);
         MinesManager.instance.removeEventListener(MinesManager.INFOLABEL,changeInfoLabel);
         MinesManager.instance.removeEventListener(MinesManager.LEVEL_UP_TOOL,levelUpTool);
      }
      
      override public function dispose() : void
      {
         stopDig();
         removeEvent();
         if(showView)
         {
            showView.dispose();
            showView = null;
         }
         super.dispose();
      }
   }
}
