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
      
      public function PetsEatSmallItem(param1:PetInfo = null)
      {
         super(param1);
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
      
      override public function set info(param1:PetInfo) : void
      {
         .super.info = param1;
         tipData = param1;
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
      
      public function set tipStyle(param1:String) : void
      {
         if(_tipStyle == param1)
         {
            return;
         }
         _tipStyle = param1;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(_tipData == param1)
         {
            return;
         }
         _tipData = param1;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         if(_tipDirctions == param1)
         {
            return;
         }
         _tipDirctions = param1;
      }
      
      public function set tipGapV(param1:int) : void
      {
         if(_tipGapV == param1)
         {
            return;
         }
         _tipGapV = param1;
      }
      
      public function set tipGapH(param1:int) : void
      {
         if(_tipGapH == param1)
         {
            return;
         }
         _tipGapH = param1;
      }
   }
}
