package ddt.action{   import com.pickgliss.action.BaseAction;      public class FrameShowAction extends BaseAction   {                   private var _frame:Object;            private var _showFun:Function;            public function FrameShowAction(frame:Object, showFun:Function = null, timeOut:uint = 0) { super(null); }
            override public function act() : void { }
   }}