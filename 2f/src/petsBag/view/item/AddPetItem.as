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
      
      public function AddPetItem(param1:PetInfo){super();}
      
      protected function initView() : void{}
      
      protected function __petIconLoadComplete(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
