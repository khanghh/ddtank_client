package character.action{   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.utils.getQualifiedClassName;      public class MovieClipAction extends BaseAction   {                   public function MovieClipAction(movieclip:MovieClip, name:String = "", nextAction:String = "", priority:uint = 0, endStop:Boolean = false) { super(null,null,null,null); }
            override public function get isEnd() : Boolean { return false; }
            override public function reset() : void { }
            public function set asset(value:DisplayObject) : void { }
            override public function toXml() : XML { return null; }
   }}