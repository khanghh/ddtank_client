package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.PathManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class RoomPlayerItemPet extends Sprite implements Disposeable
   {
       
      
      private var _petLevel:FilterFrameText;
      
      private var _petInfo:PetInfo;
      
      private var _headPetWidth:Number;
      
      private var _headPetHight:Number;
      
      private var _excursion:Number = 3;
      
      private var _icons:Dictionary;
      
      public function RoomPlayerItemPet(w:Number = 0, h:Number = 0)
      {
         super();
         _headPetWidth = w;
         _headPetHight = h;
         _icons = new Dictionary();
         _petLevel = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.petLevelTxt");
         addChild(_petLevel);
      }
      
      private function createPetIcon() : void
      {
         var petIcon:BitmapLoaderProxy = new BitmapLoaderProxy(PathManager.solvePetIconUrl(PetsBagManager.instance().getPicStrByLv(_petInfo)),null,true);
         petIcon.addEventListener("loadingFinish",__iconLoadingFinish);
         _icons[_petInfo.ID] = petIcon;
      }
      
      public function updateView(value:PetInfo) : void
      {
         _petInfo = value;
         iconvisible();
         if(_petInfo)
         {
            if(_icons[_petInfo.ID])
            {
               _icons[_petInfo.ID].visible = true;
            }
            else
            {
               createPetIcon();
            }
            _petLevel.text = "LV:" + _petInfo.Level;
         }
         else
         {
            _petLevel.text = "";
         }
      }
      
      private function iconvisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _icons;
         for each(var petIcon in _icons)
         {
            if(petIcon)
            {
               petIcon.visible = false;
            }
         }
      }
      
      private function __iconLoadingFinish(e:Event) : void
      {
         var petIcon:BitmapLoaderProxy = e.target as BitmapLoaderProxy;
         petIcon.removeEventListener("loadingFinish",__iconLoadingFinish);
         petIcon.scaleX = 0.7;
         petIcon.scaleY = 0.7;
         petIcon.x = (_headPetWidth - petIcon.width) / 2 + _excursion;
         petIcon.y = (_headPetHight - petIcon.height) / 2;
         addChildAt(petIcon,0);
         _petLevel.x = petIcon.x + (petIcon.width - _petLevel.width) / 2;
         _petLevel.y = _headPetHight - _petLevel.height;
      }
      
      public function dispose() : void
      {
         if(_petLevel)
         {
            ObjectUtils.disposeObject(_petLevel);
         }
         _petLevel = null;
         var _loc3_:int = 0;
         var _loc2_:* = _icons;
         for each(var petIcon in _icons)
         {
            if(petIcon)
            {
               ObjectUtils.disposeObject(petIcon);
            }
            petIcon = null;
         }
         _icons = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
