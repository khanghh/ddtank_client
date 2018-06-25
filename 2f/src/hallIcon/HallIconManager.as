package hallIcon{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import firstRecharge.FirstRechargeManger;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import hallIcon.event.HallIconEvent;   import hallIcon.info.HallIconInfo;   import hallIcon.model.HallIconModel;   import kingBless.KingBlessManager;   import worldboss.WorldBossManager;      public class HallIconManager extends EventDispatcher   {            public static var ISLEAGUE:Boolean;            private static var _instance:HallIconManager;                   public var model:HallIconModel;            public function HallIconManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : HallIconManager { return null; }
            public function setup() : void { }
            public function checkDefaultIconShow() : void { }
            public function checkIconCall() : void { }
            private function initEvent() : void { }
            private function firstRechargeOpenHandler() : void { }
            private function __vipLvlIsOpenHandler(evt:Event) : void { }
            private function cacheRightIcon($icontype:String, $iconInfo:HallIconInfo) : void { }
            public function checkCacheRightIconShow() : void { }
            public function executeCacheRightIconLevelLimit($icontype:String, $isCache:Boolean, $level:int = 0) : void { }
            private function __onPlayerPropertyChange(event:PlayerPropertyEvent) : void { }
            public function updateSwitchHandler($icontype:String, $isopen:Boolean, $timemsg:String = null, $num:int = -1, $timeShow:Boolean = false) : void { }
            private function convertIconInfo($icontype:String, $isopen:Boolean, $timemsg:String, $num:int, $timeShow:Boolean) : HallIconInfo { return null; }
            public function showCommonFrame($content:DisplayObject, $titleLink:String = "", $width:Number = 530, $height:Number = 545) : Frame { return null; }
            private function __commonFrameResponse(evt:FrameEvent) : void { }
            public function checkHallIconExperienceTask($isCompleted:Boolean = true) : void { }
            public function checkCacheRightIconTask() : void { }
   }}