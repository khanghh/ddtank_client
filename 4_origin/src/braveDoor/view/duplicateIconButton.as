package braveDoor.view
{
   import BraveDoor.data.DuplicateInfo;
   import com.pickgliss.ui.controls.BaseButton;
   
   public class duplicateIconButton extends BaseButton
   {
       
      
      private var _info:DuplicateInfo;
      
      public function duplicateIconButton(info:DuplicateInfo)
      {
         _info = info;
         super();
      }
      
      public function get info() : DuplicateInfo
      {
         return _info;
      }
      
      override public function dispose() : void
      {
         _info = null;
         super.dispose();
      }
   }
}
