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
      
      override public function setPossiton(x:int, y:int) : void
      {
         super.setPossiton(x,y);
         this.x = _x;
         this.y = _y;
      }
   }
}
