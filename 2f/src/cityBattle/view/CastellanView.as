package cityBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CastellanView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var building1:CastellanBuilding;
      
      private var building2:CastellanBuilding;
      
      private var building3:CastellanBuilding;
      
      private var building4:CastellanBuilding;
      
      private var building5:CastellanBuilding;
      
      private var building6:CastellanBuilding;
      
      private var building7:CastellanBuilding;
      
      public function CastellanView(){super();}
      
      private function init() : void{}
      
      public function dispose() : void{}
   }
}
