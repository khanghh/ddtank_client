package road7th.utils{   import bones.display.BoneMovieStarling;   import com.pickgliss.utils.StarlingObjectUtils;   import dragonBones.events.AnimationEvent;   import flash.utils.getTimer;   import starling.display.DisplayObject;   import starling.display.Sprite;   import starling.events.Event;      [Event(name="complete",type="starling.events.Event")]   public class AutoDisappearStarling extends Sprite   {                   private var _life:Number;            private var _age:Number;            private var _last:Number;            public function AutoDisappearStarling(movie:DisplayObject, life:Number = -1) { super(); }
            private function __onComplete(e:AnimationEvent) : void { }
            private function __addToStage(event:Event) : void { }
            private function __enterFrame(event:Event) : void { }
            override public function dispose() : void { }
   }}