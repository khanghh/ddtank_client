package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.view.item.PetSmallItem;
   
   public class PetMoveScroll extends Sprite implements Disposeable
   {
      
      public static const PET_MOVE:String = "PetMove";
       
      
      private var itemContainer:HBox;
      
      private const SPACE:int = 5;
      
      private const SHOW_PET_COUNT:int = 5;
      
      private var _currentShowIndex:int = 0;
      
      private var _isMove:Boolean = false;
      
      private var _petsImgVec:Vector.<PetSmallItem>;
      
      public var currentPet:PetSmallItem;
      
      private var _leftBtn:SimpleBitmapButton;
      
      private var _rightBtn:SimpleBitmapButton;
      
      private var _petBg:Sprite;
      
      private var _petBg2:DisplayObject;
      
      private var _petBg0:DisplayObject;
      
      private var _infoPlayer:PlayerInfo;
      
      private var _selectedIndex:int = -1;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      public function PetMoveScroll(){super();}
      
      public function set infoPlayer(param1:PlayerInfo) : void{}
      
      public function refreshPetInfo(param1:PetInfo, param2:int = 0) : void{}
      
      private function removePetPageUpdate() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      public function updateSelect() : void{}
      
      public function get selectedIndex() : int{return 0;}
      
      public function get currentPage() : int{return 0;}
      
      private function removeEvent() : void{}
      
      private function __left(param1:MouseEvent) : void{}
      
      private function __right(param1:MouseEvent) : void{}
      
      private function upCells(param1:int = 0) : void{}
      
      public function dispose() : void{}
   }
}
