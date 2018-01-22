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
      
      public function PetsEatSmallItem(param1:PetInfo = null){super(null);}
      
      public function initTips() : void{}
      
      override protected function initView() : void{}
      
      override public function set info(param1:PetInfo) : void{}
      
      override public function dispose() : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function get tipData() : Object{return null;}
      
      public function get tipDirctions() : String{return null;}
      
      public function get tipGapV() : int{return 0;}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function set tipData(param1:Object) : void{}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function set tipGapV(param1:int) : void{}
      
      public function set tipGapH(param1:int) : void{}
   }
}
