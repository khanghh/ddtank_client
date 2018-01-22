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
      
      public function CastellanView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.cityBattle.bg1");
         addChild(_bg);
         building1 = new CastellanBuilding(1);
         addChild(building1);
         PositionUtils.setPos(building1,"castellan.building1Pos");
         building2 = new CastellanBuilding(2);
         addChild(building2);
         PositionUtils.setPos(building2,"castellan.building2Pos");
         building3 = new CastellanBuilding(3);
         addChild(building3);
         PositionUtils.setPos(building3,"castellan.building3Pos");
         building4 = new CastellanBuilding(4);
         addChild(building4);
         PositionUtils.setPos(building4,"castellan.building4Pos");
         building5 = new CastellanBuilding(5);
         addChild(building5);
         PositionUtils.setPos(building5,"castellan.building5Pos");
         building7 = new CastellanBuilding(7);
         addChild(building7);
         PositionUtils.setPos(building7,"castellan.building7Pos");
         building6 = new CastellanBuilding(6);
         addChild(building6);
         PositionUtils.setPos(building6,"castellan.building6Pos");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(building1);
         building1 = null;
         ObjectUtils.disposeObject(building2);
         building2 = null;
         ObjectUtils.disposeObject(building3);
         building3 = null;
         ObjectUtils.disposeObject(building4);
         building4 = null;
         ObjectUtils.disposeObject(building5);
         building5 = null;
         ObjectUtils.disposeObject(building6);
         building6 = null;
         ObjectUtils.disposeObject(building7);
         building7 = null;
      }
   }
}
