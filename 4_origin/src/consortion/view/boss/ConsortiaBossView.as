package consortion.view.boss
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaBossDataVo;
   import consortion.data.ConsortiaBossModel;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import road7th.comm.PackageIn;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsortiaBossView extends Sprite implements Disposeable
   {
       
      
      private var _timeBg:Bitmap;
      
      private var _endTimeTxt:FilterFrameText;
      
      private var _extendBtn:SimpleBitmapButton;
      
      private var _bossStateBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _timer:TimerJuggler;
      
      private var _timerChairman:TimerJuggler;
      
      private var _bossState:int = -1;
      
      private var _callBossLevel:int = 0;
      
      private var _isClickEnter:Boolean = false;
      
      private var _frame:ConsortiaBossFrame;
      
      public function ConsortiaBossView(param1:ConsortiaBossFrame)
      {
         super();
         _frame = param1;
         init();
         initData();
         initEvent();
      }
      
      private function init() : void
      {
         _timeBg = ComponentFactory.Instance.creatBitmap("asset.consortionBossFrame.timeBg");
         addChild(_timeBg);
         _endTimeTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.endTimeTxt");
         _endTimeTxt.visible = false;
         addChild(_endTimeTxt);
         _extendBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.extendBtn");
         addChild(_extendBtn);
         _extendBtn.enable = false;
         (_extendBtn.backgound["mc"] as MovieClip).gotoAndStop(4);
         _bossStateBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.bossStateBtn");
         addChild(_bossStateBtn);
         _bossStateBtn.enable = false;
         (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(1);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall","consort.bossFrame.helpPos",LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),"asset.consortionBossFrame.helpContentTxt",406,483) as SimpleBitmapButton;
      }
      
      private function extendBossTime(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = ConsortionModelManager.Instance.getCallExtendBossCostRich(2,_callBossLevel);
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortia.bossFrame.extendConfirmTxt",_loc2_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _loc3_.moveEnable = false;
         _loc3_.addEventListener("response",__confirmExtendBossTime,false,0,true);
      }
      
      private function __confirmExtendBossTime(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__confirmExtendBossTime);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = ConsortionModelManager.Instance.getCallExtendBossCostRich(2,_callBossLevel);
            if(PlayerManager.Instance.Self.consortiaInfo.Riches < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.unenoughRiches"));
               return;
            }
            SocketManager.Instance.out.sendConsortiaBossInfo(2);
            ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
            _timerChairman.reset();
            _timerChairman.start();
            _timer.reset();
            _timer.start();
            _extendBtn.enable = false;
         }
      }
      
      private function callOrEnterBoss(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         if(_bossState == 0)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = ConsortionModelManager.Instance.getCallBossCostRich(_frame.levelView.selectedLevel);
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortia.bossFrame.callConfirmTxt",_loc2_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",__confirmCallBoss,false,0,true);
         }
         else if(_bossState == 1)
         {
            CheckWeaponManager.instance.setFunction(this,callOrEnterBoss,[param1]);
            if(CheckWeaponManager.instance.isNoWeapon())
            {
               CheckWeaponManager.instance.showAlert();
               return;
            }
            if(!_isClickEnter)
            {
               _isClickEnter = true;
               GameInSocketOut.sendSingleRoomBegin(2);
            }
         }
      }
      
      private function __confirmCallBoss(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__confirmCallBoss);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = ConsortionModelManager.Instance.getCallBossCostRich(_frame.levelView.selectedLevel);
            if(PlayerManager.Instance.Self.consortiaInfo.Riches < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.unenoughRiches"));
               return;
            }
            SocketManager.Instance.out.sendConsortiaBossInfo(0,ConsortionModelManager.Instance.getRequestCallBossLevel(_frame.levelView.selectedLevel));
            ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
            _timerChairman.reset();
            _timerChairman.start();
            _timer.reset();
            _timer.start();
            _bossStateBtn.enable = false;
         }
      }
      
      private function initData() : void
      {
         _timerChairman = TimerManager.getInstance().addTimerJuggler(1000);
         _timerChairman.addEventListener("timer",timerHandler,false,0,true);
         _timer = TimerManager.getInstance().addTimerJuggler(10000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
         timerHandler(null);
      }
      
      private function timerHandler(param1:Event) : void
      {
         SocketManager.Instance.out.sendConsortiaBossInfo(1);
      }
      
      private function refreshData(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc4_:ConsortiaBossModel = new ConsortiaBossModel();
         _loc4_.endTime = TimeManager.Instance.Now();
         _loc4_.extendAvailableNum = 3;
         _loc4_.playerList = new Vector.<ConsortiaBossDataVo>(11);
         _callBossLevel = 0;
         var _loc6_:PackageIn = param1.pkg;
         _loc4_.bossState = _loc6_.readByte();
         if(_loc4_.bossState == 1 || _loc4_.bossState == 2)
         {
            _loc3_ = _loc6_.readBoolean();
            if(_loc3_)
            {
               _loc2_ = new ConsortiaBossDataVo();
               _loc2_.name = PlayerManager.Instance.Self.NickName;
               _loc2_.rank = _loc6_.readInt();
               _loc2_.damage = _loc6_.readInt();
               _loc2_.honor = _loc6_.readInt();
               _loc2_.contribution = _loc6_.readInt();
               _loc4_.playerList[0] = _loc2_;
            }
            _loc7_ = _loc6_.readByte();
            _loc8_ = 1;
            while(_loc8_ <= _loc7_)
            {
               _loc5_ = new ConsortiaBossDataVo();
               _loc5_.name = _loc6_.readUTF();
               _loc5_.rank = _loc6_.readInt();
               _loc5_.damage = _loc6_.readInt();
               _loc5_.honor = _loc6_.readInt();
               _loc5_.contribution = _loc6_.readInt();
               _loc4_.playerList[_loc8_] = _loc5_;
               _loc8_++;
            }
            _loc4_.extendAvailableNum = _loc6_.readByte();
            _loc4_.endTime = _loc6_.readDate();
            _loc4_.callBossLevel = _loc6_.readInt();
            _callBossLevel = _loc4_.callBossLevel;
         }
         _bossState = _loc4_.bossState;
         refreshView(_loc4_);
      }
      
      private function refreshView(param1:ConsortiaBossModel) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         if(_frame.cellList == null || _frame.currentPage != 0)
         {
            return;
         }
         var _loc4_:Vector.<ConsortiaBossDataVo> = param1.playerList;
         _loc5_ = 0;
         while(_loc5_ < 11)
         {
            _loc2_ = _loc4_[_loc5_];
            if(_loc2_)
            {
               _frame.cellList[_loc5_].info = _loc2_;
               _frame.cellList[_loc5_].visible = true;
            }
            else
            {
               _frame.cellList[_loc5_].visible = false;
            }
            _loc5_++;
         }
         refreshEndTimeTxt(param1);
         (_extendBtn.backgound["mc"] as MovieClip).gotoAndStop(param1.extendAvailableNum + 1);
         var _loc3_:Boolean = ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,512);
         if(param1.bossState == 1)
         {
            (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(2);
            if(param1.extendAvailableNum <= 0)
            {
               _extendBtn.enable = false;
            }
            else
            {
               _extendBtn.enable = _loc3_;
            }
            _bossStateBtn.enable = true;
            _endTimeTxt.visible = true;
            _timerChairman.stop();
         }
         else
         {
            _endTimeTxt.visible = false;
            _extendBtn.enable = false;
            if(param1.bossState == 0)
            {
               if(_loc3_)
               {
                  (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(4);
               }
               else
               {
                  (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(1);
               }
               _bossStateBtn.enable = _loc3_;
            }
            else if(param1.bossState == 2)
            {
               (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(3);
               _bossStateBtn.enable = false;
            }
         }
         if(_frame.levelView)
         {
            if(param1.bossState == 0)
            {
               _frame.levelView.mouseChildren = true;
               _frame.levelView.mouseEnabled = true;
            }
            else
            {
               _frame.levelView.mouseChildren = false;
               _frame.levelView.mouseEnabled = false;
               if(param1.bossState == 1)
               {
                  _frame.levelView.selectedLevel = ConsortionModelManager.Instance.getCanCallBossMaxLevel(_callBossLevel);
               }
            }
         }
      }
      
      private function refreshEndTimeTxt(param1:ConsortiaBossModel) : void
      {
         var _loc6_:* = null;
         var _loc5_:Number = param1.endTime.getTime();
         var _loc4_:Number = TimeManager.Instance.Now().getTime();
         var _loc2_:int = _loc5_ - _loc4_;
         _loc2_ = _loc2_ < 0?0:_loc2_;
         var _loc3_:int = 0;
         if(_loc2_ / 3600000 > 1)
         {
            _loc3_ = _loc2_ / 3600000;
            _loc6_ = _loc3_ + LanguageMgr.GetTranslation("hour");
         }
         else if(_loc2_ / 60000 > 1)
         {
            _loc3_ = _loc2_ / 60000;
            _loc6_ = _loc3_ + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            _loc3_ = _loc2_ / 1000;
            _loc6_ = _loc3_ + LanguageMgr.GetTranslation("second");
         }
         _endTimeTxt.text = _loc6_;
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      public function show() : void
      {
         this.visible = true;
         SocketManager.Instance.addEventListener(PkgEvent.format(129,30),refreshData);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
         _timer.reset();
         _timer.start();
         _timerChairman.reset();
         _timerChairman.start();
         timerHandler(null);
      }
      
      public function hied() : void
      {
         this.visible = false;
         SocketManager.Instance.removeEventListener(PkgEvent.format(129,30),refreshData);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_8 = true;
         _timer.stop();
         _timerChairman.stop();
      }
      
      private function initEvent() : void
      {
         _extendBtn.addEventListener("click",extendBossTime,false,0,true);
         _bossStateBtn.addEventListener("click",callOrEnterBoss,false,0,true);
      }
      
      private function removeEvent() : void
      {
         _extendBtn.removeEventListener("click",extendBossTime);
         _bossStateBtn.removeEventListener("click",callOrEnterBoss);
         SocketManager.Instance.removeEventListener(PkgEvent.format(129,30),refreshData);
      }
      
      public function dispose() : void
      {
         removeEvent();
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         if(_timerChairman)
         {
            _timerChairman.stop();
            _timerChairman.removeEventListener("timer",timerHandler);
            TimerManager.getInstance().removeJugglerByTimer(_timerChairman);
         }
         _timerChairman = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHandler);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
         }
         _timer = null;
         if(_extendBtn)
         {
            (_extendBtn.backgound as MovieClip).gotoAndStop(5);
         }
         if(_bossStateBtn)
         {
            (_bossStateBtn.backgound as MovieClip).gotoAndStop(5);
         }
         ObjectUtils.disposeAllChildren(this);
         _timeBg = null;
         _endTimeTxt = null;
         _extendBtn = null;
         _bossStateBtn = null;
         _frame = null;
      }
   }
}
