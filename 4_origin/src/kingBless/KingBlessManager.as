package kingBless
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   
   public class KingBlessManager extends EventDispatcher
   {
      
      public static const KINGBLESS_OPENVIEW:String = "kingBlessOpenView";
      
      public static const UPDATE_BUFF_DATA_EVENT:String = "update_buff_data_event";
      
      public static const UPDATE_MAIN_EVENT:String = "update_main_event";
      
      public static const STRENGTH_ENCHANCE:int = 1;
      
      public static const PET_REFRESH:int = 2;
      
      public static const BEAD_MASTER:int = 3;
      
      public static const HELP_STRAW:int = 4;
      
      public static const DUNGEON_HERO:int = 5;
      
      public static const TASK_SPIRIT:int = 6;
      
      public static const TIME_DEITY:int = 7;
      
      private static var _instance:KingBlessManager;
       
      
      private var _openType:int;
      
      private var _endTime:Date;
      
      private var _buffData:Object;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _isChecked:Boolean = false;
      
      private var _confirmFrame:BaseAlerFrame;
      
      public function KingBlessManager()
      {
         super(null);
      }
      
      public static function get instance() : KingBlessManager
      {
         if(_instance == null)
         {
            _instance = new KingBlessManager();
         }
         return _instance;
      }
      
      public function get openType() : int
      {
         return _openType;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(142),updateAllData);
         SocketManager.Instance.addEventListener(PkgEvent.format(143),updateBuffData);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler);
      }
      
      public function clearConfirmFrame() : void
      {
         if(_confirmFrame)
         {
            _confirmFrame.removeEventListener("response",__confirmOneDay);
            _confirmFrame.removeEventListener("response",__confirmDue);
            ObjectUtils.disposeObject(_confirmFrame);
         }
         _confirmFrame = null;
      }
      
      public function checkShowDueAlert() : void
      {
         if(_isChecked)
         {
            return;
         }
         _isChecked = true;
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(selfInfo.Grade < 10 || selfInfo.isSameDay)
         {
            return;
         }
         if(!_endTime)
         {
            return;
         }
         if(_openType > 0 && _endTime.getTime() - TimeManager.Instance.Now().getTime() < 86400000)
         {
            _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.kingBless.oneDayTipTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _confirmFrame.moveEnable = false;
            _confirmFrame.addEventListener("response",__confirmOneDay);
         }
         else if(_openType == 0 && selfInfo.LastDate.valueOf() < _endTime.valueOf())
         {
            _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.kingBless.dueTipTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _confirmFrame.moveEnable = false;
            _confirmFrame.addEventListener("response",__confirmDue);
         }
      }
      
      private function __confirmOneDay(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmOneDay);
         _confirmFrame = null;
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            show();
         }
      }
      
      private function __confirmDue(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmDue);
         _confirmFrame = null;
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            show();
         }
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("kingbless",6);
         AssetModuleLoader.startCodeLoader(doOpenKingBlessFrame);
      }
      
      private function doOpenKingBlessFrame() : void
      {
         dispatchEvent(new Event("kingBlessOpenView"));
      }
      
      public function getRemainTimeTxt() : Object
      {
         var obj:* = null;
         var restHelpStraw:int = 0;
         var timeTxtStr:* = null;
         var endTimestamp:Number = _endTime.getTime();
         var nowTimestamp:Number = TimeManager.Instance.Now().getTime();
         var differ:Number = endTimestamp - nowTimestamp;
         if(_openType == 0 || differ < 1000)
         {
            obj = {};
            obj.isOpen = false;
            obj.content = LanguageMgr.GetTranslation("ddt.kingBlessFrame.noOpenIconBtnTipTxt");
            return obj;
         }
         var stateTipStr:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameStateTxt") + "\r";
         var strengthTipStr:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt5") + "\r";
         var petTipStr:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt1",getOneBuffData(2)) + "\r";
         var beadTipStr:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt2",getOneBuffData(3)) + "\r";
         var tmpHelpStraw:int = getOneBuffData(4);
         var tmpBuffInfo:BuffInfo = PlayerManager.Instance.Self.buffInfo[51] as BuffInfo;
         if(tmpBuffInfo)
         {
            restHelpStraw = tmpBuffInfo.ValidCount > tmpHelpStraw?tmpHelpStraw:int(tmpBuffInfo.ValidCount);
         }
         else
         {
            restHelpStraw = 0;
         }
         var helpTipStr:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt3",restHelpStraw) + "\r";
         var dungeonTipStr:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt4",getOneBuffData(5)) + "\r";
         var taskSpiritTipStr:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt6") + "\r";
         var sumStr:String = beadTipStr + helpTipStr + dungeonTipStr + strengthTipStr + taskSpiritTipStr + petTipStr;
         var count:int = 0;
         if(differ / 86400000 > 1)
         {
            count = differ / 86400000;
            timeTxtStr = count + LanguageMgr.GetTranslation("day");
         }
         else if(differ / 3600000 > 1)
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
         obj = {};
         var _loc18_:Boolean = true;
         obj.isOpen = _loc18_;
         obj.isSelf = _loc18_;
         obj.title = stateTipStr;
         obj.content = sumStr;
         obj.bottom = LanguageMgr.GetTranslation("ddt.kingBlessFrame.remainTimeTxt") + timeTxtStr;
         return obj;
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         _count = Number(_count) - 1;
         if(_count <= 0)
         {
            _openType = 0;
            _timer.stop();
            helpStrawShowHandler();
            dispatchEvent(new Event("update_main_event"));
         }
      }
      
      private function updateAllData(event:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var tmpkey:int = 0;
         var pkg:PackageIn = event.pkg;
         _openType = pkg.readInt();
         _endTime = pkg.readDate();
         if(_openType > 0)
         {
            count = pkg.readInt();
            _buffData = {};
            for(i = 0; i < count; )
            {
               tmpkey = pkg.readInt();
               _buffData[tmpkey] = pkg.readInt();
               i++;
            }
            _count = int((_endTime.getTime() - TimeManager.Instance.Now().getTime()) / 1000);
            if(_count > 0)
            {
               _timer.reset();
               _timer.start();
            }
         }
         else
         {
            _buffData = null;
         }
         helpStrawShowHandler();
         dispatchEvent(new Event("update_main_event"));
      }
      
      private function helpStrawShowHandler() : void
      {
         var buffInfo:BuffInfo = PlayerManager.Instance.Self.getBuff(51);
         if(buffInfo)
         {
            buffInfo.additionCount = getOneBuffData(4);
         }
      }
      
      private function updateBuffData(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var tmpkey:int = pkg.readInt();
         _buffData[tmpkey] = pkg.readInt();
         dispatchEvent(new Event("update_buff_data_event"));
      }
      
      public function getOneBuffData(type:int) : int
      {
         if(_openType > 0 && _buffData)
         {
            return _buffData[type];
         }
         return 0;
      }
   }
}
