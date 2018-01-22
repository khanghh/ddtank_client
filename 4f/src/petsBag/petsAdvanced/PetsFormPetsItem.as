package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import petsBag.data.PetsFormData;
   import petsBag.event.PetItemEvent;
   
   public class PetsFormPetsItem extends Component implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _pet:Sprite;
      
      private var _petsName:FilterFrameText;
      
      private var _followBtn:TextButton;
      
      private var _wakeBtn:TextButton;
      
      private var _callBackBtn:TextButton;
      
      private var _showBtnFlag:int;
      
      private var _info:PetsFormData;
      
      private var _itemId:int;
      
      public function PetsFormPetsItem(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function setInfo(param1:int, param2:PetsFormData) : void{}
      
      public function addPetBitmap(param1:String) : void{}
      
      protected function __onComplete(param1:LoaderEvent) : void{}
      
      protected function __onFollowClick(param1:MouseEvent) : void{}
      
      protected function __onCallBackClick(param1:MouseEvent) : void{}
      
      protected function __onWakeClick(param1:MouseEvent) : void{}
      
      protected function __onMouseClick(param1:MouseEvent) : void{}
      
      protected function __onMouseOut(param1:MouseEvent) : void{}
      
      protected function __onMouseOver(param1:MouseEvent) : void{}
      
      private function setBtnVisible(param1:Boolean) : void{}
      
      public function set showBtn(param1:int) : void{}
      
      public function get showBtn() : int{return 0;}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
      
      public function get info() : PetsFormData{return null;}
   }
}
