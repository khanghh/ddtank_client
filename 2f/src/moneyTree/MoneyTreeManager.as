package moneyTree{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.CheckMoneyUtils;   import flash.events.Event;   import moneyTree.model.MoneyTreeModel;   import road7th.comm.PackageIn;      public class MoneyTreeManager extends CoreManager   {            public static const SHOW_MAIN_FRAME:String = "mt_show_main_frame";            public static const HIDE_MAIN_FRAME:String = "mt_hide_main_frame";            public static const UPDATE_INFO:String = "mt_update_info";            public static const UPDATE_REMAIN_NUM:String = "mt_update_remain";            public static const UPDATE_TIMER:String = "mt_update_timer";            public static const RESET_FRIEND_LIST:String = "mt_reset_friends_list";            public static const PICK_MOVIE:String = "mt_pick_movie";            public static const SPEEDUP_SUC:String = "mt_speedup_suc";            public static const SET_FOCUS:String = "mt_set_focus";            private static var instance:MoneyTreeManager;                   private var _model:MoneyTreeModel;            private var _isListening:Boolean = false;            private var _type:int;            private var _positon:int;            private var _isBind:Boolean = false;            private var _showAgain:Boolean = true;            private var _TempShowAgain:Boolean = true;            public function MoneyTreeManager(single:inner) { super(); }
            public static function getInstance() : MoneyTreeManager { return null; }
            public function get model() : MoneyTreeModel { return null; }
            public function setup() : void { }
            private function addEvents() : void { }
            protected function onTimer(e:Event) : void { }
            public function onPkgUpdateInfo(e:PkgEvent) : void { }
            public function onPkgSendRedPkg(e:PkgEvent) : void { }
            public function onPkgSpeedUp(e:PkgEvent) : void { }
            public function getCurSpeedUpToMature() : String { return null; }
            public function getCurSpeedUpOnce() : String { return null; }
            public function showMainFrame() : void { }
            override protected function start() : void { }
            public function hideMainFrame() : void { }
            public function npcClicked() : void { }
            public function inviteBtnClicked($id:int, type:String) : void { }
            public function sendRedPkgBtnClicked() : void { }
            public function pick($index:int) : void { }
            public function becomeMature() : void { }
            public function onSpeedUpTypeSelected() : int { return 0; }
            public function onSpeedUpClick(index:int) : void { }
            public function get positon() : int { return 0; }
            private function confirmResponse(e:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            public function dispose() : void { }
            private function requireSpeedUp(position:int, type:int, bind:Boolean) : void { }
            public function requirePick(_index:int) : void { }
            public function requireUpdateInfo() : void { }
            private function requireSendRedPkg(sendList:Array) : void { }
            public function get isShowNPC() : Boolean { return false; }
   }}