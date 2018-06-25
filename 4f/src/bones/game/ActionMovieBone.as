package bones.game{   import com.pickgliss.utils.StarlingObjectUtils;   import road7th.utils.BoneMovieWrapper;   import starling.display.Sprite;      public class ActionMovieBone extends Sprite   {                   private var _movie:BoneMovieWrapper;            public function ActionMovieBone(styleName:String) { super(); }
            public function doAction(type:String, callBack:Function = null, args:Array = null) : void { }
            public function get boneMovie() : BoneMovieWrapper { return null; }
            public function get currentAction() : String { return null; }
            public function setActionMapping(source:String, target:String) : void { }
            override public function dispose() : void { }
   }}