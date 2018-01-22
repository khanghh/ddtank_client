package farm.viewx
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FramFriendStateInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import petsBag.PetsBagManager;
   import road7th.data.DictionaryEvent;
   
   public class FarmFriendListView extends Sprite implements Disposeable
   {
       
      
      private var _list:ListPanel;
      
      private var _switchAsset:ScaleFrameImage;
      
      private var isOpen:Boolean = true;
      
      private var _listBG:Scale9CornerImage;
      
      private var _listBound:ScaleBitmapImage;
      
      private var _hBox:HBox;
      
      private var _poultryBtn:SelectedTextButton;
      
      private var _stealBtn:SelectedTextButton;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _tabBitmap:Bitmap;
      
      private var _switchTween:TweenLite;
      
      public function FarmFriendListView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _listBG = ComponentFactory.Instance.creatComponentByStylename("farm.friendListBg");
         addChild(_listBG);
         _listBound = ComponentFactory.Instance.creatComponentByStylename("farm.friendListBound");
         addChild(_listBound);
         _switchAsset = ComponentFactory.Instance.creatComponentByStylename("farm.listSwitch");
         _switchAsset.buttonMode = true;
         if(isOpen)
         {
            _switchAsset.setFrame(1);
         }
         addChild(_switchAsset);
         _tabBitmap = ComponentFactory.Instance.creat("asset.farm.selectTab");
         addChild(_tabBitmap);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("farm.farmFriendListPanel.btnHbox");
         addChild(_hBox);
         _stealBtn = ComponentFactory.Instance.creatComponentByStylename("farm.farmFriendListPanel.poultrySelectBtn");
         _stealBtn.text = LanguageMgr.GetTranslation("farm.friendListPanel.stealBtnText");
         _hBox.addChild(_stealBtn);
         _poultryBtn = ComponentFactory.Instance.creatComponentByStylename("farm.farmFriendListPanel.poultrySelectBtn");
         _poultryBtn.text = LanguageMgr.GetTranslation("farm.friendListPanel.poultryText");
         _hBox.addChild(_poultryBtn);
         _selectedButtonGroup = new SelectedButtonGroup();
         _selectedButtonGroup.addSelectItem(_stealBtn);
         _selectedButtonGroup.addSelectItem(_poultryBtn);
         _selectedButtonGroup.selectIndex = 0;
         FarmModelController.instance.model.SelectIndex = _selectedButtonGroup.selectIndex;
         _hBox.arrange();
         _list = ComponentFactory.Instance.creat("asset.farm.farmFriendListPanel");
         _list.vScrollProxy = 1;
         addChild(_list);
         _list.list.updateListView();
         switchView();
         update();
      }
      
      private function initEvent() : void
      {
         _selectedButtonGroup.addEventListener("change",__onBtnGroupChange);
         PlayerManager.Instance.addEventListener("friendListComplete",__friendlistHandler);
         FarmModelController.instance.addEventListener("friendInfoReady",__infoReady);
         FarmModelController.instance.addEventListener("friendList_updateStolen",__updateFriendListStolen);
         _switchAsset.addEventListener("click",__onClick);
         _switchAsset.addEventListener("mouseOver",__overHandler);
         _switchAsset.addEventListener("mouseOut",__outHandler);
         PlayerManager.Instance.friendList.addEventListener("remove",__playerRemove);
      }
      
      protected function __onBtnGroupChange(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         FarmModelController.instance.model.SelectIndex = _selectedButtonGroup.selectIndex;
         FarmModelController.instance.updateSetupFriendListLoader();
      }
      
      protected function __playerRemove(param1:DictionaryEvent) : void
      {
         var _loc2_:FriendListPlayer = param1.data as FriendListPlayer;
         FarmModelController.instance.model.friendStateList.remove(_loc2_.ID);
         update();
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _switchAsset.filters = null;
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         _switchAsset.filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      protected function __friendlistHandler(param1:Event) : void
      {
         update();
      }
      
      protected function __infoReady(param1:FarmEvent) : void
      {
         update();
      }
      
      protected function __updateFriendListStolen(param1:FarmEvent) : void
      {
         var _loc2_:FramFriendStateInfo = FarmModelController.instance.model.friendStateListStolenInfo[FarmModelController.instance.model.currentFarmerId];
         var _loc6_:int = 0;
         var _loc5_:* = _list.list.cell;
         for each(var _loc3_ in _list.list.cell)
         {
            if(_loc3_.info)
            {
               if(_loc3_.info.id == _loc2_.id)
               {
                  _loc3_.setCellValue(_loc2_);
                  break;
               }
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = (_list.list.model as VectorListModel).elements;
         for each(var _loc4_ in (_list.list.model as VectorListModel).elements)
         {
            if(_loc4_.id == _loc2_.id)
            {
               _loc4_.landStateVec = _loc2_.landStateVec;
               _loc4_.isFeed = _loc2_.isFeed;
               break;
            }
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         switchView();
         if(PetsBagManager.instance().haveTaskOrderByID(366))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(114);
         }
      }
      
      private function switchView() : void
      {
         var _loc1_:int = !!isOpen?2:1;
         _switchAsset.setFrame(_loc1_);
         if(isOpen)
         {
            _switchTween = null;
            _switchTween = TweenLite.to(this,0.5,{
               "x":952,
               "ease":Sine.easeInOut
            });
         }
         else
         {
            FarmModelController.instance.updateSetupFriendListLoader();
            _switchTween = null;
            _switchTween = TweenLite.to(this,0.5,{
               "x":773,
               "ease":Sine.easeInOut
            });
         }
         isOpen = _loc1_ == 1?true:false;
      }
      
      private function update() : void
      {
         var _loc1_:* = null;
         _list.vectorListModel.clear();
         var _loc4_:int = 0;
         var _loc3_:* = FarmModelController.instance.model.friendStateList;
         for each(var _loc2_ in FarmModelController.instance.model.friendStateList)
         {
            _loc1_ = _loc2_.playerinfo;
            if(_loc1_)
            {
               _list.vectorListModel.insertElementAt(_loc2_,getInsertIndex(_loc1_));
            }
         }
         _list.list.updateListView();
      }
      
      private function getInsertIndex(param1:PlayerInfo) : int
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = _list.vectorListModel.elements;
         if(_loc3_.length == 0)
         {
            return 0;
         }
         _loc5_ = _loc3_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = (_loc3_[_loc5_] as FramFriendStateInfo).playerinfo;
            if(!(param1.IsVIP && !_loc4_.IsVIP))
            {
               if(!param1.IsVIP && _loc4_.IsVIP)
               {
                  return _loc5_ + 1;
               }
               if(param1.IsVIP == _loc4_.IsVIP)
               {
                  if(param1.Grade > _loc4_.Grade)
                  {
                     _loc2_ = _loc5_ - 1;
                  }
                  else
                  {
                     return _loc5_ + 1;
                  }
               }
            }
            _loc5_--;
         }
         return _loc2_ < 0?0:_loc2_;
      }
      
      private function removeEvent() : void
      {
         _selectedButtonGroup.removeEventListener("change",__onBtnGroupChange);
         PlayerManager.Instance.removeEventListener("friendListComplete",__friendlistHandler);
         FarmModelController.instance.removeEventListener("friendInfoReady",__infoReady);
         FarmModelController.instance.removeEventListener("friendList_updateStolen",__updateFriendListStolen);
         _switchAsset.removeEventListener("click",__onClick);
         _switchAsset.removeEventListener("mouseOver",__overHandler);
         _switchAsset.removeEventListener("mouseOut",__outHandler);
         PlayerManager.Instance.friendList.removeEventListener("remove",__playerRemove);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_switchTween)
         {
            _switchTween.kill();
         }
         _switchTween = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_switchAsset)
         {
            ObjectUtils.disposeObject(_switchAsset);
         }
         _switchAsset = null;
         if(_tabBitmap)
         {
            ObjectUtils.disposeObject(_tabBitmap);
         }
         _tabBitmap = null;
         if(_selectedButtonGroup)
         {
            ObjectUtils.disposeObject(_selectedButtonGroup);
         }
         _selectedButtonGroup = null;
         if(_poultryBtn)
         {
            ObjectUtils.disposeObject(_poultryBtn);
         }
         _poultryBtn = null;
         if(_stealBtn)
         {
            ObjectUtils.disposeObject(_stealBtn);
         }
         _stealBtn = null;
         if(_hBox)
         {
            ObjectUtils.disposeObject(_hBox);
         }
         _hBox = null;
         if(_listBG)
         {
            ObjectUtils.disposeObject(_listBG);
         }
         _listBG = null;
         if(_listBound)
         {
            ObjectUtils.disposeObject(_listBound);
         }
         _listBound = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
