package civil.view
{
   import civil.CivilController;
   import civil.CivilEvent;
   import civil.CivilModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CivilRightView extends Sprite implements Disposeable
   {
       
      
      private var _listBg:MovieClip;
      
      private var _bg:ScaleBitmapImage;
      
      private var _goldLinBg:ScaleBitmapImage;
      
      private var _formIineBig1:ScaleBitmapImage;
      
      private var _formIineBig2:ScaleBitmapImage;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _addBigBtn:SimpleBitmapButton;
      
      private var _pagePreBg:ScaleBitmapImage;
      
      private var _nameTitle:FilterFrameText;
      
      private var _levelTitle:FilterFrameText;
      
      private var _stateTitle:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageLastBg:Scale9CornerImage;
      
      private var _searchBG:Scale9CornerImage;
      
      private var _civilGenderGroup:SelectedButtonGroup;
      
      private var _maleBtn:SelectedButton;
      
      private var _femaleBtn:SelectedButton;
      
      private var _searchBtn:TextButton;
      
      private var _registerBtn:TextButton;
      
      private var _menberList:CivilPlayerInfoList;
      
      private var _controller:CivilController;
      
      private var _currentPage:int = 1;
      
      private var _model:CivilModel;
      
      private var _searchTxt:TextInput;
      
      private var _sex:Boolean;
      
      private var _loadMember:Boolean = false;
      
      private var _seachKey:String = "";
      
      private var _isBusy:Boolean;
      
      public function CivilRightView(param1:CivilController, param2:CivilModel)
      {
         _model = param2;
         _controller = param1;
         super();
         init();
         initButton();
         initEvnet();
         _menberList.MemberList(_model.civilPlayers);
         if(PlayerManager.Instance.Self.MarryInfoID <= 0 || !PlayerManager.Instance.Self.MarryInfoID)
         {
            SocketManager.Instance.out.sendRegisterInfo(PlayerManager.Instance.Self.ID,true,LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.text"));
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_listBg)
         {
            removeChild(_listBg);
         }
         if(_formIineBig1)
         {
            _formIineBig1.dispose();
         }
         if(_formIineBig2)
         {
            _formIineBig2.dispose();
         }
         if(_preBtn)
         {
            _preBtn.dispose();
            _preBtn = null;
         }
         if(_pagePreBg)
         {
            _pagePreBg.dispose();
            _pagePreBg = null;
         }
         if(_pageLastBg)
         {
            _pageLastBg.dispose();
            _pageLastBg = null;
         }
         if(_nextBtn)
         {
            _nextBtn.dispose();
            _nextBtn = null;
         }
         if(_bg)
         {
            _bg.dispose();
            _bg = null;
         }
         if(_goldLinBg)
         {
            _goldLinBg.dispose();
            _goldLinBg = null;
         }
         if(_registerBtn)
         {
            _registerBtn.dispose();
            _registerBtn = null;
         }
         if(_addBigBtn)
         {
            _addBigBtn.dispose();
            _addBigBtn = null;
         }
         if(_searchBtn)
         {
            _searchBtn.dispose();
            _searchBtn = null;
         }
         if(_femaleBtn)
         {
            _femaleBtn.dispose();
            _femaleBtn = null;
         }
         if(_maleBtn)
         {
            _maleBtn.dispose();
            _maleBtn = null;
         }
         if(_civilGenderGroup)
         {
            _civilGenderGroup.dispose();
            _civilGenderGroup = null;
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
         if(_stateTitle)
         {
            ObjectUtils.disposeObject(_stateTitle);
            _stateTitle = null;
         }
         if(_searchBG)
         {
            ObjectUtils.disposeObject(_searchBG);
            _searchBG = null;
         }
         if(_searchTxt)
         {
            ObjectUtils.disposeObject(_searchTxt);
            _searchTxt = null;
         }
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
            _pageTxt = null;
         }
         if(_menberList)
         {
            ObjectUtils.disposeObject(_menberList);
            _menberList = null;
         }
      }
      
      public function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.rightView.bg");
         addChild(_bg);
         _goldLinBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.goldlinebg");
         addChild(_goldLinBg);
         _listBg = ClassUtils.CreatInstance("asset.ddtcivil.rightListBgAsset") as MovieClip;
         PositionUtils.setPos(_listBg,"ddtcivil.rightListBg");
         addChild(_listBg);
         _formIineBig1 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.formIineBig1");
         addChild(_formIineBig1);
         _formIineBig2 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.formIineBig2");
         addChild(_formIineBig2);
         _nameTitle = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.nameTitle");
         _nameTitle.text = LanguageMgr.GetTranslation("itemview.listname");
         addChild(_nameTitle);
         _levelTitle = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.levelTitle");
         _levelTitle.text = LanguageMgr.GetTranslation("itemview.listlevel");
         addChild(_levelTitle);
         _stateTitle = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.stateTitle");
         _stateTitle.text = LanguageMgr.GetTranslation("itemview.liststate");
         addChild(_stateTitle);
         _searchBG = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.searchBg");
         addChild(_searchBG);
         _searchTxt = ComponentFactory.Instance.creat("ddtcivil.searchText");
         _searchTxt.text = LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt");
         addChild(_searchTxt);
         _menberList = ComponentFactory.Instance.creatCustomObject("civil.view.CivilPlayerInfoList");
         _menberList.model = _model;
         addChild(_menberList);
         _pagePreBg = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.pagePreBg");
         addChild(_pagePreBg);
         _pageLastBg = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.pageLastBg");
         addChild(_pageLastBg);
         _pageTxt = ComponentFactory.Instance.creat("ddtcivil.page");
         addChild(_pageTxt);
      }
      
      private function initButton() : void
      {
         _civilGenderGroup = new SelectedButtonGroup();
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.searchBtn");
         _searchBtn.text = LanguageMgr.GetTranslation("civil.rightview.searchBtnTxt");
         addChild(_searchBtn);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.preBtn");
         addChild(_preBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.nextBtn");
         addChild(_nextBtn);
         _registerBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.registerTxtBtn");
         _registerBtn.text = LanguageMgr.GetTranslation("civil.rightview.registerBtnTxt");
         addChild(_registerBtn);
         _addBigBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.addBigTxtBtn");
         addChild(_addBigBtn);
         _maleBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.maleButton");
         _femaleBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.femaleButton");
         addChild(_maleBtn);
         addChild(_femaleBtn);
         _civilGenderGroup.addSelectItem(_maleBtn);
         _civilGenderGroup.addSelectItem(_femaleBtn);
      }
      
      private function initEvnet() : void
      {
         _preBtn.addEventListener("click",__leafBtnClick);
         _nextBtn.addEventListener("click",__leafBtnClick);
         _searchBtn.addEventListener("click",__leafBtnClick);
         _maleBtn.addEventListener("click",__sexBtnClick);
         _femaleBtn.addEventListener("click",__sexBtnClick);
         _registerBtn.addEventListener("click",__btnClick);
         _addBigBtn.addEventListener("click",__addBtnClick);
         _searchTxt.addEventListener("click",__searchTxtClick);
         _menberList.addEventListener("selected_change",__memberSelectedChange);
         _model.addEventListener("civilplayerinfoarraychange",__updateView);
         _model.addEventListener("register_change",__onRegisterChange);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",__leafBtnClick);
         _nextBtn.removeEventListener("click",__leafBtnClick);
         _searchBtn.removeEventListener("click",__leafBtnClick);
         _maleBtn.removeEventListener("click",__sexBtnClick);
         _femaleBtn.removeEventListener("click",__sexBtnClick);
         _searchTxt.removeEventListener("click",__searchTxtClick);
         _menberList.removeEventListener("selected_change",__memberSelectedChange);
         _registerBtn.removeEventListener("click",__btnClick);
         _addBigBtn.removeEventListener("click",__addBtnClick);
         _model.removeEventListener("civilplayerinfoarraychange",__updateView);
         _model.removeEventListener("register_change",__onRegisterChange);
      }
      
      private function __onRegisterChange(param1:CivilEvent) : void
      {
      }
      
      private function __btnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controller.Register();
      }
      
      private function __addBtnClick(param1:MouseEvent) : void
      {
         if(_controller.currentcivilInfo && _controller.currentcivilInfo.info)
         {
            SoundManager.instance.play("008");
            IMManager.Instance.addFriend(_controller.currentcivilInfo.info.NickName);
         }
      }
      
      private function __sexBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _currentPage = 1;
         if(param1.currentTarget == _femaleBtn)
         {
            _sex = false;
            if(_sex == _model.sex)
            {
               return;
            }
            _model.sex = false;
         }
         else
         {
            _sex = true;
            if(_sex == _model.sex)
            {
               return;
            }
            _model.sex = true;
         }
         _sex = _model.sex;
         _controller.loadCivilMemberList(_currentPage,_model.sex);
         if(_searchTxt.text != LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt"))
         {
            _searchTxt.text = "";
         }
         else
         {
            _searchTxt.text = LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt");
         }
         _seachKey = "";
      }
      
      private function __leafBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_loadMember)
         {
            return;
         }
         if(_isBusy)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(_preBtn !== _loc2_)
         {
            if(_nextBtn !== _loc2_)
            {
               if(_searchBtn === _loc2_)
               {
                  if(_searchTxt.text == "" || _searchTxt.text == LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt"))
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("civil.view.CivilRightView.info"));
                  }
                  else
                  {
                     _seachKey = _searchTxt.text;
                     _currentPage = 1;
                     _controller.loadCivilMemberList(_currentPage,_sex,_seachKey);
                     _loadMember = true;
                  }
                  return;
               }
            }
            else
            {
               _currentPage = _currentPage + 1;
               _currentPage = _currentPage + 1;
            }
         }
         else
         {
            _currentPage = _currentPage - 1;
            _currentPage = _currentPage - 1;
         }
         _isBusy = true;
         _controller.loadCivilMemberList(_currentPage,_sex,_seachKey);
      }
      
      private function __searchTxtClick(param1:MouseEvent) : void
      {
         if(_searchTxt.text == LanguageMgr.GetTranslation("academy.view.AcademyMemberListView.searchTxt"))
         {
            _searchTxt.text = "";
         }
      }
      
      private function __memberSelectedChange(param1:CivilEvent) : void
      {
         if(param1.data)
         {
            _addBigBtn.enable = _menberList.selectedItem.info.UserId == PlayerManager.Instance.Self.ID?false:true;
         }
      }
      
      private function updateButton() : void
      {
         if(_model.TotalPage == 1)
         {
            setButtonState(false,false);
         }
         else if(_model.TotalPage == 0)
         {
            setButtonState(false,false);
         }
         else if(_currentPage == 1)
         {
            setButtonState(false,true);
         }
         else if(_currentPage == _model.TotalPage && _currentPage != 0)
         {
            setButtonState(true,false);
         }
         else
         {
            setButtonState(true,true);
         }
         if(!_model.TotalPage)
         {
            _pageTxt.text = "1 / 1";
         }
         else
         {
            _pageTxt.text = String(_currentPage) + " / " + String(_model.TotalPage);
         }
         _addBigBtn.enable = _addBigBtn.enable && _model.civilPlayers.length > 0?true:false;
         updateSex();
      }
      
      private function updateSex() : void
      {
         if(_model.sex)
         {
            _civilGenderGroup.selectIndex = 0;
         }
         else
         {
            _civilGenderGroup.selectIndex = 1;
         }
         _sex = _model.sex;
      }
      
      private function __updateRegisterGlow(param1:CivilEvent) : void
      {
      }
      
      private function setButtonState(param1:Boolean, param2:Boolean) : void
      {
         _preBtn.mouseChildren = param1;
         _preBtn.enable = param1;
         _nextBtn.mouseChildren = param2;
         _nextBtn.enable = param2;
      }
      
      private function __updateView(param1:CivilEvent) : void
      {
         _isBusy = false;
         updateButton();
         _loadMember = false;
      }
   }
}
