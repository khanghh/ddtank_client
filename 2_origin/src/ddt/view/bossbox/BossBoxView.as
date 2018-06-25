package ddt.view.bossbox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BossBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import fightLib.FightLibManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class BossBoxView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _downBox:MovieImage;
      
      private var _templateIds:Array;
      
      public var boxType:int = 0;
      
      public var boxID:int;
      
      private var _time:TimerJuggler;
      
      private var awards:AwardsView;
      
      private var _fightLibType:int;
      
      private var _fightLibLevel:int;
      
      private var _mission:int;
      
      private var _alertTitle:FilterFrameText;
      
      private var _frame:BaseAlerFrame;
      
      private var _winTime:uint;
      
      public function BossBoxView(t:int, id:int, itemArr:Array, fightLibType:int = -1, fightLibLevel:int = -1)
      {
         super();
         buttonMode = true;
         _templateIds = itemArr;
         boxType = t;
         boxID = id;
         _fightLibType = fightLibType;
         _fightLibLevel = fightLibLevel;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("bossbox.TimeBoxBG");
         if(PlayerManager.Instance.Self.Grade <= 20)
         {
            _downBox = ComponentFactory.Instance.creat("bossbox.downBox");
         }
         else
         {
            _downBox = ComponentFactory.Instance.creat("bossbox.downBox60");
         }
         addChild(_bg);
         addChild(_downBox);
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("1001");
         _winTime = setTimeout(startMusic,3000);
      }
      
      private function startMusic() : void
      {
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("1001");
      }
      
      private function initEvent() : void
      {
         addEventListener("click",_boxClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",_boxClick);
      }
      
      private function _boxClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         removeEvent();
         _time = TimerManager.getInstance().addTimerJuggler(500,1);
         _time.start();
         _time.addEventListener("timerComplete",_time_complete);
      }
      
      private function _time_complete(e:Event) : void
      {
         var ai:* = null;
         if(boxType == 3)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("bossbox.AwardsFrame");
            awards = new AwardsView();
            awards.boxType = boxType;
            awards.goodsList = _templateIds;
            _frame.addToContent(awards);
            _alertTitle = ComponentFactory.Instance.creatComponentByStylename("bossbox.alert.alertTextStyle");
            _alertTitle.text = LanguageMgr.GetTranslation("tank.timeBox.awardsTitle");
            _frame.addToContent(_alertTitle);
            ai = new AlertInfo();
            ai.title = LanguageMgr.GetTranslation("tank.timeBox.awardsInfo");
            ai.showCancel = false;
            ai.moveEnable = false;
            ai.submitLabel = LanguageMgr.GetTranslation("tank.timeBox.awardsBtn");
            _frame.info = ai;
            _frame.submitButtonStyle = "bossbox.getAwardBtn";
            _frame.addEventListener("response",_close);
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
         else
         {
            awards = ComponentFactory.Instance.creat("bossbox.AwardsViewAsset");
            awards.closeButton.visible = false;
            awards.escEnable = false;
            awards.boxType = boxType;
            awards.goodsList = _templateIds;
            awards.addEventListener("_haveBtnClick",_close);
            LayerManager.Instance.addToLayer(awards,3,true,1);
         }
         removeChild(_downBox);
         removeChild(_bg);
         _downBox = null;
         _bg = null;
         _time.removeEventListener("timerComplete",_time_complete);
         _time.stop();
         TimerManager.getInstance().removeJugglerByTimer(_time);
         _time = null;
      }
      
      private function _close(e:Event) : void
      {
         switch(int(boxType))
         {
            case 0:
               SocketManager.Instance.out.sendGetTimeBox(1,boxType);
               break;
            case 1:
               SocketManager.Instance.out.sendGetTimeBox(1,boxType);
               BossBoxManager.instance.showOtherGradeBox();
               break;
            default:
               SocketManager.Instance.out.sendGetTimeBox(1,boxType);
               BossBoxManager.instance.showOtherGradeBox();
               break;
            case 3:
               _frame.removeEventListener("_haveBtnClick",_close);
               _frame.dispose();
               SocketManager.Instance.out.sendGetTimeBox(2,-1,_fightLibType,_fightLibLevel);
               FightLibManager.Instance.gainAward(FightLibManager.Instance.lastInfo);
            default:
               _frame.removeEventListener("_haveBtnClick",_close);
               _frame.dispose();
               SocketManager.Instance.out.sendGetTimeBox(2,-1,_fightLibType,_fightLibLevel);
               FightLibManager.Instance.gainAward(FightLibManager.Instance.lastInfo);
         }
         dispose();
      }
      
      public function dispose() : void
      {
         SoundManager.instance.resumeMusic();
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_downBox)
         {
            ObjectUtils.disposeObject(_downBox);
         }
         _downBox = null;
         clearTimeout(_winTime);
         if(_time)
         {
            _time.removeEventListener("timerComplete",_time_complete);
            _time.stop();
            TimerManager.getInstance().removeJugglerByTimer(_time);
         }
         _time = null;
         if(_alertTitle)
         {
            ObjectUtils.disposeObject(_alertTitle);
         }
         _alertTitle = null;
         if(_frame)
         {
            _frame.removeEventListener("_haveBtnClick",_close);
            ObjectUtils.disposeObject(_frame);
         }
         _frame = null;
         if(awards)
         {
            awards.removeEventListener("_haveBtnClick",_close);
            ObjectUtils.disposeObject(awards);
         }
         awards = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
