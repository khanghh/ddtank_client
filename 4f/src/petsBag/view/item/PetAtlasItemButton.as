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
      
      public function PetAtlasItemButton(param1:PetInfo = null){super(null);}
      
      public function setAtlasInfo(param1:PetAtlasInfo, param2:PetInfo = null) : void{}
      
      private function loadPetImage() : void{}
      
      private function __onComplete(param1:LoaderEvent) : void{}
      
      private function petImagePath() : String{return null;}
      
      override public function dispose() : void{}
   }
}
