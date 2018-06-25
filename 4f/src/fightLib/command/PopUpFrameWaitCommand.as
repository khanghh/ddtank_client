package fightLib.command{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import fightLib.view.FightLibAlertView;      public class PopUpFrameWaitCommand extends WaittingCommand   {                   private var _frame:FightLibAlertView;            public function PopUpFrameWaitCommand(infoString:String, $finishFun:Function, okLabel:String = "", okFun:Function = null, cancelLabel:String = "", cancelFun:Function = null, showOkBtn:Boolean = true, showCancelBtn:Boolean = false) { super(null); }
            override public function excute() : void { }
            override public function undo() : void { }
            override public function finish() : void { }
            override public function dispose() : void { }
   }}