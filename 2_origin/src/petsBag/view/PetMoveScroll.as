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
      
      public function PetMoveScroll()
      {
         super();
         _petsImgVec = new Vector.<PetSmallItem>();
         initView();
         initEvent();
      }
      
      public function set infoPlayer(param1:PlayerInfo) : void
      {
         _infoPlayer = param1;
         if(!_infoPlayer)
         {
            return;
         }
         upCells(_currentPage);
         updateSelect();
      }
      
      public function refreshPetInfo(param1:PetInfo, param2:int = 0) : void
      {
         if(param2 == 0 || param2 == 1)
         {
            _infoPlayer.pets[param1.Place] = param1;
         }
         upCells(_currentPage);
         if(param2 == 2)
         {
            removePetPageUpdate();
         }
         updateSelect();
      }
      
      private function removePetPageUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _petsImgVec;
         for each(var _loc2_ in _petsImgVec)
         {
            if(_loc2_.info)
            {
               _loc1_++;
            }
         }
         if(_loc1_ == 0)
         {
            _currentPage = _currentPage - 1 < 0?0:Number(_currentPage - 1);
            _totlePage = _infoPlayer.pets.length % 5 == 0?_infoPlayer.pets.length / 5 - 1:Number(_infoPlayer.pets.length / 5);
            upCells(_currentPage);
         }
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _petBg0 = ComponentFactory.Instance.creat("petsBag.petMoveScroll.bottomBg0");
         addChild(_petBg0);
         _petBg2 = ComponentFactory.Instance.creat("petsBag.petMoveScroll.bottomBg");
         addChild(_petBg2);
         _petBg = ComponentFactory.Instance.creat("petsBag.sprite.moveScroll");
         addChild(_petBg);
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.left");
         _leftBtn.transparentEnable = true;
         addChild(_leftBtn);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.right");
         addChild(_rightBtn);
         itemContainer = ComponentFactory.Instance.creatComponentByStylename("petsBag.petItemContainer");
         addChild(itemContainer);
         itemContainer.strictSize = 74;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new PetSmallItem();
            _petsImgVec.push(itemContainer.addChild(_loc1_));
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _leftBtn.addEventListener("click",__left);
         _rightBtn.addEventListener("click",__right);
         var _loc3_:int = 0;
         var _loc2_:* = _petsImgVec;
         for each(var _loc1_ in _petsImgVec)
         {
            _loc1_.addEventListener("click",__onClick);
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:PetSmallItem = param1.currentTarget as PetSmallItem;
         if(_loc2_.info)
         {
            PetsBagManager.instance().petModel.currentPetInfo = _loc2_.info;
            _selectedIndex = _petsImgVec.indexOf(_loc2_);
         }
      }
      
      public function updateSelect() : void
      {
         var _loc1_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc4_:int = 0;
         var _loc3_:* = _petsImgVec;
         for each(var _loc2_ in _petsImgVec)
         {
            if(_loc2_.info)
            {
               _loc2_.selected = _loc1_ && _loc1_.ID == _loc2_.info.ID;
               if(_loc2_.selected)
               {
                  _selectedIndex = _petsImgVec.indexOf(_loc2_);
               }
            }
         }
      }
      
      public function get selectedIndex() : int
      {
         return _selectedIndex;
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      private function removeEvent() : void
      {
         _leftBtn.removeEventListener("click",__left);
         _rightBtn.removeEventListener("click",__right);
      }
      
      private function __left(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _totlePage = _infoPlayer.pets.length % 5 == 0?_infoPlayer.pets.length / 5 - 1:Number(_infoPlayer.pets.length / 5);
         _currentPage = _currentPage - 1 < 0?0:Number(_currentPage - 1);
         upCells(_currentPage);
      }
      
      private function __right(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _totlePage = _infoPlayer.pets.length % 5 == 0?_infoPlayer.pets.length / 5 - 1:Number(_infoPlayer.pets.length / 5);
         _currentPage = _currentPage + 1 > _totlePage?_totlePage:_currentPage + 1;
         upCells(_currentPage);
      }
      
      private function upCells(param1:int = 0) : void
      {
         var _loc3_:int = 0;
         _currentPage = param1;
         var _loc2_:int = param1 * 5;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(_infoPlayer.pets[_loc3_ + _loc2_])
            {
               _petsImgVec[_loc3_].info = _infoPlayer.pets[_loc3_ + _loc2_];
            }
            else
            {
               _petsImgVec[_loc3_].info = null;
            }
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(currentPet)
         {
            ObjectUtils.disposeObject(currentPet);
            currentPet = null;
         }
         if(_leftBtn)
         {
            ObjectUtils.disposeObject(_leftBtn);
            _leftBtn = null;
         }
         if(_rightBtn)
         {
            ObjectUtils.disposeObject(_rightBtn);
            _rightBtn = null;
         }
         if(_petBg)
         {
            ObjectUtils.disposeObject(_petBg);
            _petBg = null;
         }
         if(_petBg2)
         {
            ObjectUtils.disposeObject(_petBg2);
            _petBg2 = null;
         }
         if(_petBg0)
         {
            ObjectUtils.disposeObject(_petBg0);
            _petBg0 = null;
         }
         _infoPlayer = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
