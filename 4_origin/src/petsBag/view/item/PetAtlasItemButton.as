package petsBag.view.item
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import pet.data.PetInfo;
   import petsBag.data.PetAtlasInfo;
   
   public class PetAtlasItemButton extends PetSmallItemButton
   {
       
      
      private var _image:Bitmap;
      
      private var _atlasInfo:PetAtlasInfo;
      
      public function PetAtlasItemButton(param1:PetInfo = null)
      {
         super(param1);
         tipStyle = "petsBag.view.item.PetAtlasTips";
         tipDirctions = "2,7,5,1,6,4";
      }
      
      public function setAtlasInfo(param1:PetAtlasInfo, param2:PetInfo = null) : void
      {
         if(param1 != null)
         {
            setButtonStyleName(null);
         }
         _atlasInfo = param1;
         if(_atlasInfo)
         {
            if(param2 != null)
            {
               _star.starNum(param2.StarLevel,"assets.petsBag.starSmall");
               _atlasInfo.isActivate = true;
               _atlasInfo.level = param2.Level;
               .super.superInfo = param2;
            }
            else
            {
               _star.starNum(1,"assets.petsBag.starSmall");
               loadPetImage();
            }
            _star.x = (this.width - _star.width) / 2 - 5;
            tipData = _atlasInfo;
            ShowTipManager.Instance.addTip(this);
         }
         else
         {
            _star.starNum(0,"assets.petsBag.starSmall");
            tipData = null;
         }
      }
      
      private function loadPetImage() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(petImagePath(),0);
         _loc1_.addEventListener("complete",__onComplete);
         LoadResourceManager.Instance.startLoad(_loc1_,true);
      }
      
      private function __onComplete(param1:LoaderEvent) : void
      {
         var _loc2_:BitmapLoader = param1.loader as BitmapLoader;
         _loc2_.removeEventListener("complete",__onComplete);
         if(_loc2_.content)
         {
            if(_image)
            {
               ObjectUtils.disposeObject(_image);
            }
            if(_bg != null)
            {
               _image = new Bitmap(_loc2_.bitmapData);
               _image.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _image.x = (_bg.width - _image.width) / 2 + _bg.x;
               _image.y = (_bg.height - _image.height) / 2 + _bg.y;
               addChild(_image);
            }
         }
      }
      
      private function petImagePath() : String
      {
         return PathManager.SITE_MAIN + "image/petAtlas/" + _atlasInfo.ID + "/icon.png";
      }
      
      override public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         super.dispose();
      }
   }
}
