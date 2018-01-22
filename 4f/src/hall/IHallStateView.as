package hall
{
   import com.pickgliss.ui.controls.container.GridBox;
   
   public interface IHallStateView
   {
       
      
      function get leftTopGbox() : GridBox;
      
      function arrangeLeftGrid() : void;
      
      function hideRightGrid() : void;
      
      function showRightGrid() : void;
   }
}
