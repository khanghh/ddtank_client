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
      
      public function RoomPlayerItemPet(param1:Number = 0, param2:Number = 0)
      {
         super();
         _headPetWidth = param1;
         _headPetHight = param2;
         _icons = new Dictionary();
         _petLevel = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.petLevelTxt");
         addChild(_petLevel);
      }
      
      private function createPetIcon() : void
      {
         var _loc1_:BitmapLoaderProxy = new BitmapLoaderProxy(PathManager.solvePetIconUrl(PetsBagManager.instance().getPicStrByLv(_petInfo)),null,true);
         _loc1_.addEventListener("loadingFinish",__iconLoadingFinish);
         _icons[_petInfo.ID] = _loc1_;
      }
      
      public function updateView(param1:PetInfo) : void
      {
         _petInfo = param1;
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
         for each(var _loc1_ in _icons)
         {
            if(_loc1_)
            {
               _loc1_.visible = false;
            }
         }
      }
      
      private function __iconLoadingFinish(param1:Event) : void
      {
         var _loc2_:BitmapLoaderProxy = param1.target as BitmapLoaderProxy;
         _loc2_.removeEventListener("loadingFinish",__iconLoadingFinish);
         _loc2_.scaleX = 0.7;
         _loc2_.scaleY = 0.7;
         _loc2_.x = (_headPetWidth - _loc2_.width) / 2 + _excursion;
         _loc2_.y = (_headPetHight - _loc2_.height) / 2;
         addChildAt(_loc2_,0);
         _petLevel.x = _loc2_.x + (_loc2_.width - _petLevel.width) / 2;
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
         for each(var _loc1_ in _icons)
         {
            if(_loc1_)
            {
               ObjectUtils.disposeObject(_loc1_);
            }
            _loc1_ = null;
         }
         _icons = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
