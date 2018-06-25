package road7th.utils{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.getTimer;      public class AutoDisappear extends Sprite implements Disposeable   {                   private var _life:Number;            private var _age:Number;            private var _last:Number;            public function AutoDisappear(movie:DisplayObject, life:Number = -1) { super(); }
            private function __addToStage(event:Event) : void { }
            private function __enterFrame(event:Event) : void { }
            public function dispose() : void { }
   }}