package character.action{   public class SimpleFrameAction extends BaseAction   {                   private var _frames:Vector.<int>;            public function SimpleFrameAction(frames:Vector.<int>, name:String = "", nextAction:String = "", priority:uint = 0, endStop:Boolean = false) { super(null,null,null,null); }
            public function set frames(value:Vector.<int>) : void { }
            public function get frames() : Vector.<int> { return null; }
            override public function toXml() : XML { return null; }
   }}