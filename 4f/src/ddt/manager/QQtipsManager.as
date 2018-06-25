package ddt.manager{   import com.pickgliss.ui.ComponentFactory;   import ddt.events.PkgEvent;   import ddt.view.qqTips.QQTipsInfo;   import ddt.view.qqTips.QQTipsView;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.KeyboardEvent;   import road7th.comm.PackageIn;      public class QQtipsManager extends EventDispatcher   {            private static var _instance:QQtipsManager;            public static const COLSE_QQ_TIPSVIEW:String = "Close_QQ_tipsView";                   private var _qqInfoList:Vector.<QQTipsInfo>;            private var _isShowTipNow:Boolean;            public var isGotoShop:Boolean = false;            public var indexCurrentShop:int;            public function QQtipsManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : QQtipsManager { return null; }
            public function setup() : void { }
            private function initEvents() : void { }
            private function __keyDown(e:KeyboardEvent) : void { }
            private function __getInfo(e:PkgEvent) : void { }
            public function checkState() : void { }
            public function checkStateView(type:String) : void { }
            private function getStateAble(type:String) : Boolean { return false; }
            private function __showQQTips() : void { }
            public function set isShowTipNow(value:Boolean) : void { }
            public function get isShowTipNow() : Boolean { return false; }
            public function gotoShop(index:int) : void { }
   }}