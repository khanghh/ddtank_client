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
         var _loc1_:SelfInfo = PlayerManager.Instance.Self;
         if(_loc1_.Grade < 10 || _loc1_.isSameDay)
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
         else if(_openType == 0 && _loc1_.LastDate.valueOf() < _endTime.valueOf())
         {
            _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.kingBless.dueTipTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _confirmFrame.moveEnable = false;
            _confirmFrame.addEventListener("response",__confirmDue);
         }
      }
      
      private function __confirmOneDay(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmOneDay);
         _confirmFrame = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            show();
         }
      }
      
      private function __confirmDue(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmDue);
         _confirmFrame = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
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
         var _loc15_:* = null;
         var _loc17_:int = 0;
         var _loc8_:* = null;
         var _loc16_:Number = _endTime.getTime();
         var _loc7_:Number = TimeManager.Instance.Now().getTime();
         var _loc12_:Number = _loc16_ - _loc7_;
         if(_openType == 0 || _loc12_ < 1000)
         {
            _loc15_ = {};
            _loc15_.isOpen = false;
            _loc15_.content = LanguageMgr.GetTranslation("ddt.kingBlessFrame.noOpenIconBtnTipTxt");
            return _loc15_;
         }
         var _loc9_:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameStateTxt") + "\r";
         var _loc10_:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt5") + "\r";
         var _loc3_:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt1",getOneBuffData(2)) + "\r";
         var _loc11_:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt2",getOneBuffData(3)) + "\r";
         var _loc13_:int = getOneBuffData(4);
         var _loc14_:BuffInfo = PlayerManager.Instance.Self.buffInfo[51] as BuffInfo;
         if(_loc14_)
         {
            _loc17_ = _loc14_.ValidCount > _loc13_?_loc13_:int(_loc14_.ValidCount);
         }
         else
         {
            _loc17_ = 0;
         }
         var _loc6_:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt3",_loc17_) + "\r";
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt4",getOneBuffData(5)) + "\r";
         var _loc5_:String = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxt6") + "\r";
         var _loc4_:String = _loc11_ + _loc6_ + _loc2_ + _loc10_ + _loc5_ + _loc3_;
         var _loc1_:int = 0;
         if(_loc12_ / 86400000 > 1)
         {
            _loc1_ = _loc12_ / 86400000;
            _loc8_ = _loc1_ + LanguageMgr.GetTranslation("day");
         }
         else if(_loc12_ / 3600000 > 1)
         {
            _loc1_ = _loc12_ / 3600000;
            _loc8_ = _loc1_ + LanguageMgr.GetTranslation("hour");
         }
         else if(_loc12_ / 60000 > 1)
         {
            _loc1_ = _loc12_ / 60000;
            _loc8_ = _loc1_ + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            _loc1_ = _loc12_ / 1000;
            _loc8_ = _loc1_ + LanguageMgr.GetTranslation("second");
         }
         _loc15_ = {};
         var _loc18_:Boolean = true;
         _loc15_.isOpen = _loc18_;
         _loc15_.isSelf = _loc18_;
         _loc15_.title = _loc9_;
         _loc15_.content = _loc4_;
         _loc15_.bottom = LanguageMgr.GetTranslation("ddt.kingBlessFrame.remainTimeTxt") + _loc8_;
         return _loc15_;
      }
      
      private function timerHandler(param1:TimerEvent) : void
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
      
      private function updateAllData(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         _openType = _loc3_.readInt();
         _endTime = _loc3_.readDate();
         if(_openType > 0)
         {
            _loc2_ = _loc3_.readInt();
            _buffData = {};
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc4_ = _loc3_.readInt();
               _buffData[_loc4_] = _loc3_.readInt();
               _loc5_++;
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
         var _loc1_:BuffInfo = PlayerManager.Instance.Self.getBuff(51);
         if(_loc1_)
         {
            _loc1_.additionCount = getOneBuffData(4);
         }
      }
      
      private function updateBuffData(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         _buffData[_loc3_] = _loc2_.readInt();
         dispatchEvent(new Event("update_buff_data_event"));
      }
      
      public function getOneBuffData(param1:int) : int
      {
         if(_openType > 0 && _buffData)
         {
            return _buffData[param1];
         }
         return 0;
      }
   }
}
