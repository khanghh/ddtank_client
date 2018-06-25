package petsBag.view.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import pet.data.PetInfo;   import petsBag.PetsBagManager;      public class PetWashBoneGrade extends Sprite implements Disposeable   {                   private var _levBg:Bitmap;            private var _gradeImg:ScaleFrameImage;            public function PetWashBoneGrade() { super(); }
            private function initView() : void { }
            public function set info(petInfo:PetInfo) : void { }
            public function dispose() : void { }
   }}