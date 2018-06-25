package braveDoor.view{   import BraveDoor.data.DuplicateInfo;   import com.pickgliss.ui.controls.BaseButton;      public class duplicateIconButton extends BaseButton   {                   private var _info:DuplicateInfo;            public function duplicateIconButton(info:DuplicateInfo) { super(); }
            public function get info() : DuplicateInfo { return null; }
            override public function dispose() : void { }
   }}