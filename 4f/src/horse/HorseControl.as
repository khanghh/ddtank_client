package horse{   import com.pickgliss.events.ComponentEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import horse.data.HorsePicCherishVo;   import horse.horsePicCherish.HorsePicCherishTip;   import horse.view.HorseFrame;   import horse.view.HorseGetSkillView;   import horse.view.HorseSkillCellTip;      public class HorseControl extends EventDispatcher   {            private static var _instance:HorseControl;                   private var _horseFrame:HorseFrame;            public function HorseControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : HorseControl { return null; }
            public function setup() : void { }
            protected function __onHideView(event:Event) : void { }
            protected function __onOpenView(event:Event) : void { }
            private function frameDisposeHandler(event:ComponentEvent) : void { }
            public function closeFrame() : void { }
            public function upFloatCartoonPlayComplete() : void { }
            private function openGetNewSkillView() : void { }
            private function updateHorse() : void { }
            public function getHorsePicCherishState(id:int, templateId:int) : Array { return null; }
            public function getHorsePicCherishAddProperty(id:int) : Array { return null; }
   }}