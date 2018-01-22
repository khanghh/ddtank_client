package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class AddPetItem extends Component
   {
       
      
      protected var _bg:DisplayObject;
      
      protected var _info:PetInfo;
      
      protected var _petIcon:PetSmallIcon;
      
      protected var _icon:Bitmap;
      
      protected var _star:StarBar;
      
      public function AddPetItem(param1:PetInfo)
      {
         super();
         _info = param1;
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("assets.bag.petPnlBg");
         addChild(_bg);
         if(_info)
         {
            _petIcon = new PetSmallIcon(PetsBagManager.instance().getPicStrByLv(_info));
            _petIcon.addEventListener("complete",__petIconLoadComplete);
            _petIcon.startLoad();
            _star = ComponentFactory.Instance.creat("bagAndInfo.starBar.petStar");
            addChild(_star);
            _star.starNum(_info.StarLevel,"assets.bag.star");
         }
      }
      
      protected function __petIconLoadComplete(param1:Event) : void
      {
         _petIcon.removeEventListener("complete",__petIconLoadComplete);
         _icon = _petIcon.icon;
         if(_icon)
         {
            PositionUtils.setPos(_icon,"farm.bagAndInfo.iconPos");
            addChild(_icon);
            _icon.width = 64;
            _icon.height = 64;
         }
      }
      
      override public function dispose() : void
      {
         if(_star)
         {
            ObjectUtils.disposeObject(_star);
            _star = null;
         }
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         if(_petIcon)
         {
            ObjectUtils.disposeObject(_petIcon);
            _petIcon = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         _info = null;
         super.dispose();
      }
   }
}
