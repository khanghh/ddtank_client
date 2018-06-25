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
      
      public function PetAtlasItemButton(info:PetInfo = null)
      {
         super(info);
         tipStyle = "petsBag.view.item.PetAtlasTips";
         tipDirctions = "2,7,5,1,6,4";
      }
      
      public function setAtlasInfo(value:PetAtlasInfo, petInfo:PetInfo = null) : void
      {
         if(value != null)
         {
            setButtonStyleName(null);
         }
         _atlasInfo = value;
         if(_atlasInfo)
         {
            if(petInfo != null)
            {
               _star.starNum(petInfo.StarLevel,"assets.petsBag.starSmall");
               _atlasInfo.isActivate = true;
               _atlasInfo.level = petInfo.Level;
               .super.superInfo = petInfo;
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
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(petImagePath(),0);
         loader.addEventListener("complete",__onComplete);
         LoadResourceManager.Instance.startLoad(loader,true);
      }
      
      private function __onComplete(e:LoaderEvent) : void
      {
         var loader:BitmapLoader = e.loader as BitmapLoader;
         loader.removeEventListener("complete",__onComplete);
         if(loader.content)
         {
            if(_image)
            {
               ObjectUtils.disposeObject(_image);
            }
            if(_bg != null)
            {
               _image = new Bitmap(loader.bitmapData);
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
