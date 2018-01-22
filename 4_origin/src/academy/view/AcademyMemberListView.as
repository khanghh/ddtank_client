package academy.view
{
   import academy.AcademyController;
   import academy.AcademyEvent;
   import academy.AcademyManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class AcademyMemberListView extends Sprite implements Disposeable
   {
      
      public static const ITEM_NUM:int = 12;
       
      
      private var _rightBg:Scale9CornerImage;
      
      private var _rightViewBg:MovieClip;
      
      private var _pagePreBg:ScaleBitmapImage;
      
      private var _pageLastBg:Scale9CornerImage;
      
      private var _searchBG:Scale9CornerImage;
      
      private var _masterTitle:SimpleBitmapButton;
      
      private var _apprenticeTitle:SimpleBitmapButton;
      
      private var _searchBtn:TextButton;
      
      private var _titleline1:ScaleBitmapImage;
      
      private var _titleline2:ScaleBitmapImage;
      
      private var _titleline3:ScaleBitmapImage;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _freeBtn:TextButton;
      
      private var _nameTitle:FilterFrameText;
      
      private var _levelTitle:FilterFrameText;
      
      private var _stateTitle:FilterFrameText;
      
      private var _fightpowerTitle:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _searchTxt:TextInput;
      
      private var _items:Vector.<AcademyMemberItem>;
      
      private var _list:VBox;
      
      private var _controller:AcademyController;
      
      private var _currentPage:int = 1;
      
      private var _selectedItem:AcademyMemberItem;
      
      private var _takeMasterBtn:BaseButton;
      
      private var _takeStudentBtn:BaseButton;
      
      private var _isShowSearchInfo:Boolean = false;
      
      private var _timer:TimerJuggler;
      
      public function AcademyMemberListView(param1:AcademyController)
      {
         super();
         _controller = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtAcademyPlayerPanel.rightBg");
         addChild(_rightBg);
         _rightViewBg = ClassUtils.CreatInstance("asset.ddtacademy.rightListBgAsset") as MovieClip;
         PositionUtils.setPos(_rightViewBg,"AcademyMemberListView.rightListBg");
         addChild(_rightViewBg);
         _nameTitle = ComponentFactory.Instance.creatComponentByStylename("ddtacademy.nameTitle");
         _nameTitle.text = LanguageMgr.GetTranslation("itemview.listname");
         addChild(_nameTitle);
         _levelTitle = ComponentFactory.Instance.creatComponentByStylename("ddtacademy.levelTitle");
         _levelTitle.text = LanguageMgr.GetTranslation("itemview.listlevel");
         addChild(_levelTitle);
         _fightpowerTitle = ComponentFactory.Instance.creatComponentByStylename("ddtacademy.fightpowerTitle");
         _fightpowerTitle.text = LanguageMgr.GetTranslation("itemview.listfightpower");
         addChild(_fightpowerTitle);
         _stateTitle = ComponentFactory.Instance.creatComponentByStylename("ddtacademy.stateTitle");
         _stateTitle.text = LanguageMgr.GetTranslation("itemview.liststate");
         addChild(_stateTitle);
         _titleline1 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.formIineBig1");
         addChild(_titleline1);
         _titleline2 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.formIineBig2");
         addChild(_titleline2);
         _titleline3 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.formIineBig3");
         addChild(_titleline3);
         _masterTitle = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.MasterTitleBg");
         addChild(_masterTitle);
         _apprenticeTitle = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.ApprenticeTitleBg");
         addChild(_apprenticeTitle);
         _searchBG = ComponentFactory.Instance.creatComponentByStylename("ddtacademy.searchBg");
         addChild(_searchBG);
         _pagePreBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtacademy.pagePreBg");
         addChild(_pagePreBg);
         _pageLastBg = ComponentFactory.Instance.creatComponentByStylename("ddtacademy.pageLastBg");
         addChild(_pageLastBg);
         _pageTxt = ComponentFactory.Instance.creat("academy.AcademyMemberListView.page");
         addChild(_pageTxt);
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyMemberListView.searchBtn");
         _searchBtn.text = LanguageMgr.GetTranslation("civil.rightview.searchBtnTxt");
         addChild(_searchBtn);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyMemberListView.preBtn");
         addChild(_preBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyMemberListView.nextBtn");
         addChild(_nextBtn);
         _takeStudentBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyMemberListView.takeStudentBtn");
         addChild(_takeStudentBtn);
         _takeMasterBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyMemberListView.takeMasterBtn");
         addChild(_takeMasterBtn);
         _freeBtn = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyMemberListView.freeBtn");
         _freeBtn.text = LanguageMgr.GetTranslation("academy.rightview.freeBtnTxt");
         addChild(_freeBtn);
         _searchTxt = ComponentFactory.Instance.creat("academy.ddtAcademyMemberListView.searchText");
         _searchTxt.text = LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt");
         addChild(_searchTxt);
         _list = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyMemberListView.List");
         addChild(_list);
         creatItems();
         _controller.model.state = PlayerManager.Instance.Self.Grade >= 21?true:false;
         _timer = TimerManager.getInstance().addTimerJuggler(500,1);
      }
      
      private function initEvent() : void
      {
         _takeMasterBtn.addEventListener("click",__takeMasterClick);
         _takeStudentBtn.addEventListener("click",__takeStudentClick);
         _searchBtn.addEventListener("click",__searchBtnClick);
         _preBtn.addEventListener("click",__leafBtnClick);
         _nextBtn.addEventListener("click",__leafBtnClick);
         _freeBtn.addEventListener("click",__freeBtnClick);
         _controller.addEventListener("AcademyUpdateList",__updateList);
         _searchTxt.addEventListener("click",__searchTxtClick);
         AcademyManager.Instance.addEventListener("selfDescribe",__selfDescribe);
         _timer.addEventListener("timerComplete",__register);
      }
      
      private function removeEvent() : void
      {
         _takeMasterBtn.removeEventListener("click",__takeMasterClick);
         _takeStudentBtn.removeEventListener("click",__takeStudentClick);
         _searchBtn.removeEventListener("click",__searchBtnClick);
         _preBtn.removeEventListener("click",__leafBtnClick);
         _nextBtn.removeEventListener("click",__leafBtnClick);
         _freeBtn.removeEventListener("click",__freeBtnClick);
         _controller.removeEventListener("AcademyUpdateList",__updateList);
         _searchTxt.removeEventListener("click",__searchTxtClick);
         AcademyManager.Instance.removeEventListener("selfDescribe",__selfDescribe);
         _timer.removeEventListener("timerComplete",__register);
      }
      
      private function __selfDescribe(param1:Event) : void
      {
         if(_takeMasterBtn.visible && !AcademyManager.Instance.selfIsRegister)
         {
            _takeMasterBtn.visible = false;
            _takeStudentBtn.visible = true;
         }
      }
      
      private function __searchTxtClick(param1:MouseEvent) : void
      {
         if(_searchTxt.text == LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt"))
         {
            _searchTxt.text = "";
         }
         else
         {
            _searchTxt.textField.setSelection(0,_searchTxt.text.length);
         }
      }
      
      private function creatItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _items = new Vector.<AcademyMemberItem>();
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new AcademyMemberItem(_loc2_);
            _loc1_.visible = false;
            _loc1_.addEventListener("click",__itemClick);
            _list.addChild(_loc1_);
            _items.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            (_items[_loc1_] as AcademyMemberItem).removeEventListener("click",__itemClick);
            _items[_loc1_].dispose();
            _loc1_++;
         }
         _list.disposeAllChildren();
         _items = null;
      }
      
      private function __updateList(param1:AcademyEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Vector.<AcademyPlayerInfo> = _controller.model.list;
         if(_loc2_.length == 0)
         {
            _isShowSearchInfo = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.registerInfoIII"));
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _items[_loc4_].visible = true;
            _items[_loc4_].info = _loc2_[_loc4_];
            _loc4_++;
         }
         _loc3_ = _loc2_.length;
         while(_loc3_ < 12)
         {
            _items[_loc3_].visible = false;
            _loc3_++;
         }
         if(_selectedItem)
         {
            _selectedItem.isSelect = false;
            _selectedItem = _items[0];
            _selectedItem.isSelect = true;
         }
         else
         {
            _selectedItem = _items[0];
            _selectedItem.isSelect = true;
         }
         updateLeafBtn();
         updateListBG();
         updateRegisterBtn();
      }
      
      private function __takeMasterClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_selectedItem == null)
         {
            return;
         }
         if(AcademyManager.Instance.compareState(_selectedItem.info.info,PlayerManager.Instance.Self))
         {
            AcademyFrameManager.Instance.showAcademyRequestMasterFrame(_selectedItem.info.info);
         }
      }
      
      private function __takeStudentClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_selectedItem == null)
         {
            return;
         }
         if(PlayerManager.Instance.Self.apprenticeshipState != 1 && AcademyManager.Instance.compareState(_selectedItem.info.info,PlayerManager.Instance.Self))
         {
            AcademyFrameManager.Instance.showAcademyRequestApprenticeFrame(_selectedItem.info.info);
         }
      }
      
      private function __freeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AcademyFrameManager.Instance.showAcademyPreviewFrame();
      }
      
      private function __leafBtnClick(param1:MouseEvent) : void
      {
         _timer.reset();
         _timer.start();
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_preBtn !== _loc2_)
         {
            if(_nextBtn === _loc2_)
            {
               _currentPage = Number(_currentPage) + 1;
            }
         }
         else
         {
            _currentPage = Number(_currentPage) - 1;
            if(_currentPage <= 1)
            {
               _currentPage = 1;
            }
         }
         updateLeafBtn();
      }
      
      private function __register(param1:Event) : void
      {
         if(!_isShowSearchInfo || _searchTxt.text == LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt"))
         {
            _controller.loadAcademyMemberList(true,_controller.model.state,_currentPage);
         }
         else
         {
            _controller.loadAcademyMemberList(true,_controller.model.state,_currentPage,_searchTxt.text);
         }
      }
      
      private function updateLeafBtn() : void
      {
         if(_controller.model.totalPage <= 0)
         {
            _takeStudentBtn.enable = false;
            _takeMasterBtn.enable = false;
         }
         else
         {
            _takeStudentBtn.enable = true;
            _takeMasterBtn.enable = true;
         }
         if(_controller.model.totalPage <= 1)
         {
            setButtonState(false,false);
         }
         else if(_currentPage == 1)
         {
            setButtonState(false,true);
         }
         else if(_currentPage == _controller.model.totalPage && _currentPage != 0)
         {
            setButtonState(true,false);
         }
         else
         {
            setButtonState(true,true);
         }
         if(_controller.model.totalPage == 0)
         {
            _pageTxt.text = "1 / 1";
         }
         else
         {
            _pageTxt.text = String(_currentPage) + " / " + String(_controller.model.totalPage);
         }
      }
      
      private function updateListBG() : void
      {
         if(_controller.model.state)
         {
            _masterTitle.visible = false;
            _apprenticeTitle.visible = true;
         }
         else
         {
            _masterTitle.visible = true;
            _apprenticeTitle.visible = false;
         }
      }
      
      private function updateRegisterBtn() : void
      {
         if(PlayerManager.Instance.Self.Grade <= 16)
         {
            _takeMasterBtn.visible = true;
            _takeStudentBtn.visible = false;
         }
         else if(PlayerManager.Instance.Self.Grade >= 21)
         {
            _takeMasterBtn.visible = false;
            _takeStudentBtn.visible = true;
         }
      }
      
      private function setButtonState(param1:Boolean, param2:Boolean) : void
      {
         _preBtn.mouseChildren = param1;
         _preBtn.enable = param1;
         _nextBtn.mouseChildren = param2;
         _nextBtn.enable = param2;
      }
      
      private function __searchBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_searchTxt.text == "" || _searchTxt.text == LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("civil.view.CivilRightView.info"));
         }
         else
         {
            _currentPage = 1;
            _controller.loadAcademyMemberList(true,_controller.model.state,_currentPage,_searchTxt.text);
            _isShowSearchInfo = true;
         }
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_selectedItem)
         {
            _selectedItem = param1.currentTarget as AcademyMemberItem;
         }
         if(_selectedItem != param1.currentTarget as AcademyMemberItem)
         {
            _selectedItem.isSelect = false;
         }
         _selectedItem = param1.currentTarget as AcademyMemberItem;
         _selectedItem.isSelect = true;
         _controller.currentAcademyInfo = _selectedItem.info;
      }
      
      public function dispose() : void
      {
         removeEvent();
         cleanItem();
         if(_timer != null)
         {
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
         if(_list)
         {
            _list.dispose();
            _list = null;
         }
         if(_rightViewBg)
         {
            ObjectUtils.disposeObject(_rightViewBg);
            _rightViewBg = null;
         }
         if(_searchBG)
         {
            ObjectUtils.disposeObject(_searchBG);
            _searchBG = null;
         }
         if(_pagePreBg)
         {
            ObjectUtils.disposeObject(_pagePreBg);
            _pagePreBg = null;
         }
         if(_pageLastBg)
         {
            ObjectUtils.disposeObject(_pageLastBg);
            _pageLastBg = null;
         }
         if(_nameTitle)
         {
            ObjectUtils.disposeObject(_nameTitle);
            _nameTitle = null;
         }
         if(_levelTitle)
         {
            ObjectUtils.disposeObject(_levelTitle);
            _levelTitle = null;
         }
         if(_fightpowerTitle)
         {
            ObjectUtils.disposeObject(_fightpowerTitle);
            _fightpowerTitle = null;
         }
         if(_stateTitle)
         {
            ObjectUtils.disposeObject(_stateTitle);
            _stateTitle = null;
         }
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
            _pageTxt = null;
         }
         if(_searchBtn)
         {
            _searchBtn.dispose();
            _searchBtn = null;
         }
         if(_preBtn)
         {
            _preBtn.dispose();
            _preBtn = null;
         }
         if(_nextBtn)
         {
            _nextBtn.dispose();
            _nextBtn = null;
         }
         if(_takeMasterBtn)
         {
            _takeMasterBtn.dispose();
            _takeMasterBtn = null;
         }
         if(_searchTxt)
         {
            _searchTxt.dispose();
            _searchTxt = null;
         }
         if(_freeBtn)
         {
            _freeBtn.dispose();
            _freeBtn = null;
         }
         if(_selectedItem)
         {
            _selectedItem.dispose();
            _selectedItem = null;
         }
         if(_rightBg)
         {
            _rightBg.dispose();
         }
         if(_masterTitle)
         {
            ObjectUtils.disposeObject(_masterTitle);
            _masterTitle = null;
         }
         if(_apprenticeTitle)
         {
            ObjectUtils.disposeObject(_apprenticeTitle);
            _apprenticeTitle = null;
         }
         if(_takeStudentBtn)
         {
            _takeStudentBtn.dispose();
            _takeStudentBtn = null;
         }
         if(_titleline1)
         {
            _titleline1.dispose();
            _titleline1 = null;
         }
         if(_titleline2)
         {
            _titleline2.dispose();
            _titleline2 = null;
         }
         if(_titleline3)
         {
            _titleline3.dispose();
            _titleline3 = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
