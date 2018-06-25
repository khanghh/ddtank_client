package sevenDayTarget.controller{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.loader.UIModuleLoader;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;   import godsRoads.manager.GodsRoadsManager;   import road7th.comm.PackageIn;   import sevenDayTarget.dataAnalyzer.SevenDayTargetDataAnalyzer;   import sevenDayTarget.model.NewTargetQuestionInfo;   import sevenDayTarget.model.SevenDayTargetModel;   import sevenDayTarget.view.SevenDayTargetMainView;      public class SevenDayTargetManager extends EventDispatcher   {            private static var _instance:SevenDayTargetManager;            public static var loadComplete:Boolean = false;                   private var _model:SevenDayTargetModel;            private var _isShowIcon:Boolean;            private var _sevenDayTargetView:SevenDayTargetMainView;            public var today:int = 1;            public var questionTemple:Array;            public var isHallAct:Boolean = false;            public function SevenDayTargetManager() { super(); }
            public static function get Instance() : SevenDayTargetManager { return null; }
            public function setup() : void { }
            private function _dataReciver(e:Event) : void { }
            public function get isShowIcon() : Boolean { return false; }
            public function hide() : void { }
            public function onClickSevenDayTargetIcon() : void { }
            private function __delayLoading(e:TimerEvent) : void { }
            protected function __onClose(event:Event) : void { }
            private function __progressShow(event:UIModuleEvent) : void { }
            private function __completeShow(event:UIModuleEvent) : void { }
            private function showSevenDayTargetMainView() : void { }
            public function templateDataSetup(analyzer:DataAnalyzer) : void { }
            public function getQuestionInfoFromTemple(questionInfo:NewTargetQuestionInfo) : NewTargetQuestionInfo { return null; }
            private function openOrclose(pkg:PackageIn) : void { }
            private function enterView(pkg:PackageIn) : void { }
            private function pkgHandler(event:CrazyTankSocketEvent) : void { }
            private function updateView(pkg:PackageIn) : void { }
            private function updateQuestionInfoArr(questionID:int, success:Boolean, isComplete:Boolean) : void { }
            public function get model() : SevenDayTargetModel { return null; }
   }}