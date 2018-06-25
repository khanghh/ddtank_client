package petsBag.view
{
   import com.pickgliss.ui.controls.NumberSelecter;
   import flash.geom.Point;
   
   public class PetNumberSelecter extends NumberSelecter
   {
       
      
      public function PetNumberSelecter()
      {
         super();
      }
      
      override public function set valueLimit(value:String) : void
      {
         var arr:Array = value.split(",");
         _valueLimit = new Point(arr[0],arr[1]);
         currentValue = _valueLimit.y;
      }
   }
}
