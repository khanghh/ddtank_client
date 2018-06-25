package newChickenBox{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ClassUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;   import newChickenBox.data.NewChickenBoxGoodsTempInfo;   import newChickenBox.events.NewChickenBoxEvents;   import newChickenBox.model.NewChickenBoxModel;   import newChickenBox.view.NewChickenBoxCell;   import newChickenBox.view.NewChickenBoxFrame;   import newChickenBox.view.NewChickenBoxItem;   import road7th.comm.PackageIn;      public class NewChickenBoxControl extends EventDispatcher   {            private static var _instance:NewChickenBoxControl = null;                   private var newChickenBoxFrame:NewChickenBoxFrame;            public var firstEnter:Boolean = true;            private var _model:NewChickenBoxModel;            private var timer:Timer;            public function NewChickenBoxControl() { super(); }
            public static function get instance() : NewChickenBoxControl { return null; }
            public function setup() : void { }
            private function init() : void { }
            private function getItem() : void { }
            private function addSocketEvent() : void { }
            private function __overshow(e:CrazyTankSocketEvent) : void { }
            private function sendAgain(e:TimerEvent) : void { }
            private function sendOverShow(e:TimerEvent) : void { }
            private function __canclick(e:PkgEvent) : void { }
            private function __showBoxFrameHandler(event:Event) : void { }
            private function __openCard(e:PkgEvent) : void { }
            private function __openEye(e:PkgEvent) : void { }
            private function __closeActivityHandler(event:Event) : void { }
            private function removeSocketEvent() : void { }
            public function get model() : NewChickenBoxModel { return null; }
   }}