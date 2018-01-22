package moneyTree
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.Event;
   import moneyTree.model.MoneyTreeModel;
   import road7th.comm.PackageIn;
   
   public class MoneyTreeManager extends CoreManager
   {
      
      public static const SHOW_MAIN_FRAME:String = "mt_show_main_frame";
      
      public static const HIDE_MAIN_FRAME:String = "mt_hide_main_frame";
      
      public static const UPDATE_INFO:String = "mt_update_info";
      
      public static const UPDATE_REMAIN_NUM:String = "mt_update_remain";
      
      public static const UPDATE_TIMER:String = "mt_update_timer";
      
      public static const RESET_FRIEND_LIST:String = "mt_reset_friends_list";
      
      public static const PICK_MOVIE:String = "mt_pick_movie";
      
      public static const SPEEDUP_SUC:String = "mt_speedup_suc";
      
      public static const SET_FOCUS:String = "mt_set_focus";
      
      private static var instance:MoneyTreeManager;
       
      
      private var _model:MoneyTreeModel;
      
      private var _isListening:Boolean = false;
      
      private var _type:int;
      
      private var _positon:int;
      
      private var _isBind:Boolean = false;
      
      private var _showAgain:Boolean = true;
      
      private var _TempShowAgain:Boolean = true;
      
      public function MoneyTreeManager(param1:inner)
      {
         super();
         _model = new MoneyTreeModel();
      }
      
      public static function getInstance() : MoneyTreeManager
      {
         if(!instance)
         {
            instance = new MoneyTreeManager(new inner());
         }
         return instance;
      }
      
      public function get model() : MoneyTreeModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.out.sendUpdateSysDate();
         addEvents();
      }
      
      private function addEvents() : void
      {
         if(_isListening)
         {
            return;
         }
         _isListening = true;
         var _loc2_:int = 296;
         var _loc1_:int = 1;
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc2_,_loc1_),onPkgUpdateInfo);
         var _loc3_:int = 3;
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc2_,_loc3_),onPkgSendRedPkg);
         var _loc4_:int = 2;
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc2_,_loc4_),onPkgSpeedUp);
         _model.addEventListener("mt_timer",onTimer);
      }
      
      protected function onTimer(param1:Event) : void
      {
         dispatchEvent(new CEvent("mt_update_timer"));
      }
      
      public function onPkgUpdateInfo(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageIn = param1.pkg;
         _model.setNumRedPkgRemain(_loc2_.readInt());
         _model.resetWillSendNum();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _model.setInfoAt(_loc3_,_loc2_.readDate(),_loc2_.readInt());
            _loc3_++;
         }
         dispatchEvent(new CEvent("mt_update_info"));
         dispatchEvent(new CEvent("mt_reset_friends_list"));
      }
      
      public function onPkgSendRedPkg(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.setNumRedPkgRemain(_loc2_.readInt());
         _model.resetWillSendNum();
         dispatchEvent(new CEvent("mt_update_remain"));
         dispatchEvent(new CEvent("mt_reset_friends_list"));
      }
      
      public function onPkgSpeedUp(param1:PkgEvent) : void
      {
         dispatchEvent(new CEvent("mt_speedup_suc"));
      }
      
      public function getCurSpeedUpToMature() : String
      {
         return LanguageMgr.GetTranslation("moneytree.cost.perspeedup",_model.getPriceSpeedUp(_positon) * _model.getTimesToGrown(_positon));
      }
      
      public function getCurSpeedUpOnce() : String
      {
         return LanguageMgr.GetTranslation("moneytree.cost.perspeedup",_model.getPriceSpeedUp(_positon).toString());
      }
      
      public function showMainFrame() : void
      {
         show();
      }
      
      override protected function start() : void
      {
         addEvents();
         dispatchEvent(new CEvent("mt_show_main_frame"));
      }
      
      public function hideMainFrame() : void
      {
         dispatchEvent(new CEvent("mt_hide_main_frame"));
      }
      
      public function npcClicked() : void
      {
         showMainFrame();
      }
      
      public function inviteBtnClicked(param1:int, param2:String) : void
      {
         var _loc3_:* = param2;
         if("invite" !== _loc3_)
         {
            if("unInvite" === _loc3_)
            {
               _model.reduceFriendsToSend(param1);
            }
         }
         else
         {
            _model.addFriendsToSend(param1);
         }
         dispatchEvent(new CEvent("mt_set_focus"));
      }
      
      public function sendRedPkgBtnClicked() : void
      {
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc1_:Array = _model.getFriendsToSendList();
         if(_loc1_.length == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("moneytree.noneFriendSelected");
            MessageTipManager.getInstance().show(_loc2_,0,false,1);
         }
         else
         {
            requireSendRedPkg(_model.getFriendsToSendList());
         }
         _model.resetWillSendNum();
         dispatchEvent(new CEvent("mt_reset_friends_list"));
         dispatchEvent(new CEvent("mt_set_focus"));
      }
      
      public function pick(param1:int) : void
      {
         requirePick(param1);
      }
      
      public function becomeMature() : void
      {
         dispatchEvent(new CEvent("mt_update_info"));
      }
      
      public function onSpeedUpTypeSelected() : int
      {
         return _model.getCurSlctTimesSpeedUpToMature(_positon);
      }
      
      public function onSpeedUpClick(param1:int) : void
      {
         var _loc3_:* = NaN;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _positon = param1;
         if(!_showAgain)
         {
            _loc3_ = 0;
            _TempShowAgain = _showAgain;
            _showAgain = true;
            if(_type == 0)
            {
               _loc3_ = Number(_model.getPriceSpeedUp(_positon));
            }
            else
            {
               _loc3_ = Number(_model.getPriceSpeedUp(_positon) * _model.getTimesToGrown(_positon));
            }
            CheckMoneyUtils.instance.checkMoney(_isBind,_loc3_,onCheckComplete);
            return;
         }
         var _loc4_:String = getCurSpeedUpOnce();
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),_loc4_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"moneyTree.confirmView",60,false,0);
         _loc2_.addEventListener("response",confirmResponse);
      }
      
      public function get positon() : int
      {
         return _positon;
      }
      
      private function confirmResponse(param1:FrameEvent) : void
      {
         var _loc3_:* = NaN;
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",confirmResponse);
         _type = _loc2_["type"];
         _TempShowAgain = !_loc2_["isNoPrompt"];
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc3_ = 0;
            if(_type == 0)
            {
               _loc3_ = Number(_model.getPriceSpeedUp(_positon));
            }
            else
            {
               _loc3_ = Number(_model.getPriceSpeedUp(_positon) * _model.getTimesToGrown(_positon));
            }
            CheckMoneyUtils.instance.checkMoney(_isBind,_loc3_,onCheckComplete);
         }
         _loc2_.dispose();
         dispatchEvent(new CEvent("mt_set_focus"));
      }
      
      protected function onCheckComplete() : void
      {
         _showAgain = _TempShowAgain;
         requireSpeedUp(_positon,_type,CheckMoneyUtils.instance.isBind);
         dispatchEvent(new CEvent("mt_set_focus"));
      }
      
      public function dispose() : void
      {
         _isListening = false;
         var _loc2_:int = 296;
         var _loc1_:int = 1;
         SocketManager.Instance.removeEventListener(PkgEvent.format(_loc2_,_loc1_),onPkgUpdateInfo);
         var _loc3_:int = 3;
         SocketManager.Instance.removeEventListener(PkgEvent.format(_loc2_,_loc3_),onPkgSendRedPkg);
         var _loc4_:int = 2;
         SocketManager.Instance.removeEventListener(PkgEvent.format(_loc2_,_loc4_),onPkgSpeedUp);
      }
      
      private function requireSpeedUp(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         if(param2 == 0)
         {
            _loc4_ = 1;
         }
         else
         {
            _loc4_ = _model.getTimesToGrown(_positon);
         }
         GameInSocketOut.sendMoneyTreeSpeedUp(param1,_loc4_,param3);
      }
      
      public function requirePick(param1:int) : void
      {
         if(model == null)
         {
            return;
         }
         if(model.getInfoAt(param1).isGrown)
         {
            dispatchEvent(new CEvent("mt_pick_movie",param1));
            GameInSocketOut.sendMoneyTreePick(param1);
         }
      }
      
      public function requireUpdateInfo() : void
      {
         GameInSocketOut.sendMoneyTreeRequireInfo();
      }
      
      private function requireSendRedPkg(param1:Array) : void
      {
         if(param1.length != 0)
         {
            GameInSocketOut.sendMoneyTreeSendRedPackage(param1);
         }
      }
      
      public function get isShowNPC() : Boolean
      {
         return true;
      }
   }
}
