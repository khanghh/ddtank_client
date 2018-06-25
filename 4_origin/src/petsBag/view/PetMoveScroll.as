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
      
      public function set infoPlayer(value:PlayerInfo) : void
      {
         _infoPlayer = value;
         if(!_infoPlayer)
         {
            return;
         }
         upCells(_currentPage);
         updateSelect();
      }
      
      public function refreshPetInfo(updateInfo:PetInfo, opType:int = 0) : void
      {
         if(opType == 0 || opType == 1)
         {
            _infoPlayer.pets[updateInfo.Place] = updateInfo;
         }
         upCells(_currentPage);
         if(opType == 2)
         {
            removePetPageUpdate();
         }
         updateSelect();
      }
      
      private function removePetPageUpdate() : void
      {
         var count:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _petsImgVec;
         for each(var petSmallItem in _petsImgVec)
         {
            if(petSmallItem.info)
            {
               count++;
            }
         }
         if(count == 0)
         {
            _currentPage = _currentPage - 1 < 0?0:Number(_currentPage - 1);
            _totlePage = _infoPlayer.pets.length % 5 == 0?_infoPlayer.pets.length / 5 - 1:Number(_infoPlayer.pets.length / 5);
            upCells(_currentPage);
         }
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var cell:* = null;
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
         for(i = 0; i < 5; )
         {
            cell = new PetSmallItem();
            _petsImgVec.push(itemContainer.addChild(cell));
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _leftBtn.addEventListener("click",__left);
         _rightBtn.addEventListener("click",__right);
         var _loc3_:int = 0;
         var _loc2_:* = _petsImgVec;
         for each(var petItem in _petsImgVec)
         {
            petItem.addEventListener("click",__onClick);
         }
      }
      
      private function __onClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var item:PetSmallItem = event.currentTarget as PetSmallItem;
         if(item.info)
         {
            PetsBagManager.instance().petModel.currentPetInfo = item.info;
            _selectedIndex = _petsImgVec.indexOf(item);
         }
      }
      
      public function updateSelect() : void
      {
         var _info:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc4_:int = 0;
         var _loc3_:* = _petsImgVec;
         for each(var petItem in _petsImgVec)
         {
            if(petItem.info)
            {
               petItem.selected = _info && _info.ID == petItem.info.ID;
               if(petItem.selected)
               {
                  _selectedIndex = _petsImgVec.indexOf(petItem);
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
      
      private function __left(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _totlePage = _infoPlayer.pets.length % 5 == 0?_infoPlayer.pets.length / 5 - 1:Number(_infoPlayer.pets.length / 5);
         _currentPage = _currentPage - 1 < 0?0:Number(_currentPage - 1);
         upCells(_currentPage);
      }
      
      private function __right(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _totlePage = _infoPlayer.pets.length % 5 == 0?_infoPlayer.pets.length / 5 - 1:Number(_infoPlayer.pets.length / 5);
         _currentPage = _currentPage + 1 > _totlePage?_totlePage:_currentPage + 1;
         upCells(_currentPage);
      }
      
      private function upCells(page:int = 0) : void
      {
         var i:int = 0;
         _currentPage = page;
         var start:int = page * 5;
         for(i = 0; i < 5; )
         {
            if(_infoPlayer.pets[i + start])
            {
               _petsImgVec[i].info = _infoPlayer.pets[i + start];
            }
            else
            {
               _petsImgVec[i].info = null;
            }
            i++;
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
