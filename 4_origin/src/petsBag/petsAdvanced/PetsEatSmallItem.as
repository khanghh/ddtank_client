package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import pet.data.PetInfo;
   import petsBag.view.item.PetSmallItem;
   
   public class PetsEatSmallItem extends PetSmallItem implements Disposeable
   {
       
      
      private var starMc:MovieClip;
      
      private var _tipStyle:String;
      
      private var _tipData:Object;
      
      private var _tipDirctions:String;
      
      private var _tipGapV:int;
      
      private var _tipGapH:int;
      
      public function PetsEatSmallItem(info:PetInfo = null)
      {
         super(info);
      }
      
      public function initTips() : void
      {
         tipStyle = "petsBag.petsAdvanced.PetAttributeTip";
         tipDirctions = "6";
      }
      
      override protected function initView() : void
      {
         super.initView();
         starMc = ComponentFactory.Instance.creat("assets.PetsBag.eatPets.starMc");
         starMc.x = 31;
         starMc.y = 67;
         addChild(starMc);
         starMc.gotoAndStop(1);
      }
      
      override public function set info(value:PetInfo) : void
      {
         .super.info = value;
         tipData = value;
         starMc.gotoAndStop(_info.StarLevel);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(starMc)
         {
            ObjectUtils.disposeObject(starMc);
            starMc = null;
         }
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipStyle(value:String) : void
      {
         if(_tipStyle == value)
         {
            return;
         }
         _tipStyle = value;
      }
      
      public function set tipData(value:Object) : void
      {
         if(_tipData == value)
         {
            return;
         }
         _tipData = value;
      }
      
      public function set tipDirctions(value:String) : void
      {
         if(_tipDirctions == value)
         {
            return;
         }
         _tipDirctions = value;
      }
      
      public function set tipGapV(value:int) : void
      {
         if(_tipGapV == value)
         {
            return;
         }
         _tipGapV = value;
      }
      
      public function set tipGapH(value:int) : void
      {
         if(_tipGapH == value)
         {
            return;
         }
         _tipGapH = value;
      }
   }
}
