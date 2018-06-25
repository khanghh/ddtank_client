package invite.view{   import com.pickgliss.ui.controls.BaseButton;      public class NavButton extends BaseButton   {                   private var _selected:Boolean = false;            public function NavButton() { super(); }
            override protected function addEvent() : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(val:Boolean) : void { }
   }}