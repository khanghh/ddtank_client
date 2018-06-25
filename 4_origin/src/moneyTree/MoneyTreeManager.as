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
      
      public function MoneyTreeManager(single:inner)
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
         var lv1:int = 296;
         var lv21:int = 1;
         SocketManager.Instance.addEventListener(PkgEvent.format(lv1,lv21),onPkgUpdateInfo);
         var lv22:int = 3;
         SocketManager.Instance.addEventListener(PkgEvent.format(lv1,lv22),onPkgSendRedPkg);
         var lv23:int = 2;
         SocketManager.Instance.addEventListener(PkgEvent.format(lv1,lv23),onPkgSpeedUp);
         _model.addEventListener("mt_timer",onTimer);
      }
      
      protected function onTimer(e:Event) : void
      {
         dispatchEvent(new CEvent("mt_update_timer"));
      }
      
      public function onPkgUpdateInfo(e:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = e.pkg;
         _model.setNumRedPkgRemain(pkg.readInt());
         _model.resetWillSendNum();
         for(i = 0; i < 4; )
         {
            _model.setInfoAt(i,pkg.readDate(),pkg.readInt());
            i++;
         }
         dispatchEvent(new CEvent("mt_update_info"));
         dispatchEvent(new CEvent("mt_reset_friends_list"));
      }
      
      public function onPkgSendRedPkg(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _model.setNumRedPkgRemain(pkg.readInt());
         _model.resetWillSendNum();
         dispatchEvent(new CEvent("mt_update_remain"));
         dispatchEvent(new CEvent("mt_reset_friends_list"));
      }
      
      public function onPkgSpeedUp(e:PkgEvent) : void
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
      
      public function inviteBtnClicked($id:int, type:String) : void
      {
         var _loc3_:* = type;
         if("invite" !== _loc3_)
         {
            if("unInvite" === _loc3_)
            {
               _model.reduceFriendsToSend($id);
            }
         }
         else
         {
            _model.addFriendsToSend($id);
         }
         dispatchEvent(new CEvent("mt_set_focus"));
      }
      
      public function sendRedPkgBtnClicked() : void
      {
         var msg:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var list:Array = _model.getFriendsToSendList();
         if(list.length == 0)
         {
            msg = LanguageMgr.GetTranslation("moneytree.noneFriendSelected");
            MessageTipManager.getInstance().show(msg,0,false,1);
         }
         else
         {
            requireSendRedPkg(_model.getFriendsToSendList());
         }
         _model.resetWillSendNum();
         dispatchEvent(new CEvent("mt_reset_friends_list"));
         dispatchEvent(new CEvent("mt_set_focus"));
      }
      
      public function pick($index:int) : void
      {
         requirePick($index);
      }
      
      public function becomeMature() : void
      {
         dispatchEvent(new CEvent("mt_update_info"));
      }
      
      public function onSpeedUpTypeSelected() : int
      {
         return _model.getCurSlctTimesSpeedUpToMature(_positon);
      }
      
      public function onSpeedUpClick(index:int) : void
      {
         var moneyNeeded:* = NaN;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _positon = index;
         if(!_showAgain)
         {
            moneyNeeded = 0;
            _TempShowAgain = _showAgain;
            _showAgain = true;
            if(_type == 0)
            {
               moneyNeeded = Number(_model.getPriceSpeedUp(_positon));
            }
            else
            {
               moneyNeeded = Number(_model.getPriceSpeedUp(_positon) * _model.getTimesToGrown(_positon));
            }
            CheckMoneyUtils.instance.checkMoney(_isBind,moneyNeeded,onCheckComplete);
            return;
         }
         var msg:String = getCurSpeedUpOnce();
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"moneyTree.confirmView",60,false,0);
         frame.addEventListener("response",confirmResponse);
      }
      
      public function get positon() : int
      {
         return _positon;
      }
      
      private function confirmResponse(e:FrameEvent) : void
      {
         var moneyNeeded:* = NaN;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",confirmResponse);
         _type = frame["type"];
         _TempShowAgain = !frame["isNoPrompt"];
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            moneyNeeded = 0;
            if(_type == 0)
            {
               moneyNeeded = Number(_model.getPriceSpeedUp(_positon));
            }
            else
            {
               moneyNeeded = Number(_model.getPriceSpeedUp(_positon) * _model.getTimesToGrown(_positon));
            }
            CheckMoneyUtils.instance.checkMoney(_isBind,moneyNeeded,onCheckComplete);
         }
         frame.dispose();
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
         var lv1:int = 296;
         var lv21:int = 1;
         SocketManager.Instance.removeEventListener(PkgEvent.format(lv1,lv21),onPkgUpdateInfo);
         var lv22:int = 3;
         SocketManager.Instance.removeEventListener(PkgEvent.format(lv1,lv22),onPkgSendRedPkg);
         var lv23:int = 2;
         SocketManager.Instance.removeEventListener(PkgEvent.format(lv1,lv23),onPkgSpeedUp);
      }
      
      private function requireSpeedUp(position:int, type:int, bind:Boolean) : void
      {
         var __times:int = 0;
         if(type == 0)
         {
            __times = 1;
         }
         else
         {
            __times = _model.getTimesToGrown(_positon);
         }
         GameInSocketOut.sendMoneyTreeSpeedUp(position,__times,bind);
      }
      
      public function requirePick(_index:int) : void
      {
         if(model == null)
         {
            return;
         }
         if(model.getInfoAt(_index).isGrown)
         {
            dispatchEvent(new CEvent("mt_pick_movie",_index));
            GameInSocketOut.sendMoneyTreePick(_index);
         }
      }
      
      public function requireUpdateInfo() : void
      {
         GameInSocketOut.sendMoneyTreeRequireInfo();
      }
      
      private function requireSendRedPkg(sendList:Array) : void
      {
         if(sendList.length != 0)
         {
            GameInSocketOut.sendMoneyTreeSendRedPackage(sendList);
         }
      }
      
      public function get isShowNPC() : Boolean
      {
         return true;
      }
   }
}
