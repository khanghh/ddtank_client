package godCardRaise{   import com.pickgliss.ui.controls.BaseButton;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.HelperDataModuleLoad;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;   import godCardRaise.analyzer.GodCardListAnalyzer;   import godCardRaise.analyzer.GodCardListGroupAnalyzer;   import godCardRaise.analyzer.GodCardPointRewardListAnalyzer;   import godCardRaise.info.GodCardListGroupInfo;   import godCardRaise.info.GodCardListInfo;   import godCardRaise.info.GodCardPointRewardListInfo;   import godCardRaise.model.GodCardRaiseModel;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class GodCardRaiseManager extends EventDispatcher   {            public static const SHOW_VIEW:String = "godCardRaise_show_view";            public static const OPEN_CARD:String = "openCard";            public static const OPERATE_CARD:String = "operateCard";            public static const EXCHANGE:String = "exchange";            public static const AWARD_INFO:String = "awardInfo";            public static const CLOSE_VIEW:String = "closeView";            private static var _instance:GodCardRaiseManager;                   private var _isOpen:Boolean = false;            private var _icon:BaseButton;            private var _dateEnd:Date;            private var _model:GodCardRaiseModel;            private var _godCardListInfoList:Dictionary;            private var _godCardListGroupInfoList:Array;            private var _godCardPointRewardListList:Vector.<GodCardPointRewardListInfo>;            public var notShowAlertAgain:Boolean;            public var buyIsBind:Boolean = true;            private var _doubleTime:Date;            public function GodCardRaiseManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : GodCardRaiseManager { return null; }
            public function setup() : void { }
            private function initEvent() : void { }
            private function test() : void { }
            protected function onIsOpen(e:PkgEvent) : void { }
            private function onInit(e:PkgEvent) : void { }
            private function onOpenCard(e:PkgEvent) : void { }
            private function onOperateCard(e:PkgEvent) : void { }
            private function onExchange(e:PkgEvent) : void { }
            private function onPointAwardAttribute(e:PkgEvent) : void { }
            public function getMyCardCount(cardID:int = 0) : int { return 0; }
            private function onAwardInfo(e:PkgEvent) : void { }
            public function loadGodCardListTemplate(anlyzer:GodCardListAnalyzer) : void { }
            public function loadGodCardListGroup(anlyzer:GodCardListGroupAnalyzer) : void { }
            public function loadGodCardPointRewardList(anlyzer:GodCardPointRewardListAnalyzer) : void { }
            public function get godCardListInfoList() : Dictionary { return null; }
            public function getGodCardListInfoListByLevel(level:int) : Array { return null; }
            public function get godCardListGroupInfoList() : Array { return null; }
            public function getGodCardListGroupInfo(groupId:int) : GodCardListGroupInfo { return null; }
            public function get godCardPointRewardList() : Vector.<GodCardPointRewardListInfo> { return null; }
            public function calculateExchangeCount(groupInfo:GodCardListGroupInfo) : int { return 0; }
            public function checkIcon() : void { }
            private function showIcon() : void { }
            private function hideIcon() : void { }
            public function show() : void { }
            private function loadShowFrameData() : void { }
            public function get dataEnd() : Date { return null; }
            public function get model() : GodCardRaiseModel { return null; }
            public function get doubleTime() : Number { return 0; }
   }}