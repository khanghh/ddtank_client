package gameCommon.view.prop
{
   public class SoulPropCell extends PropCell
   {
       
      
      public function SoulPropCell()
      {
         super();
         this.enabled = false;
         _tipInfo.valueType = "Psychic";
         this.setGrayFilter();
      }
      
      override public function setPossiton(param1:int, param2:int) : void
      {
         super.setPossiton(param1,param2);
         this.x = _x;
         this.y = _y;
      }
   }
}
