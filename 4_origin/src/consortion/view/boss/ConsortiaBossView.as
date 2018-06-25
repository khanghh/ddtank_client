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
      
      public function ConsortiaBossView(frame:ConsortiaBossFrame)
      {
         super();
         _frame = frame;
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
      
      private function extendBossTime(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var costRich:int = ConsortionModelManager.Instance.getCallExtendBossCostRich(2,_callBossLevel);
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortia.bossFrame.extendConfirmTxt",costRich),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__confirmExtendBossTime,false,0,true);
      }
      
      private function __confirmExtendBossTime(evt:FrameEvent) : void
      {
         var costRich:int = 0;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__confirmExtendBossTime);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            costRich = ConsortionModelManager.Instance.getCallExtendBossCostRich(2,_callBossLevel);
            if(PlayerManager.Instance.Self.consortiaInfo.Riches < costRich)
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
      
      private function callOrEnterBoss(event:MouseEvent) : void
      {
         var costRich:int = 0;
         var confirmFrame:* = null;
         SoundManager.instance.play("008");
         if(_bossState == 0)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            costRich = ConsortionModelManager.Instance.getCallBossCostRich(_frame.levelView.selectedLevel);
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortia.bossFrame.callConfirmTxt",costRich),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",__confirmCallBoss,false,0,true);
         }
         else if(_bossState == 1)
         {
            CheckWeaponManager.instance.setFunction(this,callOrEnterBoss,[event]);
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
      
      private function __confirmCallBoss(evt:FrameEvent) : void
      {
         var costRich:int = 0;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__confirmCallBoss);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            costRich = ConsortionModelManager.Instance.getCallBossCostRich(_frame.levelView.selectedLevel);
            if(PlayerManager.Instance.Self.consortiaInfo.Riches < costRich)
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
      
      private function timerHandler(event:Event) : void
      {
         SocketManager.Instance.out.sendConsortiaBossInfo(1);
      }
      
      private function refreshData(event:PkgEvent) : void
      {
         var isHasSelf:Boolean = false;
         var tmpVo:* = null;
         var tmpCount:int = 0;
         var i:int = 0;
         var tmpVo2:* = null;
         var model:ConsortiaBossModel = new ConsortiaBossModel();
         model.endTime = TimeManager.Instance.Now();
         model.extendAvailableNum = 3;
         model.playerList = new Vector.<ConsortiaBossDataVo>(11);
         _callBossLevel = 0;
         var pkg:PackageIn = event.pkg;
         model.bossState = pkg.readByte();
         if(model.bossState == 1 || model.bossState == 2)
         {
            isHasSelf = pkg.readBoolean();
            if(isHasSelf)
            {
               tmpVo = new ConsortiaBossDataVo();
               tmpVo.name = PlayerManager.Instance.Self.NickName;
               tmpVo.rank = pkg.readInt();
               tmpVo.damage = pkg.readInt();
               tmpVo.honor = pkg.readInt();
               tmpVo.contribution = pkg.readInt();
               model.playerList[0] = tmpVo;
            }
            tmpCount = pkg.readByte();
            for(i = 1; i <= tmpCount; )
            {
               tmpVo2 = new ConsortiaBossDataVo();
               tmpVo2.name = pkg.readUTF();
               tmpVo2.rank = pkg.readInt();
               tmpVo2.damage = pkg.readInt();
               tmpVo2.honor = pkg.readInt();
               tmpVo2.contribution = pkg.readInt();
               model.playerList[i] = tmpVo2;
               i++;
            }
            model.extendAvailableNum = pkg.readByte();
            model.endTime = pkg.readDate();
            model.callBossLevel = pkg.readInt();
            _callBossLevel = model.callBossLevel;
         }
         _bossState = model.bossState;
         refreshView(model);
      }
      
      private function refreshView(model:ConsortiaBossModel) : void
      {
         var i:int = 0;
         var tmpVo:* = null;
         if(_frame.cellList == null || _frame.currentPage != 0)
         {
            return;
         }
         var list:Vector.<ConsortiaBossDataVo> = model.playerList;
         for(i = 0; i < 11; )
         {
            tmpVo = list[i];
            if(tmpVo)
            {
               _frame.cellList[i].info = tmpVo;
               _frame.cellList[i].visible = true;
            }
            else
            {
               _frame.cellList[i].visible = false;
            }
            i++;
         }
         refreshEndTimeTxt(model);
         (_extendBtn.backgound["mc"] as MovieClip).gotoAndStop(model.extendAvailableNum + 1);
         var isChairman:Boolean = ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,512);
         if(model.bossState == 1)
         {
            (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(2);
            if(model.extendAvailableNum <= 0)
            {
               _extendBtn.enable = false;
            }
            else
            {
               _extendBtn.enable = isChairman;
            }
            _bossStateBtn.enable = true;
            _endTimeTxt.visible = true;
            _timerChairman.stop();
         }
         else
         {
            _endTimeTxt.visible = false;
            _extendBtn.enable = false;
            if(model.bossState == 0)
            {
               if(isChairman)
               {
                  (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(4);
               }
               else
               {
                  (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(1);
               }
               _bossStateBtn.enable = isChairman;
            }
            else if(model.bossState == 2)
            {
               (_bossStateBtn.backgound["mc"] as MovieClip).gotoAndStop(3);
               _bossStateBtn.enable = false;
            }
         }
         if(_frame.levelView)
         {
            if(model.bossState == 0)
            {
               _frame.levelView.mouseChildren = true;
               _frame.levelView.mouseEnabled = true;
            }
            else
            {
               _frame.levelView.mouseChildren = false;
               _frame.levelView.mouseEnabled = false;
               if(model.bossState == 1)
               {
                  _frame.levelView.selectedLevel = ConsortionModelManager.Instance.getCanCallBossMaxLevel(_callBossLevel);
               }
            }
         }
      }
      
      private function refreshEndTimeTxt(model:ConsortiaBossModel) : void
      {
         var timeTxtStr:* = null;
         var endTimestamp:Number = model.endTime.getTime();
         var nowTimestamp:Number = TimeManager.Instance.Now().getTime();
         var differ:int = endTimestamp - nowTimestamp;
         differ = differ < 0?0:differ;
         var count:int = 0;
         if(differ / 3600000 > 1)
         {
            count = differ / 3600000;
            timeTxtStr = count + LanguageMgr.GetTranslation("hour");
         }
         else if(differ / 60000 > 1)
         {
            count = differ / 60000;
            timeTxtStr = count + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            count = differ / 1000;
            timeTxtStr = count + LanguageMgr.GetTranslation("second");
         }
         _endTimeTxt.text = timeTxtStr;
      }
      
      private function __startLoading(e:Event) : void
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
