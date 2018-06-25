package game.objects{   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.ColorTransform;   import flash.utils.Timer;   import labyrinth.LabyrinthManager;      public class TransmissionGate extends SimpleObject implements Disposeable, ITipedDisplay   {                   private var _lightColor:ColorTransform;            private var _normalColor:ColorTransform;            protected var _tipData:Object;            protected var _tipDirction:String;            protected var _tipGapV:int;            protected var _tipGapH:int;            protected var _tipStyle:String;            private var _timer:Timer;            public function TransmissionGate(id:int, type:int, model:String, action:String) { super(null,null,null,null); }
            protected function __timerComplete(event:TimerEvent) : void { }
            override protected function creatMovie(model:String) : void { }
            protected function __onClick(event:MouseEvent) : void { }
            protected function __onOut(event:MouseEvent) : void { }
            protected function __onOver(event:MouseEvent) : void { }
            override public function dispose() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}