package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class PetSmallItem extends Sprite implements Disposeable
   {
      
      public static const PET_ITEM_WIDTH:int = 78;
       
      
      protected var _bg:DisplayObject;
      
      protected var _info:PetInfo;
      
      protected var _petIcon:BitmapLoaderProxy;
      
      protected var _isFight:Boolean = false;
      
      protected var _fightIcon:Bitmap;
      
      private var _isSelect:Boolean = false;
      
      protected var _shiner:DisplayObject;
      
      public function PetSmallItem(param1:PetInfo = null)
      {
         super();
         this.buttonMode = true;
         this.useHandCursor = true;
         _info = param1;
         initView();
         initEvent();
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",clickHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",clickHandler);
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         selected = !selected;
      }
      
      public function get info() : PetInfo
      {
         return _info;
      }
      
      public function set info(param1:PetInfo) : void
      {
         if(_petIcon)
         {
            _petIcon.removeEventListener("loadingFinish",__fixPetIconPostion);
            _petIcon.dispose();
            _petIcon = null;
         }
         isFight = false;
         _shiner.visible = false;
         _info = param1;
         if(_info)
         {
            _petIcon = new BitmapLoaderProxy(PathManager.solvePetIconUrl(PetsBagManager.instance().getPicStrByLv(_info)),null,true);
            _petIcon.addEventListener("loadingFinish",__fixPetIconPostion);
            addChildAt(_petIcon,2);
            isFight = _info.IsEquip;
         }
      }
      
      private function __fixPetIconPostion(param1:Event) : void
      {
         if(_petIcon)
         {
            _petIcon.x = 64 - _petIcon.width >> 1;
            _petIcon.y = 59 - _petIcon.height >> 1;
         }
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("assets.petsBag.petPnlBg");
         addChildAt(_bg,0);
         _shiner = ComponentFactory.Instance.creat("petsBag.light");
         addChild(_shiner);
         _shiner.visible = false;
         if(_info)
         {
            _petIcon = new BitmapLoaderProxy(PathManager.solvePetIconUrl(PetsBagManager.instance().getPicStrByLv(_info)),null,true);
            _petIcon.addEventListener("loadingFinish",__fixPetIconPostion);
            addChild(_petIcon);
            isFight = _info.IsEquip;
         }
         _fightIcon = ComponentFactory.Instance.creatBitmap("assets.petsBag.fight2");
         addChild(_fightIcon);
         _fightIcon.visible = false;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         _isFight = param1;
         _fightIcon.visible = _isFight;
         addChild(_fightIcon);
      }
      
      public function set selected(param1:Boolean) : void
      {
         _isSelect = param1;
         _shiner.visible = _isSelect;
         dispatchEvent(new Event("selected"));
      }
      
      public function get selected() : Boolean
      {
         return _isSelect;
      }
      
      public function dispose() : void
      {
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
            _shiner = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_petIcon)
         {
            _petIcon.removeEventListener("loadingFinish",__fixPetIconPostion);
            ObjectUtils.disposeObject(_petIcon);
            _petIcon = null;
         }
         if(_fightIcon)
         {
            ObjectUtils.disposeObject(_fightIcon);
            _fightIcon = null;
         }
         _info = null;
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
            _shiner = null;
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
