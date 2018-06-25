package starling.events{   public class EnterFrameEvent extends Event   {            public static const ENTER_FRAME:String = "enterFrame";                   public function EnterFrameEvent(type:String, passedTime:Number, bubbles:Boolean = false) { super(null,null,null); }
            public function get passedTime() : Number { return 0; }
   }}