package fightLib.command{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import fightLib.view.FightLibAlertView;      public class PopupFrameCommand extends BaseFightLibCommand   {                   private var _frame:FightLibAlertView;            private var _callBack:Function;            private var _okLable:String;            private var _cancelLabel:String;            private var _cancelFunc:Function;            public function PopupFrameCommand(infoString:String, okLabel:String = "", okCallBack:Function = null, cancelLabel:String = "", cancelCallBack:Function = null, showOkBtn:Boolean = true, showCancelBtn:Boolean = false, WeaponArr:Array = null) { super(); }
            override public function excute() : void { }
            override public function finish() : void { }
            override public function undo() : void { }
            override public function dispose() : void { }
   }}