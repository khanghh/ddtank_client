package trainer.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.core.Disposeable;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class GuideCover extends Sprite implements Disposeable   {                   private var _clickedTimes:int = 0;            public function GuideCover() { super(); }
            protected function onClick(e:MouseEvent) : void { }
            protected function onATS(e:Event) : void { }
            protected function onRFS(e:Event) : void { }
            public function dispose() : void { }
            public function dig(guideCoverType:String, args:Array) : void { }
            public function drawCover($color:uint, $alpha:Number) : void { }
            public function digCircle($x:Number, $y:Number, $radius:Number) : void { }
            public function digRect($x:Number, $y:Number, $width:Number, $height:Number) : void { }
            public function digEllipse($x:Number, $y:Number, $width:Number, $height:Number) : void { }
   }}