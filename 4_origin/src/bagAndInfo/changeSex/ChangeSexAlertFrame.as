package bagAndInfo.changeSex
{
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   
   public class ChangeSexAlertFrame extends SimpleAlert
   {
       
      
      private var _bagType:int;
      
      private var _place:int;
      
      public function ChangeSexAlertFrame()
      {
         super();
      }
      
      public function get bagType() : int
      {
         return _bagType;
      }
      
      public function set bagType(value:int) : void
      {
         _bagType = value;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(value:int) : void
      {
         _place = value;
      }
   }
}
