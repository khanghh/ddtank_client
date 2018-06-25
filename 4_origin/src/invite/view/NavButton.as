package invite.view
{
   import com.pickgliss.ui.controls.BaseButton;
   
   public class NavButton extends BaseButton
   {
       
      
      private var _selected:Boolean = false;
      
      public function NavButton()
      {
         super();
         mouseChildren = false;
      }
      
      override protected function addEvent() : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(val:Boolean) : void
      {
         if(_selected != val)
         {
            _selected = val;
            if(_selected)
            {
               setFrame(2);
            }
            else
            {
               setFrame(1);
            }
         }
      }
   }
}
