package ddt.view
{
   import com.pickgliss.ui.controls.SimpleDropListTarget;
   
   public class FriendDropListTarget extends SimpleDropListTarget
   {
       
      
      public function FriendDropListTarget()
      {
         super();
      }
      
      override public function setValue(value:*) : void
      {
         if(value)
         {
            text = value.NickName;
         }
      }
   }
}
