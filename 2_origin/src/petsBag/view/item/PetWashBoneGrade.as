package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class PetWashBoneGrade extends Sprite implements Disposeable
   {
       
      
      private var _levBg:Bitmap;
      
      private var _gradeImg:ScaleFrameImage;
      
      public function PetWashBoneGrade()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _levBg = ComponentFactory.Instance.creat("asset.petsBage.washBone.levBg");
         addChild(_levBg);
         _gradeImg = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.petGrade");
         addChild(_gradeImg);
         _gradeImg.setFrame(0);
      }
      
      public function set info(petInfo:PetInfo) : void
      {
         if(petInfo == null)
         {
            return;
         }
         var index:int = PetsBagManager.instance().getPetQualityIndex(petInfo.petGraded);
         _gradeImg.setFrame(index + 1);
         var xOffset:* = _levBg.width - _gradeImg.width >> 1;
         _gradeImg.x = xOffset;
         _gradeImg.y = 3;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_levBg);
         _levBg = null;
         ObjectUtils.disposeObject(_gradeImg);
         _gradeImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
